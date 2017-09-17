$(document).ready(function(){
    var fnCateMovie0Change = function(){
    	var sValue = $("*[name='cate_movie0']").val();
    	$("select[name='cate_movie2'], select[name='cate_movie3']").each(function(index){
    		$(this).attr("disabled", (sValue !== "SF"));
    		if (sValue !== "SF") $(this).val("");
    	});
    };
    
    Artn.ComboChain.create();
    fnCateMovie0Change();
    $("select[name='cate_movie0']").change(fnCateMovie0Change);
    $("select[name='cate_movie1']").change(function(){
    	var sAction = $(this).parents("form").attr("action");
    	
    	
    	if ( $("form[action='" + sAction + "'] select[name='cate_movie0']").val() !== "SF" ){
    		$("form[action='" + sAction + "'] select[name='cate_movie3']").attr("disabled", "disabled");
    	}
    });
    
    try{
    /* 영상 조합 부분 [시작] */
	    if ( $("#sortable_MovieContent365plus").length > 0 ){
	    	Artn.SortableList.inst[ "#sortable_MovieContent365plus" ].setOption("dialog", [
	        	{
	        		name: "nth",
		        	dialog: new artn.lib.SpinnerDialog().init("#dialog_Nth")
	        	},
	        	{
	        		name: "left_right",
		        	dialog: new artn.lib.RadioDialog().init("#dialog_LeftRight")
	        	},
	        	{
	        		name: "popup",
		        	dialog: new artn.lib.PopupOptionDialog().init("#dialog_PopupOption", ["popup", "popup_msg", "popup_action"])
	        	}
		    ]);
	    }
	    else{
//	    	Artn.SortableList.inst[ "#sortable_MovieContent" ].setOption("dialog",
//	    		[{
//	    			name : "repeat_cnt",
//	    			dialog: new artn.lib.SpinnerDialog().init("#dialog_RepeatCnt")
//	    		}]
//			);
	    }
    }
    catch(e){}
   
    try{
    	// 처방전의 영상 조합 시 조합에서 따오기위한 이벤트 설정 부분 - 2013.10.11 by shkang
    	Artn.InfiniteList.inst["#infinitelist_CombSearch"]
    	.itemdblclick(function(e){
    		$.getJSON("/comb/jsonsublist?json=true", {"id": e.item["id"]}, function(data){
    			var i=0;
    			var iEnd=data.length;
    			
    			for(i; i<iEnd; i++){
    				Artn.List.inst["#list_StorePlaceComb"].addItem( data[i] );
    			}    			
    		});    		
    	})
    	.selectclick(function(e){
    		$.getJSON("/comb/jsonsublist.action?json=true", {"id": e.item["id"]}, function(data){
    			var i=0;
    			var iEnd=data.length;
    			
    			for(i; i<iEnd; i++){
    				Artn.List.inst["#list_StorePlaceComb"].addItem( data[i] );
    			}    			
    		});      		
    	});

    }
    catch(e){}
    /* 영상 조합 부분 [종료] */
    
    
    
    // 처방전용
    $("select[name='date_end_week'], input[name='date_upload']").change(function(){
    	var iWeekVal = parseInt( $("select[name='date_end_week']").val() );
    	$("input[name='date_end']").val( Artn.Util.addDate( new Date( $("input[name='date_upload']").val() ), iWeekVal * 7 ) );
    });
    
    $("select[name='weekly_chk_daily']").change(function(){
    	var jqWeeklyChkDaily = $(this);
    	var jqWeeklyChk = $("select[name='weekly_chk']");
    	
    	jqWeeklyChk.attr("disabled", parseInt(jqWeeklyChkDaily.val()) > 0 );
    	jqWeeklyChk.val( jqWeeklyChkDaily.val() );
    });
    
    $("select[name='cate_movie1']").change(function(){
    	var sVal = $(this).val();
    	var sId = $("input[name='id']").val();
    	
    	$.get("/include/prescript/rom.jsp", {cate_movie1: sVal, rom: "000"}, function(data){
    		$("#rom").html(data);
    	});
    });
    
    try{
    	$("input[name='diagnosis'], input[name='user_name']").focusout(function(e){
			$("input[name='subject_comb']").val( $("input[name='user_name']").val()  + "님의 " + $("input[name='diagnosis']").val() + " 운동");
	    });
    }
    catch(ex){}
    
    
    $(".prescript.edit form").submit(function(){
    	if ($(this).find("input[name='diagnosis']").val().length < 1){
    		alert("진단명은 필수로 입력 하여 주십시요.");
    		$(this).find("input[name='diagnosis']").focus();
    		return false;
    	}
    	if ($(this).find("input[name='name']").val().length < 2){
    		alert("환자명은 필수로 입력 하여 주십시요.");
    		$(this).find("input[name='name']").focus();
    		return false;
    	}
    	if ($(this).find("input[name='id_user']").val().length < 2){
    		alert("환자 정보가 부족합니다.\r\n해당 환자명으로 회원 가입이 되어 있는지 확인하여 주십시요.");
    		$(this).find("input[name='name']").focus();
    		return false;
    	}
    	return true;
    });
    // toolTip by shkang_2014.01.22 [시작]
    function toolTip(jqThis){
    	jqThis.tooltip("option", "content", jqThis.siblings("span").html());	
    };
    $(".medi-user-patient").mouseover(function(){
    	$(".medi-user-patient").attr("title","");
    	$(".medi-user-patient").tooltip("close");
    	var sUserId = $(this).siblings(".id_user").val();
    	Artn.Ajax.mediUser = Artn.Ajax.mediUser || {};
    	var jqThis = $(this);
    	var jqTemplate = jqThis.parent();
		var sTemp = Artn.Util.extractTemplate( jqTemplate );
    	if(Artn.Ajax.mediUser[ sUserId ] === undefined){
    		$.getJSON("/mediuser/showPatient",{"json": true, "id_user": sUserId}, function(data){
    			if(data.name !== undefined){
    				Artn.Ajax.mediUser[sUserId] = data;
            		jqThis.siblings("span").html(Artn.Util.replaceTemplate(sTemp, data));	
    			}
    			else{
    				jqThis.siblings("span").html("정보가 존재하지 않습니다.");
    			}
    			toolTip(jqThis);
    		});
    	}else{
    		if(Artn.Ajax.mediUser[sUserId].name !== undefined){
    			jqThis.siblings("span").html(Artn.Util.replaceTemplate(sTemp, Artn.Ajax.mediUser[sUserId]));	
    		}
    		else{
    			jqThis.siblings("span").html("정보가 존재하지 않습니다.");
    		}
    		toolTip(jqThis);
    	}
    });
//    $(".medi-user-patient").mouseout(function(){
//    	$(this).tooltip({
//    		close: function(event, ui){}
//    	});
//    	$(this).tooltip("close");
//    });
    $(".medi-user-patient").tooltip({track: true,content: " "}); //content에 공백 지우지 말것. 지우면 처음 마우스 오버시 툴팁 안나옴
    // toolTip by shkang_2014.01.22 [끝]
    
    $("#batchSelect").change(function(){
		var sVal = $("#batchSelect").val();
		$("#sortable_MovieContent select[name='repeat_cnt']").val(sVal);
	});
    
    $(".prescript-search #selectbox_search_div").change(function(){
    	var jqDatepicker = $("#datepicker_dateUpload");
    	var jqSearchText = $("#textbox_search_text");
    	
    	jqDatepicker.val("");
    	jqSearchText.val("");
    	
    	if ($(this).val() === "date_upload"){
    		jqDatepicker.attr("disabled", false);
    		jqDatepicker.show();
    		jqSearchText.hide();
    	}
    	else{
    		jqDatepicker.attr("disabled", true);
    		jqDatepicker.hide();
    		jqSearchText.show();
    	}
    });
    $(".prescript .slideToggle").click(function(){
    	if($(this).children("span").text() == "+"){
            $(this).children("span").text("-");
			oneHeight($(this).next().attr("class"), "open");
            $(this).next(".slideUp").slideDown();
            $(this).next(".slideUp").addClass("slideDown");
            $(this).next(".slideUp").removeClass("slideUp");
        }else if($(this).children("span").text() == "-"){
            $(this).children("span").text("+");
			oneHeight($(this).next().attr("class"), "close");
            $(this).next(".slideDown").slideUp();
            $(this).next(".slideDown").addClass("slideUp");
            $(this).next(".slideDown").removeClass("slideDown");
        }
        return false;
    });
	
    $(".prescript .totalslideToggle").click(function(){
		if($(this).text() == "전체 보기"){
            $(this).text("전체 닫기");
            $(".slideToggle").children("span").text("-");
            $(".slideUp").slideDown();
            $(".slideUp").addClass("slideDown");
            $(".slideUp").removeClass("slideUp");
			iframeHeight(exerciseHeight,"open");
        }else if($(this).text() == "전체 닫기"){
            $(this).text("전체 보기");
            $(".slideToggle").children("span").text("+");
            $(".slideDown").slideUp();
            $(".slideDown").addClass("slideUp");
            $(".slideDown").removeClass("slideDown");
			iframeHeight(exerciseHeight,"close");
        }
        return false;
    });
    // 처방전 끗
    
    
	// 힐링업 플레이어 [시작] - 2013.06.01 by jhson
    
    try{
    	Artn.PlayerManager = new ContentManager().init();
	    Artn.PlayerManager.setDataFromUrl( $("#player-track-info").val() );
	    //Artn.PlayerManager.setDataFromUrl(
	    //    "artn://comb.do?view=json&id=" + "20130225162551" 
	    //);
    }catch(e){
    	//alert(e);
    }
    // 힐링업 플레이어 [종료] - 2013.06.01 by jhson

    //영상등록 썸네일 다이얼로그 시작 
    
    $("#dialog_player").dialog("option", "width", 355);

    $( "#img_Thumbnail" ).click(function() {
        $( "*[id^='dialog']" ).dialog( "open" );
        return false;
    });  
    //영상등록 썸네일 다이얼로그 끝
    
    //통증강도 슬라이드 선택 시작
    var dVasHigh = ( ($("#vas_high").val() === '')? 5.0 : $("#vas_high").val() );
    
    $("#slider_Vas").slider({
        min: 1.0,
        max: 10.0,
        step: 1.0,
        value: dVasHigh,
        range: "min",
        orientation: "vertical",
        
    	stop: function(event, ui){
            $("#vas_high").val(ui.value);
            $("#result").html("통증강도:" + ui.value + ".0"); 
        }
    });
    
    $("#vas_high").val(dVasHigh);
    //통증강도 슬라이드 선택 끝
    
    //통증부위 선택 1번째 이미지 변환 시작
    $("map[name='body_selector'] area").hover(
  		function(){
  			var jqImg = $(this).parent().prev();
  			Artn.bodySelectorImg = jqImg.attr("src");
    		jqImg.attr("src", "/img/365plus/body/" + $(this).attr("alt") + ".png");
    	},
    	function(){
    		$(this).parent().prev().attr("src", Artn.bodySelectorImg);
    		Artn.bodySelectorImg = undefined;
    	}
   	);
    
    
    $("map[name='body_selector'] area").click(
    	function(){
    		var jqImg = $(this).parent().prev();
    		var sImgPath = "/img/365plus/body/" + $(this).attr("alt") + ".png";
    		var jqCateMovie = $("input[name='cate_movie1']");
    		var saAreaAlt = $(this).attr("alt").split(".");
    		var iCateMovie = parseInt( saAreaAlt[0] );
    		
        	jqImg.attr("src", sImgPath);
        	Artn.bodySelectorImg = sImgPath;
        	$("#position").show(0);
        	jqCateMovie.val(saAreaAlt[0]);
        	
        	$("input[name='left_right']").val(saAreaAlt[1]);
        	
        	if ( (iCateMovie === 1) || (iCateMovie === 7) ) {
        		$("#position ul li").eq(2).show(0);
        	}
        	else{
        		$("#position ul li").eq(2).hide(0);
        	}
        	
        	return false;
    	}
    );
    
    $("#position form ul li a").click(function(){
    	var jqAnchor = $(this);
    	var jqHiddenDirection = $("input[name='direction']");
    	var sVal = "";
    	
    	if (jqAnchor.text() === "앞"){
    		jqHiddenDirection.val("F");
    	}
    	else if (jqAnchor.text() === "뒤"){
    		jqHiddenDirection.val("B");
    	}
		else if (jqAnchor.text() === "옆"){
			jqHiddenDirection.val("S");
    	}
    	
    	$("#position form").submit();
    });
    //통증부위 선택 1번째 이미지 변환 끝
    
    //통증부위 선택 세부사항 이미지 변환 시작
    $("map[name='pain_map'] area").hover(
   		function(){
     		var jqImg = $(this).parent().prev();
     		var sImgFolder = $("input[name='cate_movie1']").val() + $("input[name='direction']").val() + $("input[name='left_right']").val();
     		Artn.bodySelectorImg = jqImg.attr("src");
       		jqImg.attr("src", "/img/365plus/" + sImgFolder + "/" + $(this).attr("alt") + ".png");
       	},
       	function(){
       		$(this).parent().prev().attr("src", Artn.bodySelectorImg);
       		Artn.bodySelectorImg = undefined;
       	}
    );
    
    $("map[name='pain_map'] area").click(
       	function(){
       		var jqImg = $(this).parent().prev();
       		var sImgFolder = $("input[name='cate_movie1']").val() + $("input[name='direction']").val() + $("input[name='left_right']").val();
       		var sImgPath = "/img/365plus/" + sImgFolder + "/" + $(this).attr("alt") + ".png";
           	jqImg.attr("src", sImgPath);
           	Artn.bodySelectorImg = sImgPath;
           	$("#position").attr("style", "display: block");
           	$("input[name='cate_movie1']").attr("value", $(this).attr("alt").split(".")[0]);
           	$("input[name='cate_movie2']").attr("value", $(this).attr("alt").split(".")[1]);
           	$("input[name='cate_movie3']").attr("value", $(this).attr("alt").split(".")[2]);
           	return false;
       	}
    );
    
    $("#form_MovieSearch").superLabels({
    	labelLeft: 5,
    	labelTop: 5
    });
    $("#asyncsearchform_MovieSearch").superLabels({
    	labelLeft: 5,
    	labelTop: 5
    });
    
    $("#form_CombSearch").superLabels({
    	labelLeft: 5,
    	labelTop: 5
    });
    $("#asyncsearchform_CombSearch").superLabels({
    	labelLeft: 5,
    	labelTop: 5
    });
    
    
    //FIXME: 상세검색 부분이 중복됨. 확인하고 수정 바람 - by jhson - 2013.07.12
    $("#search-comb-detail").hide();
    $("#search-movie-detail").hide();
    $("a[href$='search-comb-detail']").click(function(){
    	$("#search-comb-detail").fadeToggle();
    	return false;
    });
    $("a[href$='search-movie-detail']").click(function(){
    	$("#search-movie-detail").fadeToggle();
    	return false;
    });
    
    $("select[name='group_id']").change(function(){
        if( $("select[name='group_id']").val() === '0' ) {
            $("input[name='group_name']").attr("readonly", false);
            $("input[name='group_name']").val("");
        }
        else {
            // $("input[name='group_name']").val("value", $("select[name='group_id']").val());
            $("input[name='group_name']").attr("readonly", true);
            $("input[name='group_name']").val($("select[name='group_id']").children("option:selected").text());
        }
    });
    $("select[name='emailSub']").change(function(){
        if( $("select[name='emailSub']").val() === ' ' ) {
            $("#emailSub").attr("readonly", false);
            $("#emailSub").val("");
        }
        else {
            // $("input[name='group_name']").val("value", $("select[name='group_id']").val());
            $("#emailSub").attr("readonly", true);
            $("#emailSub").val($("select[name='emailSub']").children("option:selected").text());
        }
    });

    // 익스플로러 버전 확인
    if($.browser.msie==true) {
        if($.browser.version < 8){
        	$("#dialog_browser-down").dialog("option", {
                	modal: true,//다이얼로그 외에는 클릭 안됨
                	width: 850,
            		height: 750
        	});
            //브라우져 다이얼로그 시작
            	$("#dialog_browser-down").dialog("open");
        }
    }
    
    // 클릭시 익스플로러 버전 확인
    $(".browserCheck").click(function(){
    	//alert($.browser.msie + " : " + $.browser.version);
    	if($.browser.msie==true) {
            if($.browser.version < 8){
            	$("#dialog_browserClick-down").dialog("option", {
                    	modal: true,//다이얼로그 외에는 클릭 안됨
                    	width: 850,
                		height: 750
            	});
                //브라우져 다이얼로그 시작
                	$("#dialog_browserClick-down").dialog("open");
                return false;
            }
        }
    	return true;
    });

    //통증부위선택 안했을시 alret
    $(".365plus-selector2 input[type='submit']").click(function(){
    	if($(".365plus-selector2 input[name='cate_movie3']").val() === ""){
    		alert("통증부위를 선택해 주세요");
    		return false;
    	}
    	return true;
    });

    
    $("#service_form input[type='submit']").click(function(){
    	var bRet = true;
        $("#service_form input").each(function(index){
        	var sName = $(this).attr("name");
                if(sName !== "url" && sName !== "date_upload" && $(this).val() === ""){  // 공란 확인
                    alert( $(this).parent().prev().children("label").text() + "을(를) 입력해주세요.");
                    $(this).focus();
                    bRet = false;
                    return false;
                }
        });
        
        if($("#service_form textarea[name = 'content']").val() === ""){
        	alert("내용을 입력해주세요.");
        	$("textarea[name = 'content']").focus();
            bRet = false;
            return false;
        }
        if(bRet === true){
        	alert("신청이 완료 되었습니다.");
        }
        return bRet;
    });
    
    
    
    $("#delete").click(function(){
    	var deleteOk = confirm("삭제 하시겠습니까?");
    	if(deleteOk === true){
    		alert("삭제가 완료되었습니다.");
    		return;
    	} else {
    		return false;
    	}
    });
    
/*    console.log($("button").length);
    console.log($("#button_mediQuestionOpen").length + "빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠빠");
    console.log("bb");

    $("#button_mediQuestionOpen").click(function(){
		console.log("aa");
		var jqChildDocument = $( $("iframe").get(0).contentDocument );
		jqChildDocument.find("input[name='id_user']").val( $("input[name='id_user']").val() );
		jqChildDocument.find("input[name='id_group']").val( $("input[name='id_group']").val() );
	});*/
    
    	(function(){
    		if( ($(".medi-qustion").length >= 1) && ($(".medi-check").length >= 1) && ($(".physics").length >= 1) ){
    			try{
    	    		Artn.AutoComplete.inst["#autocomplete_user_name"].selected(function(e){
    	            	console.log("group"+e.item.data.id_group);
    	            	var sGender = e.item.data.user_gender_kor;
    	            	if(sGender == "남자"){
    	            		$("#img_painSite").attr("src","/img/prescript-body.png");
    	            	}else{
    	            		$("#img_painSite").attr("src","/img/prescript-body-female.png");
    	            	}
    	            	$.getJSON("/medi/question/show?json=true", {"id_medi":e.item.data.id_group, "id_user":e.item.data.id_user}, function(data){
    	            		   var iCheck = parseInt(data.check);
    	            		   if($.isEmptyObject(data) == true){
    	            			    $(".medi-qustion table td > span").text("");
    	            			    $(".medi-qustion table td > input[type='radio']").removeAttr("checked");
    	            		   }else{
    	            			   for(var o in data){        			   
    	                			   $(".medi-qustion span."+o ).text(data[o]);
    	                			   if(o === "id_medi_question"){
    	                				   $(".medi-qustion .id_medi_question").val(data[o]);
    	                			   }
    	                			   if(o === "check"){
    	                				   for(var i = 0; i < 6; i++){
    	                        			   if( (iCheck & (1 << i)) > 0 ){            				   
    	                        				   $(".medi-qustion #check"+i+"y" ).attr("checked", "checked");
    	                        			   } else{
    	                        				   $(".medi-qustion #check"+i+"n" ).attr("checked", "checked");
    	                        			   }
    	                        		   }
    	                			   }
    	                			   if(o === "height"){
    	                				   $(".diagnosis").find("input[name='height']").val(data[o]);
    	                			   }
    	                			   if(o === "weight"){
    	                				   $(".diagnosis").find("input[name='weight']").val(data[o]);
    	                			   }
    	                		   }
    	            		   }   		   
    	            		   
    	            		   		   
    	            		   /*$(".medi-qustion span.weight").text(data.weight);*/
    	            	});
    	            	$.getJSON("/medicheck/progress/show?json=true", {"id_medi":e.item.data.id_group, "id_user":e.item.data.id_user}, function(data){
    	            		if(data.error !== undefined){
    	            			alert("건강검진 결과가 없습니다");
    	            		}
    	            		if($.isEmptyObject(data) == true){
    	            			$(".medi-check table td > span").text("");
    	            		} else{
    	            			for(var o in data){
    	            				if(data[o].id_complete !== undefined){
    	            					$(".id_medi_check").val(data[o].id_complete);
    	            				}
    	            				if(data[o].date_upload_fmt !== undefined){
    	            					$(".medi-check .date_upload_fmt").text(data[o].date_upload_fmt);
    	            				}
    	            				if(data[o].field_value == undefined){
    	            					if(data[o].field_type == 0){
    	            						$(".medi-check .group"+data[o].position_group+"_"+data[o].position_seq+"").text("0"+data[o].field_unit);
    	            					}else{
    	            						$(".medi-check .group"+data[o].position_group+"_"+data[o].position_seq+"").text("미측정");
    	            					}
    	            				}else{
    	            					if(data[o].field_type == 0){
        	            					$(".medi-check .group"+data[o].position_group+"_"+data[o].position_seq+"").text(data[o].field_value+data[o].field_unit);	
        	            				}else{
        	            					$(".medi-check .group"+data[o].position_group+"_"+data[o].position_seq+"").text(data[o].field_result);
        	            				}
    	            				}
    	                 		}
    	            		}        		
    	            	});
    	            	$.getJSON("/physics/progress/show?json=true", {"id_medi":e.item.data.id_group, "id_user":e.item.data.id_user}, function(data){
    	            		if(data.error !== undefined){
    	            			alert("물리치료 결과가 없습니다");
    	            		}
    	            		if($.isEmptyObject(data) == true){
    	            			$(".physics table td > span").text("");
    	            		} else{
    	            			var painCheck = 0;
    	            			for(var o in data){
    	            				if(data[o].id_complete !== undefined){
    	            					$(".id_physics").val(data[o].id_complete);
    	            				}
    	            				if(data[o].date_upload_fmt !== undefined){
    	            					$(".physics .date_upload_fmt").text(data[o].date_upload_fmt);
    	            				}
    	            				if(data[o].pain_site_check !== undefined && painCheck == 0){
    	            					painCheck = 1;
    	            					setPainSiteCheck(data[o].pain_site_check);
    	            				}
    	            				if(data[o].field_value == undefined){
    	            					if(data[o].field_type == 0){
    	            						$(".physics .group"+data[o].position_group+"_"+data[o].position_seq+"").text("0"+data[o].field_unit);
    	            					}else{
    	            						$(".physics .group"+data[o].position_group+"_"+data[o].position_seq+"").text("미측정");
    	            					}
    	            				}else{
    	            					if(data[o].field_type == 0){
        	            					$(".physics .group"+data[o].position_group+"_"+data[o].position_seq+"").text(data[o].field_value+data[o].field_unit);	
        	            				}else{
        	            					$(".physics .group"+data[o].position_group+"_"+data[o].position_seq+"").text(data[o].field_result);
        	            				}
    	            				}
    	            				if(data[o].comment_approver){
    	            					$(".comment_approver").text(data[o].comment_approver);
    	            				}
    	            				if(data[o].approver_name){
    	            					$(".approver_name").text(data[o].approver_name);
    	            				}
    	            				if(data[o].date_approve){
    	            					$(".date_approve").text(data[o].date_approve);
    	            				}
    	                 		}
    	            		}        		
    	            	});
    	            });
        	    } catch(e){}
    		}else{
    			return;
    		}
    	})();
    	$(".prescript .listSearch").click(function(){
			var sHref = $(this).attr("href");
			sHref += "&id_user="+$("input[name='id_user']").val();
			$(this).attr("href",sHref);
		});
    	function setPainSiteCheck(iPainSiteCheck){
    		var value = 0;
    		var sPainSiteCheck = "";
    		$("#checkboxlist_painSiteCheck").find("label").each(function(index){
    			value = $(this).siblings("input").val();
    			if( (iPainSiteCheck & value) > 0 ){
    				sPainSiteCheck += $(this).text() + "/ ";
    			}
    		
    		});
    		$(".physics .pain_site_check").text(sPainSiteCheck);
    	}
    	
    	(function(){
    		if( $("#autocomplete_user_name").length = 1 ){
    			$(".validator").submit(function(){
    				if($("input[name='id_user']").val() == ""){
    					alert("※자동완성 기능을 이용하여 선택하여주세요. \n 가입되지 않은 회원은 작성하실 수 없습니다.");
    					return false;
    				}
    				return ture;
    			});
    		}
    	})();
    	
    	//엑셀 다운로드 다이얼로그 창 오픈 - 2014.04.24 by shkang [시작]
    	(function(){
        	if($(".openExcelDown").length >= 1){
        		$(".openExcelDown").click(function(){
        	        $("#dialog_excel").dialog("open");
        	    });
        	    $(".excelDown").click(function(){
        	    	var sUrl = $(this).data("url");
        	        var sExcelDate = "&excelYear=" + $("#excelYear").val() + "&excelMonth=" + $("#excelMonth").val();
        	        $(this).attr("href", sUrl+sExcelDate);
        	        $("#dialog_excel").dialog("close");
        	    });
        	    $(".excelCancel").click(function(){
        	        $("#dialog_excel").dialog("close");
        	    });
        	}
        })();
    	//엑셀 다운로드 다이얼로그 창 오픈 - 2014.04.24 by shkang [종료]
    	
/*   $(".prescript.edit user-info span.user_gender_kor").text().change(function(){
	  alert("안뇽"); 
   });
   $getJSON("asdf?json=true", {"id_medi":$("").val(), "asdf":$("asdf").text()}, function(data){
	   
   });*/

	
	/// 처방전 프린팅 기능 - 2013.12.12 by jhson [시작]
    $("#button_printPrescript").click(function(){
    	popup( $(".article.prescript.show") );
    });
    /// 처방전 프린팅 기능 - 2013.12.12 by jhson [종료]
    
    /* 건강검진 집계표 - 2013.12.24 by yyj [시작]*/
    /*건강검진 집계표 - 2013.12.27 by shkang [편집]*/
    /*$(".totallength").each(function(){
    	var iTotal=0;
    	$(this).children(".sfiled").each(function(){
    		iTotal += parseInt($(this).text());
    	});
    	$(this).children(".totalfiled").text(iTotal);
    });
    $(".totalization").each(function(){
    	var iTotal=0;
    	$(this).children(".tdtotalization").each(function(){
    		iTotal += parseInt($(this).text());
    	});
    	$(this).children(".alltotalization").text(iTotal);
    });*/
    /* 건강검진 집계표 - 2013.12.24 by yyj[종료]*/ 
    
    /* 병원 선택 - 2014.01.22 shkang [시작] */
    $("select[name='changeGroup']").change(function(){
    	var iIdGroup = $(this).children("option:selected").val();
    	var sGroupName = $(this).children("option:selected").text();
    	if($("select[name='changeGroup']").get(0).selectedIndex > 0){
        	setIdGroup(iIdGroup,sGroupName);
    	}
    });
    
    $(".group_select").click(function(){
    	if($("select[name='changeGroup']").get(0).selectedIndex === 0){
    		$("#dialog_group #url").val($(this).attr("href"));
    		$("#dialog_group").dialog("open");
    		return false;
    	}
    });
    /*$("#dialog_group ul li").click(function(){
    	setIdGroup($(this).children("input").val());
    });*/
    $("#dialog_group select").change(function(){
    	var iIdGroup = $(this).children("option:selected").val();
    	var sGroupName = $(this).children("option:selected").text();
    	var sUrl = $(this).parent().children("#url").val();
    	if($("#changeGroup").get(0).selectedIndex > 0){
        	setIdGroup(iIdGroup, sGroupName, sUrl);
    	}
    });
    function setIdGroup(idGroup, sGroupName, sUrl){
    	$.post("/heal365/saveIdMedi",{"idGroup" : idGroup, "groupName":sGroupName},function(data){
    		if(data == "success"){
    			if(sUrl !== undefined){
    				//parent.document.location.href = sUrl;	yyj 수정
    				document.location.href = sUrl;	
    			}else{
    				location.reload();
    			}
    			 
    		}else{
    			alert("실패하였습니다.");
    		}
    	});
    };
    /* 병원 선택 - 2014.01.23 shkang [종료] */
    /* 물리치료 최종 검수자 입력시 셀렉트 value/text inputbox로 옴기기 - 20140122 thkim [시작] */
    $("select[name='approver']").change(function(){
		var iOptionIndex = $("select[name='approver']").get(0).selectedIndex;		
		$("input[name='id_approver']").val($("select[name='approver']").val());
		$("input[name='approver_name']").val($("select[name='approver']").children("option").eq(iOptionIndex).text());
	});
    /* 물리치료 최종 검수자 입력시 셀렉트 value/text inputbox로 옴기기 - 20140122 thkim [종료] */
});

/// 처방전 프린팅 기능 - 2013.12.12 by jhson [시작]
var mywindow = null;
function popup(jqElem){
	mywindow = window.open('', 'mypopup', 'height=800,width=800');
    mywindow.document.write('<!DOCTYPE html><html><head><title>popup</title>');
    mywindow.document.write(
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/redmond/jquery-ui-1.9.2.custom.min.css\"/>" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/jqplot/jquery.jqplot.min.css\"/>" +

"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/artn-theme.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/artn-theme-board.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/player.css\"/>" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/gnb.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/left-menu.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/footer.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/index.css\" />" +        
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/company.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/user.css\" />" +  
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/member-join.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/admin.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/prescript.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/me/mejs-skins.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/me/mediaelementplayer.min.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/product_info.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/sub4_1_1.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/sub4_1_2.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/sub4_2_2.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/sub4_2_3.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/sub4_3_1.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/sub5_6.css\" />" +
"<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/coordinate.css\" />" +
"<!--[if lte IE 8]><link rel=\"stylesheet\" type=\"text/css\" href=\"/css/wellness/ie.css\"/><![endif]-->" +
/*
"<script src=\"/js/jquery-1.9.1.min.js\"></script>" +
"<script src=\"/js/jquery.superLabels.min.js\"></script>" +
"<script src=\"/js/jquery-ui-1.9.2.custom.min.js\"></script>" +
"<script src=\"/js/jquery-migrate-1.2.1.min.js\"></script>" +
"<script src=\"/jqplot/jquery.jqplot.min.js\"></script>" +
"<script src=\"/jqplot/plugins/jqplot.pieRenderer.min.js\"></script>" +
"<!--[if lt IE 9]><script src=\"/js/html5shiv.js\"></script>" +
"<script src=\"/jqplot/excanvas.min.js\"></script><![endif]-->" +
"<script src=\"/me/mediaelement-and-player.min.js\"></script>" +
"<script src=\"/js/webnote.js\"></script>" +

"<script src=\"/js/artn.js\"></script>" +
"<script src=\"/js/artn.const.js\"></script>" +
"<script src=\"/js/artn.lib.js\"></script>" +
"<script src=\"/js/artn.thumblist.js\"></script>" +       
"<script src=\"/js/artn.player.base.js\"></script>" +
"<script src=\"/js/artn.player.video.js\"></script>" +
"<script src=\"/js/artn.player.narrator.js\"></script>" +
"<script src=\"/js/artn.player.movie.js\"></script>" +
"<script src=\"/js/artn.player.subtitlectrl.js\"></script>" +
"<script src=\"/js/artn.player.trackctrl.js\"></script>" +
"<script src=\"/js/artn.player.trackctrl.365plus.js\"></script>" +
"<script src=\"/js/artn.player.mediactrl.js\"></script>" +
"<script src=\"/js/artn.player.contentmgr.js\"></script>" +
"<script src=\"/js/artn.player.me.js\"></script>" +
"<script src=\"/js/artn.validation.js\"></script>" +

"<script src=\"/js/artn.execute.js\"></script>"*/
"");
    /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
    mywindow.document.write("</head><body>");
    mywindow.document.write("<div><div class=\"section contents\"><div class=\"prescript show\">");
    mywindow.document.write( jqElem.html() );
    mywindow.document.write("</div></div></div>");
    mywindow.document.write("<button id=\"button_print\" style=\"position: absolute; top: 1em; right: 1em;\">인쇄하기</button>");
    mywindow.document.write("</body></html>");

    //mywindow.document.close();
    //mywindow.focus();
    
    mywindow.document.close();
    mywindow.print();
//        $(mywindow.document).find("#button_print").click(function(){
//        	
//        	mywindow.print();
//        });
    
//        if (Artn.Environment.isIE() === true){
//        	mywindow.print();
//        }
//        else{
//        	mywindow.print();
//        }
        
        
        //mywindow.close();

    return true;
}
/// 처방전 프린팅 기능 - 2013.12.12 by jhson [종료]
/// medifit iframe 크기 조정 - 2014.03.18 yyj 나중에 수정좀.....
var exerciseHeight; 
window.onload = function(){
	iframeHeight(0,"etc");
	exerciseHeight = autoHeight();
}
var height;
var bodyHeight;
var pUrl;
function iframeHeight(hei, opt){
    var iframe = document.getElementById( 'inneriframe' );
	if(Artn.Environment.isIE() == true || Artn.Environment.isIE11() == true){
		bodyHeight = Math.max( document.body.offsetHeight, document.body.scrollHeight )+50;
	}else{
		bodyHeight = Math.max( document.body.offsetHeight, document.body.scrollHeight );
	}
	if(opt == "open"){
	    height = bodyHeight+exerciseHeight;
	}else if(opt == "close"){
		height = height-exerciseHeight;
	}else{
		height = bodyHeight;
	}
	pUrl = document.referrer;
//	SERVER
//	if(pUrl.indexOf("www") > 0){
//		iframe.src = 'http://www.komfa.kr/auto_size.jsp?height='+height;
//	}else{
//		iframe.src = 'http://komfa.kr/auto_size.jsp?height='+height;
//	}
//	LOCAL
	if(pUrl.indexOf("www") > 0){
		iframe.src = 'http://106.245.5.239:18082/auto_size.jsp?height='+height;
	}else{
		iframe.src = 'http://106.245.5.239:18082/auto_size.jsp?height='+height;
	}
		  
}
var medi_qustion;
var medi_check;
var physics;
var diagnosis;
var exercise;
var comb;
var management;
function autoHeight(){
	var height = $(".medi-qustion").innerHeight()+$(".medi-check").innerHeight()+$(".physics").innerHeight()+
			+ $(".diagnosis").innerHeight() + $(".exercise").innerHeight() +  $(".comb").innerHeight() +  $(".management").innerHeight();
	medi_qustion = $(".medi-qustion").innerHeight();
	medi_check = $(".medi-check").innerHeight();
	physics = $(".physics").innerHeight();
	diagnosis = $(".diagnosis").innerHeight();
	exercise = $(".exercise").innerHeight();
	comb = $(".comb").innerHeight();
	management = $(".management").innerHeight();
	return height;
}
function oneHeight(cla, opt){
	var iframe = document.getElementById( 'inneriframe' );
	if(opt == "open"){
		if(cla.search("medi-qustion") != -1){
			height = height+medi_qustion;
		}else if(cla.search("medi-check") != -1){
			height = height+medi_check;
		}else if(cla.search("physics") != -1){
			height = height+physics;
		}else if(cla.search("diagnosis") != -1){
			height = height+diagnosis;
		}else if(cla.search("exercise") != -1){
			height = height+exercise;
		}else if(cla.search("comb") != -1){
			height = height+comb;
		}else if(cla.search("management") != -1){
			height = height+management;
		}
	}else{
		if(cla.search("medi-qustion") != -1){
			height = height-medi_qustion;
		}else if(cla.search("medi-check") != -1){
			height = height-medi_check;
		}else if(cla.search("physics") != -1){
			height = height-physics;
		}else if(cla.search("diagnosis") != -1){
			height = height-diagnosis;
		}else if(cla.search("exercise") != -1){
			height = height-exercise;
		}else if(cla.search("comb") != -1){
			height = height-comb;
		}else if(cla.search("management") != -1){
			height = height-management;
		}
	}
//	SERVER
//	if(pUrl.indexOf("www") == 0){
//		iframe.src = 'http://www.komfa.kr/auto_size.jsp?height='+height;
//	}else{
//		iframe.src = 'http://komfa.kr/auto_size.jsp?height='+height;
//	}
//	LOCAL
	if(pUrl.indexOf("www") == 0){
		iframe.src = 'http://106.245.5.239:18082/auto_size.jsp?height='+height;
	}else{
		iframe.src = 'http://106.245.5.239:18082/auto_size.jsp?height='+height;
	}
}
/// medifit iframe 크기 조정 - 2014.03.18 yyj 종료