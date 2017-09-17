/**
 * 영상 재생기의 제어UI의 각종 이벤트 및 로직을 수행하는 컨트롤러.<br/>
 * 현재는 MediaElement API로 대신하고 있기에 쓰이지 않고 있다.
 * @deprecated
 * @class
 */
function MediaController(){
    this._jqCurrTime = $("#slider_CurrentTime");
    this._jqVolume = $("#slider_Volume");
    this._jqPlayTime = $("#label_PlayTime");
    this._jqWrapVolume = $("#wrapper_Volume");
    this._jqWrapSpeed = $("#wrapper_Speed");
    
    this.maxDuration = "";
    this.player = null;
    this.trackctrl = null;
}

MediaController.prototype = {
    init : function(player, trackctrl, subttl){
        this.player = player;
        this.trackctrl = trackctrl;
        player.MediaCtrl = this;
        player.SubtitleCtrl = player.SubtitleCtrl || subttl || { find : function(){}, checkCurrentTime : function(){} };
        
        player.mutechange(function(isMute){
            $("#button_Mute span").toggleClass("ui-icon-volume-off", isMute).toggleClass("ui-icon-volume-on", !isMute);
        });
        
        player.playchange(function(isPlay){
            $("#button_Play span").toggleClass("ui-icon-pause", isPlay).toggleClass("ui-icon-play", !isPlay);
        });
        
        player.durationchange(function(duration){
            this.MediaCtrl.setDuration( duration );
            this.volume( this.MediaCtrl._jqVolume.slider("value") );
            //alert($("#button_Play").attr("class"));
            if ($("#button_Play span").hasClass("ui-icon-pause") === true){
                this.play();
            }
        });
        
        $("#button_Play, #button_Prev, #button_Next, #button_Speed, #button_SpeedUp, #button_SpeedDown, #button_SpeedDefault, #button_Mute").each(function(index){
            var jqButton = $(this);
            
            $.data( this, "mediactrl", player.MediaCtrl );
            jqButton.click(function(){
                $.data( this, "mediactrl" ).onControlUiClick(this);
            });
        });
        
        this._jqCurrTime.data( "mediactrl", this );
        this._jqVolume.data( "mediactrl", this );
        
        this._jqCurrTime.slider({
            min: 0,
            max: 5,
            step: 0.1,
            value: 0,
            range: "min",
            
            slide: function(event, ui){
                $.data( this, "mediactrl" ).onCurrTimeSlide( ui.value );
            },
            stop: function(event, ui){
                $.data( this, "mediactrl" ).onCurrTimeSlide( ui.value );
            }
        });
        
        this._jqVolume.slider({
            min: 0,
            max: 1.0,
            step: 0.1,
            value: 0.5,
            animate: "false",
            range: "min",
            orientation: "vertical",
            
            change: function(event, ui){
                $.data( this, "mediactrl" ).player.volume( parseFloat( ui.value ) );
            }
        });
        
        Artn.OutsideEvent.add( this._jqWrapVolume.selector );
        Artn.OutsideEvent.add( this._jqWrapSpeed.selector );
        this._jqWrapVolume.hide();
        this._jqWrapSpeed.hide();
        
        return this;
    },
    initCurrTime : function(){
        this._jqCurrTime.slider("value", 0);
    },
    setDuration : function(duration){
        this._jqCurrTime.slider("option", "max", duration);
        this.maxDuration = this.convertToTimeFormat( duration );
    },
    setCurrTimeToFormat : function(timeLocation){
        this._jqPlayTime.text(
            this.convertToTimeFormat( timeLocation ) + " / " + this.maxDuration// + " : " + timeLocation
        );
    },
    convertToTimeFormat : function(timeLocation){
        var sMin = Math.floor(timeLocation % 60).toString();
        
        sMin = (sMin.length === 1)? "0" + sMin : sMin;
        
        return Math.floor(timeLocation / 60) + ":" + sMin;
    },
    
    onControlUiClick : function(sender){
        var sName = sender.id.replace("button_", "");
        
        if      (sName === "Play")          this.player.togglePlay();
        
        else if (sName === "SpeedUp")       this.player.incSpeed(0.5);
        else if (sName === "SpeedDown")     this.player.incSpeed(-0.5);
        else if (sName === "SpeedDefault")  this.player.speed(1.0);
        
        else if (sName === "Speed"){
            if (this._jqWrapSpeed){
            	if (Artn.OutsideEvent.existShowed() === false){
            		this._jqWrapSpeed.show();
            	}
            }
            else{
                var dSpeed = Artn.Player.speed();
                if (dSpeed >= 2.0){
                    this.player.speed(1.0);
                }
                else{
                    this.player.speed(2.0);
                }
            }
        }
        else if (sName === "Mute") {
            if (this._jqWrapVolume){
            	if (Artn.OutsideEvent.existShowed() === false){
            		this._jqWrapVolume.show();
            	}
            }
            else{
                this.player.toggleMute();
            }
        }
        else if (sName === "Prev"){
            this.trackctrl.prevTrack();
        }
        else if (sName === "Next"){
            this.trackctrl.nextTrack();
        }
    },
    onCurrTimeSlide : function(timeLocation){
        this.player.currentTime( timeLocation );
        this.player.SubtitleCtrl.find( timeLocation );
    },
    onFocusOutAtCtrlWrapper : function(){
    	$(this).css("display", "none");
    	
    }
};