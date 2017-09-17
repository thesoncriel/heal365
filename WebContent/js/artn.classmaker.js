/*
 jQuery UI Theme : Background Positioner
 * */
var Artn = Artn || {};
Artn.ClassMaker = {};

Artn.ClassMaker.JQueryIcon = {
    classNameList : [ 
[
"carat-1-n",
"carat-1-ne",
"carat-1-e",
"carat-1-se",
"carat-1-s",
"carat-1-sw",
"carat-1-w",
"carat-1-nw",
"carat-2-n-s",
"carat-2-e-w"
],
[
"triangle-1-n",
"triangle-1-ne",
"triangle-1-e",
"triangle-1-se",
"triangle-1-s",
"triangle-1-sw",
"triangle-1-w",
"triangle-1-nw",
"triangle-2-n-s",
"triangle-2-e-w"
],
[
"arrow-1-n",
"arrow-1-ne",
"arrow-1-e",
"arrow-1-se",
"arrow-1-s",
"arrow-1-sw",
"arrow-1-w",
"arrow-1-nw",
"arrow-2-n-s",
"arrow-2-ne-sw",
"arrow-2-e-w",
"arrow-2-se-nw",
"arrowstop-1-n",
"arrowstop-1-e",
"arrowstop-1-s",
"arrowstop-1-w"
],
[
"arrowthick-1-n",
"arrowthick-1-ne",
"arrowthick-1-e",
"arrowthick-1-se",
"arrowthick-1-s",
"arrowthick-1-sw",
"arrowthick-1-w",
"arrowthick-1-nw",
"arrowthick-2-n-s",
"arrowthick-2-ne-sw",
"arrowthick-2-e-w",
"arrowthick-2-se-nw",
"arrowthickstop-1-n",
"arrowthickstop-1-e",
"arrowthickstop-1-s",
"arrowthickstop-1-w"
],
[
"arrowreturnthick-1-w",
"arrowreturnthick-1-n",
"arrowreturnthick-1-e",
"arrowreturnthick-1-s",
"arrowreturn-1-w",
"arrowreturn-1-n",
"arrowreturn-1-e",
"arrowreturn-1-s",
"arrowrefresh-1-w",
"arrowrefresh-1-n",
"arrowrefresh-1-e",
"arrowrefresh-1-s"
],
[
"arrow-4",
"arrow-4-diag",
"extlink",
"newwin",
"refresh",
"shuffle",
"transfer-e-w",
"transferthick-e-w"
],
[
"folder-collapsed",
"folder-open",
"document",
"document-b",
"note",
"mail-closed",
"mail-open",
"suitcase",
"comment",
"person",
"print",
"trash",
"locked",
"unlocked",
"bookmark",
"tag"
],
[
"home",
"flag",
"calendar",
"cart",
"pencil",
"clock",
"disk",
"calculator",
"zoomin",
"zoomout",
"search",
"wrench",
"gear",
"heart",
"star",
"link"
],
[
"cancel",
"plus",
"plusthick",
"minus",
"minusthick",
"close",
"closethick",
"key",
"lightbulb",
"scissors",
"clipboard",
"copy",
"contact",
"image",
"video",
"script"
],
[
"alert",
"info",
"notice",
"help",
"check",
"bullet",
"radio-on",
"radio-off",
"pin-w",
"pin-s"
],
[
"play",
"pause",
"seek-next",
"seek-prev",
"seek-end",
"seek-start",
/* ui-icon-seek-first is deprecated, use ui-icon-seek-start instead */
"seek-first",
"stop",
"eject",
"volume-off",
"volume-on"
],
[
"power",
"signal-diag",
"signal",
"battery-0",
"battery-1",
"battery-2",
"battery-3"
],
[
"circle-plus",
"circle-minus",
"circle-close",
"circle-triangle-e",
"circle-triangle-s",
"circle-triangle-w",
"circle-triangle-n",
"circle-arrow-e",
"circle-arrow-s",
"circle-arrow-w",
"circle-arrow-n",
"circle-zoomin",
"circle-zoomout",
"circle-check"
],
[
"circlesmall-plus",
"circlesmall-minus",
"circlesmall-close",
"squaresmall-plus",
"squaresmall-minus",
"squaresmall-close",
"grip-dotted-vertical",
"grip-dotted-horizontal",
"grip-solid-vertical",
"grip-solid-horizontal",
"gripsmall-diagonal-se",
"grip-diagonal-se"
]
    ],
    classFormat : " { background-position: {axisX}px {axisY}px; }",
    jqPrintHere : null,
    create : function(){
        $("body").empty();
        $("body").html(
            "<div id=\"controller\"><label>가로(px)</label><input type=\"text\" id=\"textBox_Width\" value=\"16\" /> <label>세로(px)</label><input type=\"text\" id=\"textBox_Height\" value=\"16\" /> <label>접두어 - 점(.)은 자동으로 붙습니다.</label><input type=\"text\" id=\"textBox_Prefix\" value=\"ui-icon-\" /> <button type=\"button\" id=\"button_Make\">생성</button></div>" +
            "<textarea id=\"printHere\" style=\"width: 500px; height: 600px; border: #444 solid 1px;\"></textarea>"
        );
        
        this.jqPrintHere = $("#printHere");
        
        $("#button_Make").click(function(){
            Artn.ClassMaker.JQueryIcon.make(
                parseInt( $("#textBox_Width").val() ),
                parseInt( $("#textBox_Height").val() ),
                $("#textBox_Prefix").val()
            );
        });
    },
    print : function(sMessage){
        this.jqPrintHere.append(sMessage + "\r\n");
    },
    clear : function(){
        this.jqPrintHere.empty();
    },
    make : function(width, height, strPrefix){
        var iRowCount = this.classNameList.length;
        var iColCount = 0;
        var sFormating = "";
        var sName = "";
        
        this.clear();
        
        for (var iRow = 0; iRow < iRowCount; ++iRow){
            iColCount = this.classNameList[ iRow ].length;
            
            for (var iCol = 0; iCol < iColCount; ++ iCol){
                sName = this.classNameList[ iRow ][ iCol ];
                sFormating = this.classFormat.replace("{axisX}", (iCol * -width) + "");
                sFormating = sFormating.replace("{axisY}", (iRow * -height) + "");
                this.print( "." + strPrefix + sName + sFormating);
            }
        }
    }
};


$(document).ready(function(){
    Artn.ClassMaker.JQueryIcon.create();
});
/*
 * 
 * 
 */