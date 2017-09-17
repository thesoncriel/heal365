var Artn = Artn || {};
Artn.Const = {
	AJAX_LOADING_SMALL_CLASS : ".ajax-loading-mini",
	AJAX_LOADING_SMALL : "<span class=\"ajax-loading-mini\"></span>",
	XML_ROOT : "Artn",
	SEARCH_DLG_MOVIE_ACTION : "/movie/jsondata.action",
	SEARCH_DLG_COMB_ACTION : "/comb/jsondata.action",
    LOADING_TAGS : "<img id=\"img_Loading\" src=\"/img/loading.png\" alt=\"읽어오는 중...\" width=\"55\" height=\"55\"/>", 
    MAP_COORD : "/mapcoord",
    ZIPCODE : "/zipcode",
    ITEM_TAGS_COMB_LIST : "",
    
    ITEM_KEYWORDS_COMB_LIST : [
        "id_movie",
        "file_img",
        "subject_movie"
    ],
    
    Player : {
        PLAYER_TAGS : "",
        /// TODO: 웹서버 적용 시 JSP로 만들어지는 JSON에 직접 해당 내용을 기록하도록 할것 
        PATH_IMG : "/player/media?path=media/img/&fileName=",// "/media/img/",
        PATH_WEBM : "/player/media?path=media/webm/&fileName=",// "/media/webm/",
        PATH_MP4 : "/player/media?path=media/mp4/&fileName=",// "/media/mp4/",
        PATH_OGG : "/player/media?path=media/ogg/&fileName=",//"/media/ogg/",
        PATH_MP3 : "/player/media?path=media/mp3/&fileName=",//"/media/mp3/",
        PATH_THUMB : "/player/media?path=media/thumb/&fileName=",//"/media/thumb/",
        PATH_MP4NARR : "/player/media?path=media/mp4narr/&fileName=",//"/media/mp4narr/"
        /// TODO: 개별 테스트 용
        // PATH_IMG : "media/img/",
        // PATH_WEBM : "media/webm/",
        // PATH_MP4 : "media/mp4/",
        // PATH_OGG : "media/ogg/",
        // PATH_MP3 : "media/mp3/",
        // PATH_THUMB : "media/thumb/",
    }
};