/**
 * 썸네일 리스트 컨트롤러.<br/>
 * 문서에 미리 작성된 ol, ul 등의 요소를 대상으로 생성 한다.
 * @class
 */
function ThumbnailList(){
    this._jqContainer = null;
    this.option = null;
    this._selectedIndex = -1;
    this._length = 0;
    this._location = {
        first : 0,
        last : 0
    };
    
    this.evt_click = function(index){};
}

ThumbnailList.prototype = {
	/**
	 * 생성자.
	 * @param {String} sId 생성할 요소의 id.
	 * @param {Map} mOption 생성 시 필요한 옵션.
	 * <pre>
{    
visibility : hidden=숨김 | visible=보임,
itemWidth : 썸네일 이미지의 크기(Pixel),
itemTextLimit : //아이템 내 특정 키에 대한 텍스트의 문자 개수를 제한하여 보여줌.
	{
	key: 대상키, 
	limit: 글자개수(숫자)
	}, 
itemKeys : [
	설정된 데이터 중 사용될 키값들
	,
	...
	],
click : 클릭 시 수행될 이벤트 메서드.
}
	 * </pre>
	 * @returns {ThumbnailList}
	 */
    init : function(sId, mOption){
        this._jqContainer = $("#" + sId + " ol");
        //this._jqContainer.wrap("<div id=\"wrapper_ThumbnailItems\" />");
        
        if (mOption === undefined){
            this.option = {
                itemTags : "",
                itemkeys : []
            };
        }
        else{
            this._jqContainer.css({
                overflow : "hidden",
                position : "relative"
            });

            if (mOption.width && mOption.height){
                this._jqContainer.css({
                    width : mOption.width,
                    height : mOption.height
                });
            }
            if (mOption.visibility !== undefined){
            	this._jqContainer.css({
            		visibility : mOption.visibility
            	});
            }
            
            $.data(this._jqContainer[0], "thumbnail", this);
            this._jqContainer.siblings("a.ui-list-prev, a.ui-list-next")
                .data("thumbnail", this).click(this.onMoveCtrlClick);

            this.option = mOption;
            this.evt_click = this.option.click;
        }
        
        this.initItemTags();
        
        return this;
    },
    /**
     * 목록 내 아이템이 될 요소에 대하여 템플릿을 만든다.
     */
    initItemTags : function(){
    	this.option.itemTags = TrimPath.parseTemplate( 
    			"<li class=\"ui-corner-all\">\r\n<a href=\"#\">\r\n<img src=\"{if defined('file_img') && (file_img != '')}${file_img}{else}/img/Heal365-logo-mini.png{/if}\" alt=\"썸네일\"/>" +
    			"<span class=\"thumb-title\">{if defined('subject_movie') && (subject_movie != '')}${subject_movie}{else}제목 없음{/if}</span></a></li>" );
    },
    /**
     * 썸네일 목록의 가로 크기를 가져오거나 설정 한다.
     * @param {Integer} width 설정 할 가로크기
     * @returns {Integer}
     */
    width : function(width){
        if (width !== undefined){
            this._jqContainer.css("width", width);
        }
        else{
            return parseInt( this._jqContainer.css("width") ); 
        }
    },
    /**
     * 썸네일 목록의 세로 크기를 가져오거나 설정 한다.
     * @param {Integer} height 설정 할 세로크기
     * @returns {Integer}
     */
    height : function(height){
        if (height !== undefined){
            this._jqContainer.css("height", height);
        }
        else{
            return parseInt( this._jqContainer.css("height") );
        }
    },
    /**
     * 썸네일 목록에 데이터를 설정한다.<br/>
     * 설정 시 기존의 아이템 내용은 모두 제거 된다.
     * @param {List<Map>|Map[]} maItemData
     */
    setItems : function(maItemData){
        this.clear();
        this.addItemRange( maItemData );
    },
    /**
     * 썸네일 목록에 여러개의 데이터를 추가한다.
     * @param {List<Map>|Map[]} maItemData
     */
    addItemRange : function(maItemData){
        var iLen = maItemData.length;
        for(var i = 0; i < iLen; ++i){
            this.addItem( maItemData[i] );
        }
    },
    /**
     * 썸네일 목록에 하나의 데이터를 추가 한다.
     * @param {Map} mItemData
     */
    addItem : function(mItemData){
        this.itemDataLimitation(mItemData);
        
        var sInnerTag = this.option.itemTags.process( mItemData );
        
        var jqNodeContainer = this._jqContainer;
        var iLocation = this.option.itemWidth * this._length;
        
        if (this._length > 0){
            this._location.last = iLocation;
        }

        $(sInnerTag).appendTo(jqNodeContainer);
        
        jqNodeContainer.find("li:last-child a").click( this.onItemClick );
        jqNodeContainer.find("li:last-child").css({
            left : iLocation
        });
        
        if (this.option.itemClass !== undefined){
            jqNodeContainer.find("li:last-child").addClass( this.option.itemClass );
        }
        else{
            jqNodeContainer.find("li:last-child").css({
                display : "block",
                position : "absolute",
                top : 0
            });
        }
        
        ++this._length;
    },
    /**
     * 설정하는 데이터에 대하여 미리 지정된 옵션을 이용하여 텍스트 길이를 조정한다.<br/>
     * 사용되는 옵션은 option.itemTextLimit.key 와 option.itemTextLimit.limit 이며 init로 초기화 시 설정 된다.<br/>
     * 길이가 긴 텍스트는 설정한 만큼의 길이를 남기고 '...'을 붙여 주게 된다. 
     * @param {Map} mItemData 길이 조정을 할 데이터.
     */
    itemDataLimitation : function(mItemData){
        if (this.option.itemTextLimit){
            var sKey = this.option.itemTextLimit.key;
            var iLimit = this.option.itemTextLimit.limit;
            var iLen = mItemData.length;
            var sText = "";
            
            sText = mItemData[ sKey ];
            sText = (sText.length > iLimit)? sText.substring(0, iLimit) + "..." : sText;
            mItemData[ sKey ] = sText;
        }
    },
    /**
     * 썸네일 목록 내 모든 아이템을 비운다.
     */
    clear : function(){
        this._jqContainer.empty();
        this._length = 0;
        this._location.first = 0;
        this._location.last = 0;
    },
    /**
     * 썸네일 목록의 길이를 가져온다.
     * @returns {Integer}
     */
    count : function(){
        return this._jqContainer.children().length;
    },
    /**
     * 썸네일 목록에서 특정 인덱스에 해당되는 아이템이 사용자에게 보여지는지 여부를 확인한다.<br/>
     * 썸네일 컨트롤러에 가려진 상태를 비교하여 -1, 0, 1을 반환 한다.
     * @param {Integer} index 아이템 숨겨진 여부를 확인할 인덱스.
     * @returns {Integer} 0=모두 정상적으로 보여지는 상태<br/>
     * -1=좌측으로 조금이라도 숨겨진 상태<br/>
     * 1=우측으로 조금이라도 숨겨진 상태
     */
    checkItemShowing : function(index){
        var iItemLocation = this._location.first + (this.option.itemWidth * index);
        
        if ( iItemLocation < 0 ) return -1;
        if ( iItemLocation > (parseInt( this._jqContainer.css("width") ) - this.option.itemWidth) ) return 1;
        
        return 0;
    },
    /**
     * 썸네일을 이전(좌측)으로 1칸 이동 시킨다.
     */
    movePrev : function(){
        var iItemWidth = this.option.itemWidth;
        var iMoveDistance = this._location.first;
        iMoveDistance = Math.abs(iMoveDistance);
        
        if (iMoveDistance > 0){
            if (iMoveDistance > iItemWidth){
                iMoveDistance = iItemWidth;
            }
            this._location.first += iMoveDistance;
            this._location.last += iMoveDistance;
            this._jqContainer.find("li").animate({"left": "+=" + iMoveDistance + "px" }, 250);
        }
    },
    /**
     * 썸네일을 다음(우측)으로 1칸 이동 시킨다.
     */
    moveNext : function(){
        var iItemWidth = this.option.itemWidth;
        var iLastDistance = this._location.last;
        var iContainerWidth = parseInt( this._jqContainer.css("width") );
        var iMoveDistance =  iLastDistance - iContainerWidth + iItemWidth;

        if (iMoveDistance > 0){
            if (iMoveDistance > iItemWidth){
                iMoveDistance = iItemWidth;
            }
            this._location.first -= iMoveDistance;
            this._location.last -= iMoveDistance;
            this._jqContainer.find("li").animate({"left": "-=" + iMoveDistance + "px" }, 250);
        }
    },
    /**
     * <h4>프로퍼티</h4>
     * 현재 선택된 아이템에 대한 인덱스값을 가져오거나 인덱스 값에 따라 아이템을 직접 선택 한다.
     * @param {Integer} index 설정할 아이템에 대한 인덱스.
     * @returns {Integer} 현재 선택된 아이템에 대한 인덱스.
     */
    selectedIndex : function(index){
        if (index !== undefined){
            this._jqContainer.find("li").removeClass("selected");
            this._jqContainer.find("li:eq(" + index + ")").addClass("selected");
            this._selectedIndex = index;
            
            var iShowingDirection = this.checkItemShowing(index);
            
            while( iShowingDirection !== 0 ){
                switch( this.checkItemShowing(index) ){
                    case -1:
                        this.movePrev();
                        break;
                    case 1:
                        this.moveNext();
                        break;
                }
                iShowingDirection = this.checkItemShowing(index);
            } 
        }
        else{
            return this._selectedIndex;
        }
    },
    /**
     * @ignore
     * @returns {Boolean}
     */
    onMoveCtrlClick : function(){
        var instance = $.data(this, "thumbnail");

        if ($(this).hasClass("ui-list-prev") === true){
            instance.movePrev();
        }
        else{
            instance.moveNext();
        }
        
        return false;
    },
    /**
     * @ignore
     * @returns {Boolean}
     */
    onItemClick : function(){
        var jqListItem = $(this).parent();
        var index = jqListItem.prevAll().length;
        var instance = null;
        
        try{
        	instance = $.data(jqListItem.parent()[0], "thumbnail");
        }
        catch(e){
        	instance = this;
        }

        instance.selectedIndex( index );
        instance.onclick(index);
        
        return false;
    },
    /**
     * 아이템을 클릭했을 때 발생되는 이벤트.
     * @param {function} handler
     */
    click : function(handler){ this.evt_click = handler; },
    onclick : function(index){
        this.evt_click(index);
    }
    
};