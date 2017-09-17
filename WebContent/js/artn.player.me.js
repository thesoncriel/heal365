/**
 * MediaElement.js 를 Wrapping 하여 나레이션부와 운동영상부를 재생시켜주는 플레이어.<br/>
 * 설정된 미디어 정보에 따라 나레이션->운동영상을 자동으로 변경하여 재생 시키며,
 * 운동영상 부분은 반복 재생이 가능하다.
 * @class
 * @see BasePlayer
 */
function HealingPlayer(){
	this.classname = "HealingPlayer";
    
    this._id = "";
    this._width = 0;
    this._height = 0;
    
    this.evt_loadeddata = function(){};
    this.evt_ended = function(){};
    this.evt_mediastart = function(){};
    
    this.mep = null; // MediaElementPlayer
    this.me = null; // MediaElement
    this.mSrc = null; // Source Map Data
    this.narrating = false;
    this._maxRepeat = 1;
    this._currentRepeat = 1;
    this._applyMp4Narration = false;
}

HealingPlayer.prototype = new BasePlayer();
$.extend(HealingPlayer.prototype, {
	/**
	 * @ignore
	 */
    constructor : HealingPlayer,
    /**
	 * 플레이어 생성자.
	 * @param {String} strId 플레이어로 적용 할 요소
	 * @param {Map} opt 플레이어 생성 시 필요한 옵션들.
	 * @returns {HealingPlayer}
	 * @see BasePlayer.init
	 */
    init : function(strId, opt){
        BasePlayer.prototype.init.call(this, strId, opt);
        
        this._jqPlayer.data("inst", this);
        //this._jqPlayer.data("hoho", "하하");
        this._id = strId;
        
        this._applyMp4Narration = Artn.Environment.isMobile() || Artn.Environment.isIE();
        
        return this;
    },
    /**
     * MediaElement를 생성하고 객체의 멤버로 설정 한다.
     * @param {Map} mapSource ※사용되지 않음.
     */
    createMediaElement : function(mapSource){
    	//this._jqPlayer.after("<input type=\"hidden\" id=\"__" + this._id + "__\"/>");
    	//$("#__" + this._id + "__").data("inst", this);
    	
    	var inst = this;
    	var jqVideo = $("#" + this._id);
    	
    	this.mep = new MediaElementPlayer("#" + this._id, {
        	startVolume: 0.5,
        	//plugins: ["flash"],
        	//pluginPath: "/me/",
        	//flashName: "flashmediaelement.swf",
        	success: function(mediaElement, domObject){
        		var jqVideo = $(domObject);
        		

        		//alert( domObject.id + "::" + inst);
        		
        		inst.me = mediaElement;
        		mediaElement.inst = inst;
        		Artn.Inst = {};
        		Artn.Inst.playerme = inst;

        		mediaElement.addEventListener("ended", function(){
        			var jqVideo = $(this);
        			var inst = Artn.Inst.playerme;//((this.inst === undefined) || (this.inst === null))? Artn.Inst.playerme : this.inst;
        			
        			if (inst.narrating === true){
        				inst.changeToMovie();
        				inst.onmediastart(inst, {repeatInfo: "반복횟수<br/>" + inst._currentRepeat + "/" + inst._maxRepeat});
        			}
        			else if (inst._currentRepeat < inst._maxRepeat){
        				inst.me.setCurrentTime(0);
        				inst.me.play();
        				inst._currentRepeat++;
        				inst.onmediastart(inst, {repeatInfo: "반복횟수<br/>" + inst._currentRepeat + "/" + inst._maxRepeat});
        			}
        			else{
        				inst.onended();
        			}
        		});
        		
        		if ( Artn.Environment.isIE8() === true){
            		var jqButton = $(".mejs-overlay-button");
            		jqButton.append("<div style=\"color: #fff; font-size: 10pt; filter:progid:DXImageTransform.Microsoft.Glow(Color=#333333,Strength=10);\">IE8 이하는<br/>아래의<br/>트랙 버튼을<br/>눌러주세요.</div>");
            		jqButton.click(function(){
            			alert("아래의 트랙 버튼을 눌러 주세요.");
            			
            			return false;
            		});
            	}
        	}
        });
    	//mejs-ted
		//mejs-wmp
    	//this.mep.changeSkin( "" );
    },
    /**
     * 현재 나레이션 진행중인지 여부를 확인한다.
     * @returns {Boolean}
     */
    isNarrating : function(){
    	return this.narrating;
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
            this._jqPlayer.css("width", width);
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
            this._jqPlayer.css("height", height);
        }
        else{
            return parseInt( this._jqPlayer.css("height") );
        }
    },
    /**
     * 현재 재생되는 미디어의 반복 진행 횟수를 가져 온다.<br/>
     * (총 반복횟수가 아님)
     * @returns {Integer}
     */
    currentRepeat : function(){
    	return this._currentRepeat;
    },
    // override
    /**
     * 재생할 미디어에 대한 정보를 설정한다.<br/>
     * 내부적으로 createMediaElement() 와 _applySource()를 수행한다.
     * @override
     * @param {Map} mapSource 미디어 정보.
     * @see HealingPlayer.createMediaElement
     * @see HealingPlayer._applySource
     */
    source : function(mapSource){
    	this.mSrc = mapSource;
    	this._maxRepeat = mapSource.repeat_cnt || 1;
    	this._currentRepeat = 1;
    	this.narrating = true;

    	if ((this.mep === undefined) || (this.mep === null)) {
    		this.createMediaElement( mapSource );
    	}
    	this._applySource();
        this.onsourcechange();
    },
    /**
     * 객체 내부에 설정된 미디어 정보를 MediaElement 객체에 적용, 읽어들이고 재생 시킨다.<br/>
     * 미디어 중 나레이션을 먼저 재생시키며 해당 웹브라우저 환경에 따라 Mp4 / Image & Sound 를 구별하여 재생 시킨다.<br/>
     */
    _applySource : function(){
    	var mapSource = this.mSrc;
    	
    	if (this.me){
    		this._jqPlayer.attr("poster", mapSource.file_img);
    		
    		if (this._applyMp4Narration === true){
    			this.me.setSrc([
	                {src: mapSource.file_mp4narr, type: "video/mp4"}
	    	    ]);
    		}
    		else{
	    		this.me.setSrc([
	                {src: mapSource.file_ogg, type: "audio/ogg"},
	                {src: mapSource.file_mp3, type: "audio/mp3"}
	    	    ]);
    		}
			
    		this.onmediastart(this, {repeatInfo: "운동<br/>설명부"});
        	this.me.load();
        	this.me.play();
    	}
    },
    /**
     * 나레이션 재생을 중단하고 운동영상을 재생시킨다.
     */
    changeToMovie : function(){
    	this.me.setSrc([
            {src: this.mSrc.file_webm, type: "video/webm"},
            {src: this.mSrc.file_mp4, type: "video/mp4"}
	    ]);
		this.me.load();
		this.me.play();
		this.narrating = false;
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