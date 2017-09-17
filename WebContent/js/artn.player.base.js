var Artn = Artn || {};
/**
 * @ignore
 */
Artn.EventType = {
    EVENT_LOADEDDATA : 0,
    EVENT_ENDED : 1,
    EVENT_STARTED : 2,
    EVENT_PAUSE : 3
};

/**
 * 미디어 플레이어의 기본적인 공통 기능이 갖춰진 최상위 클래스.
 * @class
 */
function BasePlayer(){
	this.classname = "BasePlayer";
    this.context = null;
    this._jqPlayer = null;
    this._duration = 0;
    this._currentTime = 0;
    this._autoPlay = false;
    
    this.evt_mutechange = function(isMute){};
    this.evt_playchange = function(isPlay){};
    this.evt_sourcechange = function(){};
    this.evt_durationchange = function(duration){};
}
BasePlayer.prototype = {
	/**
	 * 플레이어 생성자.
	 * @param {String} strId 플레이어로 적용 할 요소
	 * @param {Map} opt 플레이어 생성 시 필요한 옵션들.<br/>
	 * <pre>
{
	autoPlay: 자동재생 여부(true|false)
}
	 * </pre>
	 * @returns {BasePlayer}
	 */
    init : function(strId, opt){
        this.context = document.getElementById(strId);
        this._jqPlayer = $(this.context);
        $.data( this.context, "player", this );
        
        this._jqPlayer.bind("loadeddata", this.onDurationChange);
        //this.width( opt.width || this._jqPlayer.attr("width") );
        //this.height( opt.height || this._jqPlayer.attr("height") );
        this.autoPlay( opt.autoPlay || (this._jqPlayer.attr("autoplay") === true) );
        
        return this;
    },
    /**
     * 미디어를 재생한다.
     */
    play : function(){
        this.context.play();
        this.onplaychange(true); 
    },
    /**
     * 미디어 재생을 멈춘다.
     */
    stop : function(){
        this._video.currentTime = 0;
        this._video.pause();
        //this.SubtitleCtrl.init();
        //this._jqCurrTime.slider("value", 0);
        //$("#subtitles").text("");
    },
    /**
     * 미디어 재생을 일시 정지 시킨다.
     */
    pause : function(){ 
        this.context.pause(); 
        this.onplaychange(false); 
    },
    /**
     * <h4>프로퍼티</h4>
     * 미디어 소스(source) 설정 시 곧바로 재생하는지의 여부를 설정하거나 가져 온다.
     * @param {Boolean} auto
     * @returns {Boolean}
     */
    autoPlay : function(auto){
    	if (auto !== undefined){
    		this._autoPlay = auto;
    	}
    	else{
    		return this._autoPlay;
    	}
    },
    /**
     * 일시정지 여부를 확인한다.
     * @returns {Boolean}
     */
    paused : function(){ return this.context.paused; },
    /**
     * 음량을 설정하거나 가져 온다.<br/>
     * 설정값은 1.0 ~ 0.0 까지 이다. (0.0이면 음소거 상태)
     * @param {Double} volume
     * @returns {Double}
     */
    volume : function(volume){
        if (volume !== undefined){
            // 1.0 ~ 0.0 까지
            if (volume < 0) volume = 0;
            this.context.volume = volume;
            
            if (volume > 0) this.muted(false);
            else this.muted(true);
        }
        else{
            return this.context.volume;
        }
    },
    /**
     * 음소거로 설정하거나 음소거 여부를 확인한다.
     * @param {Boolean} mute
     * @returns {Boolean}
     */
    muted : function(mute){
        if (mute !== undefined){
            if (this.muted() !== mute){
                this.onmutechange();
            }
            
            this.context.muted = mute;
            this.onmutechange( mute );
        }
        else{
            return this.context.muted;
        }
    },
    /**
     * 영상의 길이값(seconds)을 가져 온다.
     * @returns {Integer}
     */
    duration : function(){
        return this._duration;
    },
    /**
     * 영상 재생위치를 가져오거나 설정한다.
     * @param {Integer} timeLocation 영상 재생 위치 (초)
     * @returns {Integer}
     */
    currentTime : function(timeLocation){
        if (timeLocation !== undefined){
            this.context.currentTime = timeLocation;
        }
        else{
            return this.context.currentTime;
        }
    },
    /**
     * 음소거 상태를 on/off 한다.
     */
    toggleMute : function(){
        this.muted( !this.muted() );
    },
    /**
     * 재생 상태를 on/off 한다.
     */
    togglePlay : function(){
        if (this.context.paused === false){
            this.pause();
        }
        else{
            this.play();
        }
    },
    /**
     * @ignore
     * @param speed
     * @returns
     */
    speed : function(speed){
        if (speed !== undefined){
            if (speed < 0) speed = 0;
            this.context.playbackRate = speed;
        }
        else{
            return this.context.playbackRate;
        }
    },
    /**
     * @ignore
     * @param incValue
     */
    incSpeed : function(incValue){
        var dSpeed = this.speed();
        dSpeed = dSpeed + incValue;
        this.speed(dSpeed);
    },
    /**
     * 미디어 가로 크기를 가져오거나 설정한다.
     * @param {Integer} width
     * @returns {Integer}
     */
    width : function(width){
        if (width){
            this.context.width = width;
        }
        else{
            return this.context.height;
        }
    },
    /**
     * 미디어 세로 크기를 가져오거나 설정한다.
     * @param {Integer} height
     * @returns {Integer}
     */
    height : function(height){
        if (height){
            this.context.height = height;
        }
        else{
            return this.context.height;
        }
    },
    /**
     * <h4>추상메서드</h4>
     * 재생 할 미디어 경로를 설정 한다.
     * @param {String} pathMedia
     */
    source : function(pathMedia){
        this.onsourcechange();
    },
    /**
     * 설정한 미디어를 읽어들인다.
     */
    load : function(){
    	this._jqPlayer.load();
    },
    /**
     * 플레이어 표시/숨김에 대한 설정을 한다.
     * @param {Boolean} visible
     */
    visible : function(visible){
    	this._jqPlayer.css("visibility", visible);
    },
    /**
     * @ignore
     */
    onDurationChange : function(){
        var instance = $.data( this, "player" );
        var dDuration = this.duration;
        
        instance._duration = dDuration;
        instance.ondurationchange( dDuration );
        //this.play();
    },
    
    /* public event binder */
    /**
     * 설정한 미디어 데이터의 로드가 완료 되었을 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {BasePlayer}
     */
    loadeddata : function(handler)  { this._jqPlayer.bind("loadeddata", handler); return this; },
    /**
     * 미디어 재생이 끝났을 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {BasePlayer}
     */
    ended : function(handler)       { this._jqPlayer.bind("ended", handler); return this; },
    /**
     * 미디어의 음소거 상태가 변경될 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {BasePlayer}
     */
    mutechange : function(handler)  { this.evt_mutechange = handler; return this; },
    /**
     * 미디어의 재생 상태가 변경될 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {BasePlayer}
     */
    playchange : function(handler)  { this.evt_playchange = handler; return this; },
    /**
     * 재생될 미디어 소스가 변경될 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {BasePlayer}
     */
    sourcechange : function(handler){ this.evt_sourcechange = handler; return this; },
    /**
     * 미디어의 총 재생 길이가 변경될 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {BasePlayer}
     */
    durationchange : function(handler) { this.evt_durationchange = handler; return this; },
    
    /* protected event executer */
    /**
     * @ignore
     */
    onmutechange : function(isMute){
        this.evt_mutechange(isMute);
    },
    /**
     * @ignore
     */
    onplaychange : function(isPlay){
        this.evt_playchange(isPlay);
    },
    /**
     * @ignore
     */
    onsourcechange : function(){
        this.evt_sourcechange();
    },
    /**
     * @ignore
     */
    ondurationchange : function(duration){
        this.evt_durationchange(duration);
    }
};