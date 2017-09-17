/**
 * 미디어의 단순 재생 기능을 위한 기본 플레이어.<br/>
 * MediaElement를 Wrapping 하여 사용 된다.
 * @class
 */
function MoviePlayer(){
    this.video = null;
    this.isDataApply = false;
    this._paused = true;
    
    this._id = "";
    this._width = 0;
    this._height = 0;
    
    this.evt_loadeddata = function(){};
    this.evt_ended = function(){};
    this.evt_mediastart = function(){};
    
    this.mep = null; // MediaElementPlayer
    this.me = null; // MediaElement
    this.mSrc = null; // Source Map Data
}
MoviePlayer.prototype = new BasePlayer();
$.extend(MoviePlayer.prototype, {
	/**
	 * @ignore
	 */
	constructor : MoviePlayer,
	/**
	 * 플레이어 생성자.
	 * @param {String} strId 플레이어로 적용 할 요소
	 * @returns {BasePlayer}
	 */
	init : function(strId){
		BasePlayer.prototype.init.call(this, strId, {autoPlay: true});
        
        this._jqPlayer.data("inst", this);
        this._id = strId;
        
        return this;
    },
    /**
     * 미디어 재생에 사용될 MediaElement 객체를 생성하고 멤버로 등록 한다.
     * @param {Map} mapSource ※사용되지 않는다.
     */
    createMediaElement : function(mapSource){

    	this.mep = new MediaElementPlayer("#" + this._id, {
        	startVolume: 0.5,
        	success: function(mediaElement, domObject){
        		var jqVideo = $(domObject);
        		var inst = jqVideo.data("inst");

        		inst.me = mediaElement;

        		mediaElement.addEventListener("ended", function(){
        			$(this).data("inst").onended();
    			});
        	}
        });
    	
    	this.video = this.mep;
    },

 // override
    /**
     * 미디어를 재생한다.
     * @override
     */
    play : function(){
        this.mep.play();
        this.onplaychange(true); 
    },
    // override
    /**
     * 미디어 재생을 일시정지 한다.
     * @override
     */
    pause : function(){ 
        this.mep.pause();
        this.onplaychange(false); 
    },
    // override
    /**
     * 미디어 재생의 일시정지여부를 확인한다.
     * @override
     * @returns {Boolean}
     */
    paused : function(){
    	try{
    		return this.me.paused();
    	}
    	catch(e){
    		return true;
    	}
    },
    // override
    /**
     * 음량을 설정하거나 가져온다.
     * @override
     * @param {Double} volume 1.0 ~ 0.0 까지의 값
     * @returns {Double}
     */
    volume : function(volume){
        if (volume !== undefined){
            this.me.setVolume( volume );
            
            if (volume > 0) this.muted(false);
            else this.muted(true);
        }
        else{
            return this.me.volume();
        }
    },
    // override
    /**
     * 음소거를 설정하거나 가져온다.
     * @override
     * @param {Boolean} mute true면 음소거, false면 음소거 해제.
     * @returns {Boolean}
     */
    muted : function(mute){
        if (mute !== undefined){
            this.me.setMuted( mute );
        }
        else{
            return this.me.muted();
        }
    },
    // override
    /**
     * 현재 재생 위치를 가져오거나 설정한다.
     * @override
     * @param {Integer} timeLocation 설정할 재생 위치
     * @returns {Integer}
     */
    currentTime : function(timeLocation){
    	try{
	        if (timeLocation !== undefined){
	            this.me.setCurrentTime( timeLocation );
	        }
	        else{
	        	return this.me.currentTime();
	        }
    	}
    	catch(e){}
    },
    // override
    /**
     * 재생 상태를 on/off 한다.
     * @override
     */
    togglePlay : function(){
        if (this.me.paused() === false){
            this.me.pause();
        }
        else{
            this.me.play();
        }
    },
    // override
    /**
     * 재생속도값을 가져오거나 설정한다.<br/>
     * 단, MediaElement는 속도조절이 불가하기에 별도 설정은 불가하며,
     * 리턴값은 항상 기본 속도인 1.0을 반환 할 것이다.
     * @override
     * @param {Double} speed
     * @returns {Double}
     */
    speed : function(speed){
    	// MediaElement는 기본적으로 속도 조절 못함.
        return 1.0;
    },
    
    // override
    /**
     * 미디어 가로 크기를 가져오거나 설정한다.
     * @override
     * @param {Integer} width
     * @returns {Integer}
     */
    width : function(width){
        if (width){
        	if (this.video){
	            this._jqPlayer.css("width", width);
	            this.video.width( width );
            }
        }
        else{
            return parseInt( this._jqPlayer.css("width") );
        }
    },
    // override
    /**
     * 미디어 세로 크기를 가져오거나 설정한다.
     * @override
     * @param {Integer} height
     * @returns {Integer}
     */
    height : function(height){
        if (height){
        	if (this.video){
	            this._jqPlayer.css("height", height);
	            this.video.height( height );
            }
        }
        else{
            return parseInt( this._jqPlayer.css("height") );
        }
    },
    // override
    /**
     * 재생할 미디어에 대한 정보를 설정한다.<br/>
     * 내부적으로 createMediaElement() 와 _applySource()를 수행한다.
     * @override
     * @param {Map} mapSource 미디어 정보.
     * @see MoviePlayer.createMediaElement
     * @see MoviePlayer._applySource
     */
    source : function(mapSource){
    	this.mSrc = mapSource;

    	if ((this.mep === undefined) || (this.mep === null)) {
    		this.createMediaElement( mapSource );
    	}
    	this._applySource();
    	this.onmediastart(this, {repeatInfo: ""});
        this.onsourcechange();
    },
    /**
     * 객체 내부에 설정된 미디어 정보를 MediaElement 객체에 적용, 읽어들이고 재생 시킨다.<br/>
     */
    _applySource : function(){
    	if (this._jqPlayer){
    		//this._jqPlayer.attr("poster", mapSource.file_img);
    		this.me.setSrc([
                {src: this.mSrc.file_webm, type: "video/webm"},
                {src: this.mSrc.file_mp4, type: "video/mp4"}
    	    ]);
        	this.me.load();
        	this.me.play();
    	}
    },
    // override
    /**
     * @ignore
     */
    onDurationChange : function(duration){
    	// MediaElement 와 함께는 사용하지 않음.
    },
    
    // override
    /**
     * @ignore
     */
    loadeddata : function(handler)  { this.evt_loadeddata = handler; return this; },
    // override
    /**
     * @ignore
     */
    ended : function(handler)       { this.evt_ended = handler; return this; },
    /**
     * 미디어 재생이 시작될 때 수행되는 이벤트.
     * @param {function} handler
     * @returns {HealingPlayer}
     */
    mediastart : function(handler)       { this.evt_mediastart = handler; return this; },
    /**
     * @ignore
     */
    onloadeddata : function(){
        this.evt_loadeddata();
    },
    /**
     * @ignore
     */
    onended : function(){
        this.evt_ended();
    },
    /**
     * @ignore
     */
    onmediastart : function(sender, data){
    	this.evt_mediastart(sender, data);
    }
});