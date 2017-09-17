var Artn = Artn || {};
Artn.Const = Artn.Const || {};

Artn.EventType = {
    EVENT_LOADEDDATA : 0,
    EVENT_ENDED : 1,
    EVENT_STARTED : 2,
    EVENT_PAUSE : 3
}

function BasePlayer(){
    this._player = null;
    this._duration = 0;
    this._currentTime = 0;
    this._repeatCnt = 1;
    this._repeat = 1;
}
BasePlayer.prototype = {
    init : function(strId){
        this._player = document.getElementById(strId);
    }
};

/*
 * 
 * 365플러스 - 플레이어
 */

function Player(strSelector){ 
    this._video = document.getElementById("__video");

    this._jqPlayer = $(this._video);
    this._jqCurrTime = $("#slider_CurrentTime");
    this._jqVolume = $("#slider_Volume");
    this._jqPlayTime = $("#label_PlayTime");
    
    // this._jqSrcWebm = $("#srcWebm");
    // this._jqSrcMp4 = $("#srcMp4");
    // this._jqSrcOgg = $("#srcOgg");
    // this._jqSrcMp3 = $("#srcMp3");
    
    this._contentInfo = null;
    this.SubtitleCtrl = null;
    this._durationChecked = true; // true면 duration NaN 체크를 하지 않는다.
    this._duration = 0;
    this._currentTime = 0;
    this._isStart = false;
    this._isEnd = true;
    this._isPlaying = false;
    this._jsonLoaded = false;
    
    this._repeatCnt = 1;
    this._repeat = 0;

    this.initAttr(this);
    this.initEvent();
}

Player.prototype = {
    initAttr : function(player){
        Artn.Player = player;

        $("#button_Play, #button_Speed, #button_SpeedUp, #button_SpeedDown, #button_SpeedDefault, #button_Mute").click(function(){
            Artn.Player._onControlUiClick(this);
        });
        
        this._jqCurrTime.slider({
            min: 0,
            max: 5,
            step: 0.1,
            value: 0,
            range: "min",
            
            slide: function(event, ui){
                Artn.Player._video.currentTime = ui.value;
                Artn.Player.SubtitleCtrl.find(ui.value);
            },

            stop: function(event, ui){
                Artn.Player._video.currentTime = ui.value;
                Artn.Player.SubtitleCtrl.find(ui.value);
            }
        });
        
        this._jqVolume.slider({
            min: 0,
            max: 1.0,
            step: 0.1,
            value: 1.0,
            animate: "false",
            range: "min",
            orientation: "vertical",
            
            change: function(event, ui){
                Artn.Player._video.volume = parseFloat($("#slider_Volume").slider("value"));
            }
        });
        
        
        
        /* 이벤트 캐치 테스트 [시작]*/
        // this.setSrc("movie/0001.webm");
        // this.thumbnail.add("thumb/0001.jpg");
        // this.thumbnail.add("thumb/0009.jpg");

        // this.SubtitleCtrl.onPrinting(function(sbTtl){
            // $("#subtitles").html(sbTtl.text);
        // });
        
        //this.contents("http://www.skbt.co.kr/naean_test/test.jsp?cmd=contents-sample");
        /* 이벤트 캐치 테스트 [종료]*/
    },
    onMediaEvent : function(intEventType){
        var video = this._video;
        var player = Artn.Player;
        
        if (intEventType === Artn.EventType.EVENT_ENDED){
            if (this._repeat === this._repeatCnt){
                this._repeat = 1;
                this.onTrackEnd();
                this.nextTrack();
            }
            else{
                ++this._repeat;
                this._video.currentTime = 0;
                this.play();
            }
            
            //this._isEnd = true;
        }
        else if (intEventType === Artn.EventType.EVENT_LOADEDDATA){
            var dDuration = video.duration;
            this._duration = dDuration;
            this._jqCurrTime.slider("option", "max", dDuration);
            this.play();
        }
        else if (intEventType === Artn.EventType.EVENT_PAUSE){
            
        }
        else if (intEventType === Artn.EventType.EVENT_STARTED){
            
        }
    },
    initEvent : function(){
        this._jqPlayer.bind("loadeddata", function(){
            Artn.Player.onMediaEvent(Artn.EventType.EVENT_LOADEDDATA);
        });
        
        this._jqPlayer.bind("ended", function(){
            Artn.Player.onMediaEvent(Artn.EventType.EVENT_ENDED);
        });

        this._onEventListener();
        
        
        // jqVideo.bind("loadeddata", function(){
            // Artn.Player.onMediaEvent(Artn.EventType.EVENT_LOADEDDATA);
        // });
//         
        // jqVideo.bind("ended", function(){
            // Artn.Player.onMediaEvent(Artn.EventType.EVENT_ENDED);
        // });
         // if (Artn.Player._isStart === true){
                // Artn.Player.onTrackStart();
                // Artn.Player._isStart = false;
            // }
//             
            // if (Artn.Player._jsonLoaded === true){
                // Artn.Player.onJsonLoaded();
                // Artn.Player._jsonLoaded = false;
            // }
    },
    play : function(){
        this._video.play();
        this._isStart = true;
        this._isEnd = false;
        this._isPlaying = true;
    },
    stop : function(){
        this._video.currentTime = 0;
        this._video.pause();
        this._isPlaying = false;
        this.SubtitleCtrl.init();
        this._jqCurrTime.slider("value", 0);
        $("#subtitles").text("");
    },
    pause : function(){ this._video.pause(); },
    volume : function(){
        if (arguments.length > 0){
            // 1.0 ~ 0.0 까지
            if (volume < 0) volume = 0;
            this._video.volume = volume;
            
            if (volume > 0) this.muted(false);
        }
        else{
            return this._video.volume;
        }
    },
    muted : function(){
        if (arguments.length > 0){
            var mute = arguments[0];
            if (this.muted() !== mute){
                this.onMuteToggle();
            }
            
            this._video.muted = mute;
            
            if (this.muted() === mute) {
                $("#button_Mute").addClass("toggled")
            }
            else{
                $("#button_Mute").removeClass("toggled");
            }
        }
        else{
            return this._video.muted;
        }
    },
    toggleMute : function(){
        this.muted(!this.muted());
    },
    togglePlay : function(){
        if (this._video.paused === false){
            this.pause();
        }
        else{
            this.play();
        }
    },
    setCurrTimeToFormat : function(timeLocation){
        var sMin = Math.round(timeLocation % 60).toString();
        var sTime;
        
        sMin = (sMin.length === 1)? "0" + sMin : sMin;
        
        sTime = Math.round(timeLocation / 60) + ":" + sMin;
        this._jqPlayTime.text(sTime);
    },
    updateCurrTime : function(){
        this.setCurrTimeToFormat( this._video.currentTime );
    },
    setCurrentTime : function(timeLocation){
        this._video.currentTime = timeLocation;
    },
    getCurrentTime : function(){
        return this._video.currentTime;
    },
    playSpeed : function(speed){
        if (arguments.length > 0){
            var speed = arguments[0];
            
            if (speed < 0) speed = 0;
            this._video.playbackRate = speed;
        }
        else{
            return this._video.playbackRate;
        }
    },
    incSpeed : function(incValue){
        var dSpeed = this.playSpeed();
        dSpeed = dSpeed + incValue;
        this.playSpeed(dSpeed);
    },
    
    
    isPlaying : function(){ return this._isPlaying; },
    isStopped : function(){ return !this._isPlaying; },
    
    /* property getter and setter */
    contents : function(){
        
        if (arguments.length < 1){
            return this._contentInfo;
        }
        else if (typeof arguments[0] === "number"){
            return this._contentInfo.tracks[ arguments[0] ];
        }
        else if (typeof arguments[0] === "string"){
            $.getJSON(arguments[0], function(data, textStatus, jqXHR){
                Artn.Player.contents(data);
                Artn.Player._jsonLoaded = true;
            });
        }
        else if (typeof arguments[0] === "object"){
            this._contentInfo = arguments[0];
            this.title(this._contentInfo.title);
            this.desc(this._contentInfo.desc);
            this.thumbnail.addRange(this._contentInfo.tracks);
            this.changeTrack(0);
        }
    },
    src : function(){
        if (arguments.length >= 2){
            var urlWebm = arguments[0];
            var urlMp4 = arguments[1];
            this._repeatCnt = arguments[2] || 1;
            this._repeat = 1;
            
            this._jqPlayer.empty();
            this._jqPlayer.html("<source src=\"" + urlWebm + "\" type=\"video/webm\"/><source src=\"" + urlMp4 + "\" type=\"video/mp4\"/>");
            //this._video.childNodes[1].src = mediaUrl;
            this.onSrcChange();
        }
        else{
            return this._jqPlayer.find("source[type='video/webm']").attr("src");
        }
        
    },
    subject : function(){
        if (arguments.length < 1){
            return $("#subject").html();
        }
        else{
            $("#subject").html(arguments[0]);
        }
    },
    desc : function(){
        if (arguments.length < 1){
            return $("#desc").html();
        }
        else{
            $("#desc").html(arguments[0]);
        }
    },
    subtitle : function(){
        if (arguments.length < 1){
            return $("#subtitle").html();
        }
        else{
            $("#subtitle").html(arguments[0]);
        }
    },

    _onEventListener : function(){
        Artn.Listener.add(function(){
            
            // var dDuration = Artn.Player._video.duration;
//             
            // $("#label_PlayTime").text(iCurrTime);
//         
            // if ((Artn.Player._durationChecked === false) &&
                // (isNaN(dDuration) === false)){
                // Artn.Player._durationChecked = true;
                // Artn.Player._duration = dDuration;
                // $("#slider_CurrentTime").slider("option", "max", dDuration);
                // Artn.Player.play();
            // }
//             
            // if ((Artn.Player._isEnd === false) &&
                // (iCurrTime >= (Artn.Player._duration - 0.5) )){
                // Artn.Player.onTrackEnd();
                // Artn.Player.nextTrack();
                // Artn.Player._isEnd = true;
            // }
//             
            // if (Artn.Player._isStart === true){
                // Artn.Player.onTrackStart();
                // Artn.Player._isStart = false;
            // }
            Artn.Player.updateCurrTime();
            
            if (Artn.Player._isPlaying === true){
                var iCurrTime = Artn.Player._video.currentTime;
                Artn.Player._jqCurrTime.slider("value", iCurrTime);
                //Artn.Player.SubtitleCtrl.checkCurrentTime(iCurrTime); //TODO: 나중에 복구 해야함
                //if (Artn.Player._video.currentTime >= Artn.Player.currentSubtitlesTime())
            }
            
            // if (Artn.Player._jsonLoaded === true){
                // Artn.Player.onJsonLoaded();
                // Artn.Player._jsonLoaded = false;
            // }

        });
    },
    
    
    
    onSrcChange : function(){},
    onMuteToggle : function(){},
    onTrackStart : function(){},
    onTrackEnd : function(){},
    onJsonLoaded : function(){},
    onContentsEnd : function(){},
    
    /* ui events */
    _onControlUiClick : function(sender){
        var sName = sender.id.replace("button_", "");
        
        if (sName === "Play") this.togglePlay();
        if (sName === "Mute") this.toggleMute();
        if (sName === "SpeedUp") this.incSpeed(0.5);
        if (sName === "SpeedDown") this.incSpeed(-0.5);
        if (sName === "SpeedDefault") this.playSpeed(1.0);
    },
    
    /* self events */

    _onDurationChange : function(){
        this._durationChecked = false;
        $("#slider_CurrentTime").slider("value", 0);
    },
    __TrackEnded : function(){
        if (this._video.ended === true){
            _onTrackEnded();
        }
        else{
            setTimeout(this.__TrackEnded, 200);
        }
    },
    _onTrackEnded : function(){},
    onTrackEnded : function(eventFunction){
        this._onTrackEnded = eventFunction;
    },
    _onTrackRepeatEnded : function(){},
    _onUserRepeatEnded : function(){},
    
};





Artn.Const.Player = {
    PLAYER_TAGS : "",
    
    THUMBNAIL_TAGS : 
        "<li><a href=\"#\"><img src=\"{file_img}\" alt=\"\"/><span class=\"thumb-title\">{subject_movie}</span></a></li>"
};



$(document).ready(function(){
    Artn.Player = new Player();
    Artn.Player.src("media/webm/0004.webm", "media/mp4/0012.mp4", 3);
    Artn.Player.SubtitleCtrl = new SubtitlesController();
    // Artn.Player.TrackCtrl = new TrackController(Artn.Player);
    // Artn.Player.Thumbnail = new ThumbnailList("#imageList_Thumb", {
        // itemTags : Artn.Const.Player.THUMBNAIL_TAGS,
        // itemKeys : ["file_img", "subject_movie"],
        // click : function(sender, index){
            // Artn.Player.changeTrack( index );
        // }
    // });
    //Artn.Healingup.Web.Event[0] = Artn.Healingup.Web.Player;
    //alert(Artn.Healingup.Web.Event[0] instanceof Player);
    //_eventChecker();
});
