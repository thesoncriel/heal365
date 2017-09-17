
/**
 * 미디어 재생부를 총괄하고 관리하는 클래스.<br/>
 * ContentManager는 다음과 같은 일을 수행한다.
 * <ol>
 * <li>재생 후 다시재생 여부를 확인하는 다이얼로그 생성</li>
 * <li>미디어 정보 설정 시 플레이어, 트랙컨트롤러, 썸네일 생성</li>
 * 
 * </ol>
 * @class
 */
function ContentManager(){
    this.player = null;
    this.trackctrl = null;
    this.thumblist = null;
    this.mediactrl = null;
    this.category = "";
    this.dialog = $("#dialog_PlayerConfirm");
}

ContentManager.prototype = {
	/**
	 * 생성자.
	 * @returns {ContentManager}
	 */
    init : function(){
        $("#wrapper_Player").css({
        	"background-color": "#000"
        });
        Artn.Instance["contentmgr"] = this;
        
        this.dialog.dialog({
			modal: true,
			width: 400,
			height: 300,
			autoOpen: false,
			buttons: {
				"다시재생" : function(){
					var inst = Artn.Instance["contentmgr"];
					
					$(this).dialog("close");
					
					if (inst.category !== "SF"){
						inst.trackctrl.changeTrack(0);
					}
					
					inst.player.play();
				},
				"돌아가기" : function(){
					$(this).dialog("close");
					if ($("input[name='menu']").val() === "365plus"){
						location.href = "/user/menu";
					}
					else{
						history.back();
					}
					
				}
			}
		});

        return this;
    },
    /**
     * 카테고리 값에 따라 미디어 컨트롤러들을 생성하고 멤버에 설정한다.<br/>
     * 생성되는 컨트롤은 다음과 같다.
     * <ul>
     * <li>Player</li>
     * <li>TrackController</li>
     * <li>Thumbnail List</li>
     * <li>Media Controller (현재는 쓰이지 않음)</li>
     * </ul>
     * @param {String} strCategory 업무 카테고리. 값에 따라 <b>SF=365Plus, HL=처방전 영상조합</b>와 같이 업무가 정의된다.
     * @see BasePlayer
     * @see TrackController
     * @see ThumbnailList
     */
    createControls : function(strCategory){
    	this.category = strCategory;
    	this.player = this.createPlayer( strCategory ).init("wrapper_Player", {
    		//width: 640, 
    		//height: 360,
    		autoPlay: true
    	})
    	.mediastart(function(player, data){
    		$("#currentRepeat span").html(data.repeatInfo);
    	});
        this.trackctrl = this.createTrackCtrl( strCategory ).init( this.player );
        this.thumblist = new ThumbnailList().init(
            "imageList_Thumbnail", {    
            visibility : ( (strCategory === "SF")? "hidden" : "visible" ),
            itemWidth : 140,
            itemTextLimit : {key: "subject_movie", limit: 10}, 
            itemKeys : ["file_img", "subject_movie"],
            click : function(index){
                this.trackctrl.changeTrack(index);
            }
        });
        this.thumblist.trackctrl = this.trackctrl;
        this.mediactrl = new MediaController().init( this.player, this.trackctrl );
        
        
        this.trackctrl.trackchange(function(index){
            var instance = Artn.Instance["contentmgr"];
            instance.mediactrl.initCurrTime();
            instance.thumblist.selectedIndex( index );
        });
        this.trackctrl.ended(function(){
            var inst = Artn.Instance["contentmgr"];
            inst.player.pause();
            inst.dialog.dialog("open");
        });
        //this.registRealTimeEventListener();
    },
    /**
     * 업무 카테고리에 따라 플레이어를 만들어 반환한다.
     * @param {String} strCategory 업무 카테고리. <b>SF=365Plus, HL=처방전 영상조합</b>
     * @returns {BasePlayer}
     */
    createPlayer : function(strCategory){
    	return (strCategory === "SF")? new MoviePlayer() : new HealingPlayer();
    },
    /**
     * 업무 카테고리에 따라 트랙컨트롤러를 만들어 반환한다.
     * @param {String} strCategory 업무 카테고리. <b>SF=365Plus, HL=처방전 영상조합</b>
     * @returns {TrackController}
     */
    createTrackCtrl : function(strCategory){
    	return (strCategory === "SF")? new TrackController365Plus() : new TrackController();
    },
    /**
     * 미디어 정보 데이터를 설정한다.<br/>
     * 설정되는 데이터는 다음과 같은 정보를 가지고 있어야 한다.
     * <pre>
{
subject: 제목, 
cate_movie0: HL=조합영상용 | SF=365Plus영상용,
desc: 영상설명(현재는 별도로 출력되지는 않음),
useCount: 이용횟수, 
tracks: [  
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
}
     * </pre>
     * @param jsonData
     */
    setData : function(jsonData){
        var iLen = jsonData.tracks.length;
        var track = null;
        var mConst = Artn.Const.Player;
        
        for(var i = 0; i < iLen; ++i){
            track = jsonData.tracks[i];
            track.file_img_thumb = mConst.PATH_THUMB + track.file_img; 
            track.file_img = mConst.PATH_IMG + track.file_img;
            track.file_webm = mConst.PATH_WEBM + track.file_webm;
            track.file_mp4 = mConst.PATH_MP4 + track.file_mp4;
            track.file_ogg = mConst.PATH_OGG + track.file_ogg;
            track.file_mp3 = mConst.PATH_MP3 + track.file_mp3;
            track.file_mp4narr = mConst.PATH_MP4NARR + track.file_mp4narr;
            
        }
        
        this.createControls(jsonData.cate_movie0);
        this.subject( jsonData.subject );
        this.desc( jsonData.desc );
        this.thumblist.setItems( jsonData.tracks );
        this.trackctrl.setTrackList( jsonData.tracks );
        
        //this.trackctrl.changeTrack(0);
    },
    /**
     * 설정한 URL에서 Ajax 통신하여 미디어 정보가 담긴 JSON을 가져온 뒤, 이 데이터를 기반으로 setData를 수행한다.
     * @param {String} url 미디어 정보 JSON이 담긴 외부 경로.
     * @see ContentManager.setData
     */
    setDataFromUrl : function(url){
    	if (url === undefined) return;
    	
    	if (Artn.Environment.isUnderIE9() === true){
    		$.get(url, function(data){
    			var sData = data;
    			var mData = $.parseJSON( data );
    			Artn.Instance["contentmgr"].setData( mData );
    		});
    	}
    	else{
    		$.getJSON(url, function(data){
                Artn.Instance["contentmgr"].setData( data );
            });
    	}
    },
    /**
     * <h4>프로퍼티</h4>
     * 영상의 제목을 가져오거나 설정한다.
     * @param {String} subject 제목
     * @returns {String}
     */
    subject : function(subject){
        if (subject){
            $("h2.subject").html(subject);
        }
        else{
            return $("h2.subject").html();
        }
    },
    /**
     * <h4>프로퍼티</h4>
     * 영상의 설명을 가져오거나 설정한다.
     * @param {String} desc 영상설명
     * @returns {String}
     */
    desc : function(desc){
        if (desc){
            $("#desc").html(desc);
        }
        else{
            return $("#desc").html();
        }
    },
    /**
     * @ignore 현재 쓰이지 않음.
     * @param subttl
     * @returns
     */
    subtitle : function(subttl){
        if (subttl){
            $("#subtitle").html(subttl);
        }
        else{
            return $("#subtitle").html();
        }
    },
    /**
     * @ignore 사용 안함.
     */
    registRealTimeEventListener : function(){
        Artn.Listener.add(function(){
            var contentmgr = Artn.Instance["contentmgr"]; 
            var iCurrTime = contentmgr.player.currentTime();
            
            contentmgr.mediactrl.setCurrTimeToFormat( iCurrTime );
            
            if (contentmgr.player.paused() === false){
                contentmgr.mediactrl._jqCurrTime.slider("value", iCurrTime);
                // contentmgr.SubtitleCtrl.checkCurrentTime(iCurrTime); //TODO: 자막 처리기 작성 시 함께 작업
            }
        });
    }
};
