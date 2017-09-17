/**
 * 반복구간이 가능한 플레이어.<br/>
 * 현재는 쓰이지 않는다.
 * @deprecated
 * @param strSelector
 * @returns
 */
function RepeatableVideo(strSelector){ 
	this.classname = "RepeatableVideo";
    this._repeatCnt = 1;
    this._repeat = 0;
    this._durationTotal = 0;
    
    this.evt_ended = function(){};
    this.evt_repeatended = function(){};
}

RepeatableVideo.prototype = new BasePlayer();
$.extend(RepeatableVideo.prototype, {
    constructor : RepeatableVideo,
    
    init : function(strId, opt){
        BasePlayer.prototype.init.call(this, strId, opt);

        this._jqPlayer.bind("ended", function(){
            $.data( this, "player" ).onEndedEvent();
        });
        
        // 이벤트 재정의 및 등록
        this._jqPlayer.unbind("loadeddata", this.onDurationChange);
        this._jqPlayer.bind("loadeddata", function(){
            var instance = $.data( this, "player" );
            var dDuration = this.duration;
            
            instance._duration = dDuration;
            instance._durationTotal = dDuration * instance._repeatCnt;
            instance.ondurationchange( instance._durationTotal );
        });
        
        return this;
    },
    
    onDurationEvent : function(dDuration){
    	this._duration = dDuration;
    	this._durationTotal = dDuration * this._repeatCnt;
    	this.ondurationchange( this._durationTotal );
    },
    
    onEndedEvent : function(){

        if (this._repeat === (this._repeatCnt - 1)){
            //this.onrepeatended();
            this.onended();
        }
        else{
            ++this._repeat;
            this.context.currentTime = 0;
            this.play();
        }
    },
    onMediaEvent : function(intEventType){
        if (intEventType === Artn.EventType.EVENT_ENDED){
            
        }
        else if (intEventType === Artn.EventType.EVENT_LOADEDDATA){
            var dDuration = this.context.duration;
            this._duration = dDuration;
            this._jqCurrTime.slider("option", "max", dDuration);
            this.play();
        }
        else if (intEventType === Artn.EventType.EVENT_PAUSE){
            
        }
        else if (intEventType === Artn.EventType.EVENT_STARTED){
            
        }
    },
    
    // override
    duration : function(){
        return this._durationTotal;
    },
    // override
    currentTime : function(timeLocation){
        if ((timeLocation !== undefined)){
            this._repeat = Math.floor(timeLocation / this._duration);
            try{ this.context.currentTime = (timeLocation % this._duration); }catch(e){}
            // $("#printHere").html(
                // "timeLocation=" + timeLocation + "<br/>" +
                // "duration=" + this._duration + "<br/>" +
                // "repeat=" + this._repeat + "<br/>" + 
                // "currTime=" + this.context.currentTime
            // );
        }
        else{
        	var dCurrTime = this.context.currentTime;
        	if (dCurrTime === "NaN"){
        		return 0;
        	}
            return dCurrTime + ( this._duration * this._repeat );
        }
    },
    // override
    source : function(pathWebm, pathMp4, intRepeat, dblDuration){
        if ((pathWebm !== undefined) && (pathMp4 !== undefined)){
            this._repeatCnt = intRepeat || 1;
            this._repeat = 0;
            
            this._jqPlayer.src = "";
            this._jqPlayer.html("");
            this._jqPlayer.html("<source src=\"" + pathWebm + "\" type=\"video/webm\"/><source src=\"" + pathMp4 + "\" type=\"video/mp4\"/>"); 
            //document.getElementById("__video").src = pathWebm;
            this.onsourcechange();
            //this._jqPlayer.load();
            this.onDurationEvent( parseFloat( dblDuration ) );
        }
        else{
            return this._jqPlayer.find("source[type='video/webm']").attr("src");
        }
    },
    // override
    ended : function(handler)       { this.evt_ended = handler; },
    repeatended : function(handler) { this.evt_repeatended = handler; },
    
    onended : function(){
        this.evt_ended(this);
    },
    onrepeatended : function(){
        this.evt_repeatended(this);
    }
});
