/**
 * 365Plus 업무용 트랙 컨트롤러.<br/>
 * 본 업무는 한번에 여러개의 트랙을 거치는 것이 아닌,
 * 하루가 달라지면 다음 트랙을 보여주는 형태로 진행 된다.<br/>
 * 하나의 트랙은 최소1, 최대4개의 영상으로 구분되며,
 * 그 중 최종 사용자에게 보여지는 영상이 선택되는 순서는 다음과 같다.
 * <ol>
 * <li>이전 Step 에서 아픈 부위의 좌/우측을 선택한다: L 또는 R이 선택된다.</li>
 * <li>재생 전 팝업을 띄워 현재 운동이 환자에게 적합한지 여부를 판단한다: yes 또는 no</li>
 * </ol>
 * 위 2가지 경우를 모두 합칠 경우 최대 4가지 영상이 각 트랙마다 존재 할 수 있다.<br/>
 * 그리고 35Plus는 Track-Index가 아닌 nth 값을 이용하여 제어 한다. 
 * 이는 서버에서 사용자가 첫번째 영상을 본 후 다음날 두번째 영상을 재생 시킬 시,
 * 서버가 사용자가 최근에 본 영상이 몇번째(nth)인지 판단하여 그 값을 View(HTML)측에 제시 하고,
 * 그 값에 기준하여 최종 재생 영상이 결정된다.
 * @class
 * @see TackController
 */
function TrackController365Plus(){
	this.dialog = null;
}
TrackController365Plus.prototype = new TrackController();
$.extend(TrackController365Plus.prototype, {
	/**
	 * @ignore
	 */
	constructor : TrackController365Plus,
	
	// override
	/**
	 * 트랙 컨트롤러를 생성한다.<br/>
	 * 생성 시 반드시 BasePlayer를 상속 받은 플레이어 컨트롤러가 필요하다.
	 * @param {BasePlayer} player
	 * @param subtitleCtrl ※ 사용안함.
	 * @param maTrackList ※ 사용안함.
	 * @returns {TrackController365Plus}
	 */
	init : function(player, subtitleCtrl, maTrackList){
		TrackController.prototype.init.call(this, player, subtitleCtrl, maTrackList);
		
		this.dialog = $("#dialog_Popup_365Plus");
		this.dialog.data("inst", this);
		this.index = -1;
		
        // this.player = player;
        // this.subtitleCtrl = subtitleCtrl;
        // this.setTrackList( maTrackList );
//         
        // player.TrackCtrl = this;
        // player.ended(function(){
            // this.TrackCtrl.nextTrack();
        // });
        
        return this;
    },
    // override
    /**
     * 트랙목록을 설정 한다.<br/>
     * 트랙 변경은 input[name='nth'] 요소의 값을 이용하여 적용 된다.
     * @param {List<Map>|Map[]} maTrackList 설정할 트랙 모음.
     * <pre>
[  
	{
	id_movie : 영상ID,
	subject_movie : 영상 제목,
	file_mp4 : MP4 영상 경로,
	file_webm : WEBM 영상 경로,
	file_mp3 : MP3 나레이션 경로,
	file_ogg : OGG 나레이션 경로,
	file_img : 나레이션 이미지 경로,
	id_comb : 조합영상ID,
	repeat_cnt : 반복횟수,
	seq : 영상순서,
	nth : 영상순서(365Plus 전용),
	popup : P=팝업설정됨(365Plus 전용),
	popup_action : 팝업내 버튼에 따른 영상 분기 정보(예: 예,1,아니오2 = '예'누를 시 1번으로, '아니오'누를 시 2번),
	left_right : L=좌측 | R=우측 (365Plus 전용),
	popup_msg : 팝업메시지(365Plus 전용)
	},

	...
]
     * </pre>
     * @see TrackController365Plus.setData
     */
    setTrackList : function(maTrackList){
        if (maTrackList === undefined) return;
        
        this.trackList = maTrackList;
        this.changeNth( $("input[name='nth']").val() );
    },

    /**
     * nth 값을 이용하여 트랙을 제어 한다.
     * @param {String|Integer} strNth 트랙을 선택할 nth값.
     * @param isUserSelected ※ 사용되지 않음.
     */
    changeNth : function(strNth, isUserSelected){
    	var currTrack = this.findTrackByNth(strNth);
    	
    	if (currTrack === null) return;
    	
    	this.processNth( currTrack, isUserSelected );
    },
    /**
     * 설정한 시퀀스값을 통하여 트랙을 제어 한다.
     * @param {Integer} intSeq 시퀀스값.
     */
    gotoMediaBySeq : function(intSeq){
    	var currTrack = null;

    	this.index = intSeq - 1;
    	currTrack = this.trackList[ this.index ];
    	
    	this.processNth( currTrack, true );
    },
    /**
     * nth값을 이용하여 트랙 정보를 찾는다.
     * @param {String|Integer} strNth nth값.
     * @returns {Map}
     */
    findTrackByNth : function(strNth){
    	var iLen = this.trackList.length;
    	var mTrack = null;
    	var sMaxNth = "";
    	
    	for (var i = 0; i < iLen; ++i){
    		mTrack = this.trackList[i];
    		iMaxNth = mTrack.nth;
    		
    		if (mTrack.nth === strNth){
    			this.index = i;
    			return mTrack;
    		}
    	}
    	
    	if (parseInt(sMaxNth) < parseInt(strNth) ){
    		return this.findTrackByNth(sMaxNth);
    	}
    	
    	this.index = 0;
    	return null;
    },
    /**
     * nth값을 통하여 트랙을 제어 하고 영상을 재생 시킨다.<br/>
     * 트랙 정보에 팝업필요 여부가 있을 시 팝업을 출력하여 사용자의 영상 가용 여부를 판단 해 준다.<br/>
     * 그렇지 않다면 좌/우측 정보를 확인하고 관련 영상을 재생 한다.
     * @param {Map} trackInfo 설정할 트랙 정보.
     * @param {Boolean} isUserSelected 사용자가 직접 선택했는지의 여부.
     */
    processNth : function(trackInfo, isUserSelected){
    	if ((trackInfo.popup === "P") && 
    		(isUserSelected === undefined)){
    		this.setPopupInfo( trackInfo );
    	}
    	else{
    		this.gotoLeftOrRight( trackInfo );
    		this.changeTrack( this.index );
    		this.player.play();
    	}
    },
    /**
     * 트랙 정보와 input[name='left_right'] 에 설정된 값을 통하여 좌/우측 정보를 확인하여
     * 재생할 트랙 인덱스를 갱신 한다.
     * @param {Map} trackInfo 함께 확인할 트랙 정보.
     * @returns {Boolean}
     */
    gotoLeftOrRight : function(trackInfo){
    	var sLeftRight = $("input[name='left_right']").val();
    	
    	if ((sLeftRight === "") || (trackInfo.left_right === "")) return true;
	    
	    if (trackInfo.left_right === sLeftRight) return true;
	    	
    	++this.index;

    	return true;
    },
    /**
     * 영상 재생 전 가용여부를 확인하는 팝업을 띄우고 선택된 버튼에 따른 이벤트를 달리 적용 시킨다.<br/>
     *  
     * @param trackInfo
     */
    setPopupInfo : function(trackInfo){
    	var saPopupAction = null;
    	var buttonsEvent = {};
    	
    	saPopupAction = trackInfo.popup_action.split(",");
    	
    	this.buttonSeq = [];
		this.buttonSeq[0] = parseInt( saPopupAction[1] );
		this.buttonSeq[1] = parseInt( saPopupAction[3] );
		
		buttonsEvent[ saPopupAction[0] ] = function(){
			var inst = $(this).data("inst");
			inst.gotoMediaBySeq( inst.buttonSeq[0] );
			$(this).dialog("close");
			$(this).dialog("destroy");
		};
		buttonsEvent[ saPopupAction[2] ] = function(){
			var inst = $(this).data("inst");
			inst.gotoMediaBySeq( inst.buttonSeq[1] );
			$(this).dialog("close");
			$(this).dialog("destroy");
		};
		
		this.dialog.find("p").text( trackInfo.popup_msg );
		
		this.dialog.dialog({
			modal: true,
			width: 400,
			height: 300,
			buttons: buttonsEvent
		});
		
		this.dialog.dialog("open");
    },
    // override
    nextTrack : function(){
    	if (this.index > -1){
    		this.onended();
    		return false;
    	} 
    	return true;
        // ++this.index;
//         
        // if (this.trackList.length <= this.index){
            // --this.index;
            // this.onended();
            // return false;
        // }
        // else{
            // this.changeTrack(this.index);
            // return true;
        // }
    },
    // override
    prevTrack : function(){
    	return false;
        // --this.index;
//         
        // if (0 > this.index){
            // this.index = 0;
            // return false;
        // }
        // else{
            // this.changeTrack(this.index);
            // return true;
        // }
    }
});
