

Artn.Sortable = function(){
	this.SEARCH_DIALOG = "#dialog_MovieSelector";
    this.INIT_VALUES_LIST = ".list-values";
    this._itemTags = "";
    this._itemKeys = [];
    this._containerSelector = "";
    this._dialogItem = {};
};

Artn.Sortable.prototype = {
	/*
	 * mParams = {
	 * 	tags : "tags string",
	 *  keys : [], // array of string
	 *  dialogItem : [
	 *   {class : "field name string", dialog : {inherited class of Artn.AbsInputDialog} }
	 *  ]
	 * }
	 * */
	init : function(strSelector, mParams){
        if ( $(strSelector).length < 1 ) return;
        
        var jqContainer = $(strSelector);
        
        this._containerSelector = strSelector;
        this._itemTags = mParams.tags;
        this._itemKeys = mParams.keys;
        this._dialogItem = mParams.dialogItem || [];
        
        jqContainer.sortable({
            beforeStop: function(event, ui){
            	var inst = $(this).data("inst");
                inst.renumber();
            }
        });
        
        jqContainer.disableSelection();
        jqContainer.data("inst", this);

        this.initList();
        //this.renumber();
        
        return this;
    },
//    renumber : function(){
//        $(this._containerSelector + " li .seq").each(function(index){
//            $(this).text( index + 1 );
//            $(this).nextAll( "input[name='seq']" ).attr( "value", index + 1 );
//        });
//    },
    addItemRange : function(jsonData){
        var iLen = jsonData.length;
        
        for(var i = 0; i < iLen; ++i){
            this.addItem( jsonData[i] );
        }
        
        this.renumber();
    },
    addItem : function(mapItemData){
        var sInnerTag = Artn.Util.replaceTemplate(
            this._itemTags, this._itemKeys , mapItemData);
        
        var jqNodeContainer = $(this._containerSelector);
        var iLenDialog = this._dialogItem.length;
        var aDlgItem = this._dialogItem;
        var sItemSelector = "";
        var jqItemDelete = null;
        var jqItemUp = null;
        var jqItemDown = null;

        $(sInnerTag).appendTo(jqNodeContainer);
        
        for (var i = 0; i < iLenDialog; ++i){
        	sItemSelector = this._containerSelector + " li:last-child ." + aDlgItem[i]["class"];
        	aDlgItem[i].dialog.regist( sItemSelector );
        }
        
        jqItemDelete = $( this._containerSelector + " li:last-child .delete" );
        jqItemDelete.data("inst", this);
        jqItemDelete.click( this.ondeleteclick );
        
        $(this._containerSelector).find("li:last-child .itemup").click({inst: this, item: mapItemData}, this.onitemupclick);
        $(this._containerSelector).find("li:last-child .itemdown").click({inst: this, item: mapItemData}, this.onitemdownclick);
        
    },
//    initList : function(){
//    	var aDlgItem = this._dialogItem;
//    	var iLenDialog = this._dialogItem.length;
//    	var sortable = this;
//    	var jqItem = null;
//    	
//    	for (var i = 0; i < iLenDialog; ++i){
//        	sItemSelector = this._containerSelector + " li ." + aDlgItem[i]["class"];
//        	aDlgItem[i].dialog.regist( sItemSelector );
//        }
//    	
//    	$( this._containerSelector + " li .delete" ).each(function(index){
//    		jqItem = $(this);
//    		jqItem.data("inst", sortable);
//    		jqItem.click( sortable.onDeleteClick );
//    	});
//    	$( this._containerSelector + " li .itemup" ).each(function(index){
//    		$(this).click({inst: sortable}, sortable.onitemupclick);
//    	});
//    	$( this._containerSelector + " li .itemdown" ).each(function(index){
//    		$(this).click({inst: sortable}, sortable.onitemdownclick);
//    	});
////        var maListValues = Artn.Util.convertHiddenValuesToMaps(this.INIT_VALUES_LIST, this._itemKeys);
////        var iRowCnt = maListValues.length;
////
////        this.clear();
////        
////        for (var iRow = 0; iRow < iRowCnt; ++iRow){
////            this.addItem( maListValues[ iRow ] );
////        }
//    },
    ondeleteclick : function(){
    	var inst = $(this).data("inst");
    	
        $(this).parent().remove();
        inst.renumber();
        
        return false;
    },
    onitemupclick : function(e){
    	var jqLi = $(this).parents("li");
    	jqLi.after(jqLi.prev());
    	e.data.inst.renumber();
    	
    	return false;
    },
    onitemdownclick : function(e){
    	var jqLi = $(this).parents("li");
    	jqLi.before(jqLi.next());
    	e.data.inst.renumber();
    	
    	return false;
    }
};




