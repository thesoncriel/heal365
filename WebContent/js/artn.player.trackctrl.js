/**
 * 미디어 트랙 제어기.<br/>
 * 설정된 트랙 리스트를 이용하여 BasePlayer 와 연동, 하나의 트랙 종료 시 다음 트랙을 자동으로 수행시키는 역할을 한다.
 * @class
 */
function TrackController(){
    this.player = null;
    this.subtitleCtrl = null;
    this.trackList = [];
    this.index = -1;
    
    this.evt_trackchange = function(index){};//
    this.evt_ended = function(){};
}

TrackController.prototype = {
	/**
	 * 트랙 컨트롤러를 생성한다.<br/>
	 * 생성 시 반드시 BasePlayer를 상속 받은 플레이어 컨트롤러가 필요하다.
	 * @param {BasePlayer} player
	 * @param subtitleCtrl ※ 사용안함.
	 * @param maTrackList ※ 사용안함.
	 * @returns {TrackController}
	 */
    init : function(player, subtitleCtrl, maTrackList){
        this.player = player;
        this.subtitleCtrl = subtitleCtrl;
        this.setTrackList( maTrackList );
        
        player.TrackCtrl = this;
        player.ended(function(){
            this.TrackCtrl.nextTrack();
        });
        
        return this;
    },
    /**
     * 트랙목록을 설정 한다.<br/>
     * 트랙내 구성요소는 제어되는 플레이어마다 다를 수 있다.
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
     * @see ContentManager.setData
     */
    setTrackList : function(maTrackList){
        if (maTrackList === undefined) return;
        
        this.trackList = maTrackList;
        this.changeTrack(0);
    },
    /**
     * 트랙을 변경한다.<br/>
     * 변경된 트랙 정보는 플레이어에 자동으로 설정 된다.<br/>
     * 설정 후 trackchange 이벤트가 수행된다.
     * @param {Integer} index 변경할 트랙의 인덱스.
     * @see BasePlayer.source
     * @see TrackController.trackchange
     */
    changeTrack : function(index){
        if ((this.subtitleCtrl !== undefined) &&
            (this.subtitleCtrl !== null) ){
            this.subtitleCtrl.setData( this.trackList[index].subtitle );
        }
        
        this.player.source( this.trackList[ index ] );
        this.index = index;
        this.ontrackchange(index);
    },
    /**
     * 다음 트랙으로 변경한다.<br/>
     * 트랙 변경이 완료되면 true를, 아니면 false가 반환 된다.
     * @returns {Boolean}
     * @see TrackController.changeTrack
     */
    nextTrack : function(){
        ++this.index;
        
        if (this.trackList.length <= this.index){
            --this.index;
            this.onended();
            return false;
        }
        else{
            this.changeTrack(this.index);
            return true;
        }
    },
    /**
     * 이전 트랙으로 변경한다.<br/>
     * 트랙 변경이 완료되면 true를, 아니면 false가 반환 된다.
     * @returns {Boolean}
     * @see TrackController.changeTrack
     */
    prevTrack : function(){
        --this.index;
        
        if (0 > this.index){
            this.index = 0;
            return false;
        }
        else{
            this.changeTrack(this.index);
            return true;
        }
    },
    /**
     * 모든 트랙이 종료 되었을 때 수행되는 이벤트.
     * @param {function} handler
     */
    ended : function(handler){ this.evt_ended = handler; },
    /**
     * 하나의 트랙이 변경 되었을 때 수행되는 이벤트.
     * @param {function} handler
     */
    trackchange : function(handler){ this.evt_trackchange = handler; },
    /**
     * @ignore
     */
    onended : function(){
        this.evt_ended();
    },
    /**
     * @ignore
     */
    ontrackchange : function(index){
        this.evt_trackchange(index);
    }
};