/*
 * 나레이터
 */
/**
 * 초기 플레이어의 나리이션 기능을 담당했었다.<br/>
 * 현재는 MediaElement를 Wrapping한 HealingPlayer가 대신하기에 사용하지 않는다.
 * @deprecated
 * @class
 */
function Narrator(){
	this.classname = "Narrator";
    this.poster = document.getElementById("__poster");
    this._jqPoster = $(this.poster);
}
Narrator.prototype = new BasePlayer();
$.extend(Narrator.prototype, {
    constructor : Narrator,
    init : function(strId, opt){
        BasePlayer.prototype.init.call(this, strId, opt);
        
        this._jqPlayer.bind("ended", function(){
            $.data( this, "player").fadeOut();
        });
        
        return this;
    },
    fadeIn : function(){
        this._jqPoster.fadeIn(1000);
    },
    fadeOut : function(){
        this._jqPoster.fadeOut(1000);
    },
    // override
    play : function(){
        this.fadeIn();
        this._jqPlayer.context.play();
        this.onplaychange(true);
        //this._jqPlayer.delay(1000).context.play();
    },
    
    // override
    source : function(pathOgg, pathMp3, pathImg){
        if ((pathOgg !== undefined) && (pathMp3 !== undefined) && (pathImg !== undefined)){
            this.poster.src = pathImg;
            $(this.poster).css("display", "none");
            
            this._jqPlayer.empty();
            this._jqPlayer.html("<source src=\"" + pathOgg + "\" type=\"audio/ogg\"/><source src=\"" + pathMp3 + "\" type=\"audio/mp3\"/>");
            this.onsourcechange();
        }
        else{
            return this._jqPlayer.find("source[type='audio/ogg']").attr("src");
        }
    },
    // override
    width : function(width){
        if (width){
            this.poster.width = width;
        }
        else{
            return this.poster.height;
        }
    },
    // override
    height : function(height){
        if (height){
            this.poster.height = height;
        }
        else{
            return this.poster.height;
        }
    }
});