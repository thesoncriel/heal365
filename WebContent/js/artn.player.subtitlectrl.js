var Artn = Artn || {};

/*
 * 내안 플러스 - 자막 제어기
 */
/**
 * 초기 플레이어에 자막처리를 위한 컨트롤러였으나 현재는 쓰이지 않는다.
 * @deprecated
 * @class
 */
function SubtitleController(){
    this.END_TIME = 65535;
    
    this._subtitles = [];
    this._index = -1;
    this._currSbTtl = {};
    this._nextSbTtl = {};
    this._currTime = 0;
    this._onPrinting = function(sbTtl){};
    this._onEnded = function(){};
    
    this.init();
}

SubtitleController.prototype = {
    init : function(){
        this.setSubtitlesByIndex(-1);
    },
    setData : function(jsonObj){
        this._subtitles = jsonObj;
        this.init();
    },
    checkCurrentTime : function(currTime){
        var sbTtl = this._nextSbTtl;

        if (currTime >= sbTtl.time){
            
            
            //$("#subtitles").text(currTime + " | " + sbTtl.time);
            this.moveNext();
        }
    },
    
    moveNext : function(){
        var index = this._index + 1;

        if (this._subtitles.length <= index){
            $("#subtitles").text($("#subtitles").text() + " === 끝");
            this._onEnded();
            return false;
        }
        
        this.setSubtitlesByIndex(index);
        return true;
    },
    setSubtitlesByIndex : function(index){
        
        if ((this._subtitles.length > index)){
            
            if (index === -1){
                this._currSbTtl = {time: 0, text: ""};
                this._nextSbTtl = this._subtitles[0];
            }
            else{
                this._currSbTtl = this._subtitles[index];
                
                if (this._subtitles.length > (index + 1)){
                    this._nextSbTtl = this._subtitles[index + 1];
                }
                else{
                    this._nextSbTtl = {time: this.END_TIME, text: ""}; // time이 지나치게 크면 더이상 자막이 없다는 것을 의미
                }
            }
            this._onPrinting(this._currSbTtl);
            
            this._index = index;
        }
    },
    hasNext : function(){
        return (this._nextSbTtl.time <= -1);
    },
    find : function(findTime){
        var arrSt = this._subtitles;
        var iLen = arrSt.length;
        
        if (iLen === 0) return {time: 0, text: ""}; // 자막이 없을 때 기본적인 빈 자막 정보를 리턴 한다.
        
        for(var i = (iLen - 1); i >= 0; i--){
            if (arrSt[i].time <= findTime){
                this.setSubtitlesByIndex(i);
                break;
            }
        }
        
        return this._currSbTtl;
    },
    
    onPrinting : function(fn){
        this._onPrinting = fn;
    },
    
    onEnded : function(fn){
        this._onEnded = fn;
    }
};
