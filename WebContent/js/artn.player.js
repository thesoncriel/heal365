function HealingPlayer(){
	this.classname = "HealingPlayer";
    this.narrator = null;
    this.video = null;
    this.isDataApply = [false, false];
    this._paused = true;
    this._volume = 0.5;
    
    this._id = "";
    this._width = 0;
    this._height = 0;
    
    this.evt_loadeddata = function(){};
    this.evt_ended = function(){};
}

HealingPlayer.prototype = new BasePlayer();
$.extend(HealingPlayer.prototype, {
    constructor : HealingPlayer,
    
    init : function(strId, opt){
        BasePlayer.prototype.init.call(this, strId, opt);
        this._id = strId;
        this._width = opt.width || 640;
        this._height = opt.height || 480;
        this.createNodes();
        
        return this;
    },
    createNodes : function(){
        var width = this._width;
        var height = this._height;
        
        this._jqPlayer.empty();
        this._jqPlayer.append("<img id=\"__poster\" src=\"\" /><audio id=\"__audio\"></audio><video id=\"__video\"></video>");
        
        this.narrator = new Narrator().init("__audio", {width: width, height: height});
        this.video = new RepeatableVideo().init("__video", {width: width, height: height});

        this._jqPlayer.css("position", "relative");
        this.narrator._jqPoster.css({
            position : "absolute",
            left : "0px",
            top : "0px"
        });
        
        $.data(this.narrator.context, "HealingPlayer", this);
        $.data(this.video.context, "HealingPlayer", this);
        
        this.narrator.durationchange( this.onDurationChange );
        this.video.durationchange( this.onDurationChange );
        this.video.ended(function(){
            var instance = $.data( this.context, "HealingPlayer" );
            instance.onended();
        });
        
        this.narrator.ended(function(){
            var instance = $.data( this, "HealingPlayer" );
            
            if (instance.paused() === false){
                instance.video.play();
            }
        });
        this._currentTime = 0;
        this.volume(this._volume); // 플레이어 재생 시 기본 볼륨을 
    },
    
    isNarrating : function(){
    	var dCurrTime = this.currentTime();
    	var dNarrDuration = this.narrator.duration();
    	
    	if (this._duration === 0){
    		return true;
    	}
    	
        return dCurrTime < dNarrDuration;
    },
    // override
    play : function(){
        if (this.isNarrating() == true){
            this.narrator.play();
        }
        else{
            this.video.play();
        }
        this._paused = false;
        this.onplaychange(true); 
    },
    // override
    pause : function(){ 
        this.narrator.pause();
        this.video.pause();
        this._paused = true;
        this.onplaychange(false); 
    },
    // override
    paused : function(){
        return this._paused; 
    },
    // override
    volume : function(volume){
        if (volume !== undefined){
            // 1.0 ~ 0.0 까지
            if (volume < 0) volume = 0;
            this.narrator.volume( volume );
            this._volume = volume;
            
            if (volume > 0) this.muted(false);
            else this.muted(true);
        }
        else{
            return this.narrator.volume();
        }
    },
    // override
    muted : function(mute){
        if (mute !== undefined){
            if (this.muted() !== mute){
                this.onmutechange();
            }
            
            this.narrator.muted( mute );
            this.onmutechange( mute );
        }
        else{
            return this.narrator.muted();
        }
    },
    // override
    currentTime : function(timeLocation){
        var dNarratorDuration = this.narrator.duration();
        
        //console.log("player:" + (this.narrator.currentTime() + this.video.currentTime()) + " // narrator:" + this.narrator.currentTime() + " / dur=" + dNarratorDuration + " / video:" + this.video.currentTime() );
        
        if (timeLocation !== undefined){
            if ( timeLocation >= dNarratorDuration ){
                if (this.paused() === false){
                    this.narrator.pause();
                    this.video.play();
                }
                //console.log("설정 timeLocation: " + timeLocation);
                this.narrator.currentTime( dNarratorDuration );
                this.video.currentTime( timeLocation - dNarratorDuration );
                this.narrator.fadeOut();
            }
            else{
                if (this.paused() === false){
                    this.video.pause();
                    this.narrator.play();
                }
                this.narrator.currentTime( timeLocation );
                this.video.currentTime( 0 );
                this.narrator.fadeIn();
            }
            this._currentTime = timeLocation;
        }
        else{
        	if ( this._currentTime >= dNarratorDuration ){
        		return dNarratorDuration + this.video.currentTime();
        	}
        	else{
        		return this.narrator.currentTime();        		
        	}
        }
    },
    // override
    togglePlay : function(){
        if (this.paused() === false){
            this.pause();
        }
        else{
            this.play();
        }
    },
    // override
    speed : function(speed){
        if (speed){
            if (speed < 0) speed = 0;
            
            this.narrator.speed( speed );
            this.video.speed( speed );
        }
        else{
            return this.video.speed();
        }
    },
    
    // override
    width : function(width){
        if (width){
            this._jqPlayer.css("width", width);
            if (this.narrator){
                this.narrator.width( width );
                this.video.width( width );
            }
        }
        else{
            return parseInt( this._jqPlayer.css("width") );
        }
    },
    // override
    height : function(height){
        if (height){
            this._jqPlayer.css("height", height);
            if (this.narrator){
                this.narrator.height( height );
                this.video.height( height );
            }
        }
        else{
            return parseInt( this._jqPlayer.css("height") );
        }
    },
    // override
    source : function(mapSource){
        this.createNodes();
        this.isDataApply = [false, false];
        this.narrator.source(
            mapSource.file_ogg,
            mapSource.file_mp3,
            mapSource.file_img
        );
        this.video.source(
            mapSource.file_webm,
            mapSource.file_mp4,
            mapSource.repeat_cnt,
            mapSource.movie_length
        );
        this.narrator.visible(false);
        
        this.onsourcechange();
    },
    // override
    onDurationChange : function(duration){
        var instance = $.data( this.context, "HealingPlayer" );
        var dDuration = instance.narrator.duration() + instance.video.duration();
        
        if ((this instanceof Narrator) === true){
        	instance.isDataApply[ 0 ] = true;
        	instance.video.visible(false);
        	//instance.video.load();
        	instance.narrator.visible(true);
        	//instance.narrator.pause();
        	instance.narrator.currentTime(0);
        }
        else if ((this instanceof RepeatableVideo) === true){
        	instance.isDataApply[ 1 ] = true;
        	instance.video.visible(true);
        	//instance.video.pause();
        	instance.video.currentTime(0);
        }
        
        if ((instance.isDataApply[0] === true) &&
            (instance.isDataApply[1] === true)){
            instance._duration = dDuration;
            instance.ondurationchange( dDuration );
            //instance.onloadeddata();
            instance.play();
        }
    },
    
    // override
    loadeddata : function(handler)  { this.evt_loadeddata = handler; },
    // override
    ended : function(handler)       { this.evt_ended = handler; },
    
    onloadeddata : function(){
        this.evt_loadeddata();
    },
    onended : function(){
        this.evt_ended();
    }
});
