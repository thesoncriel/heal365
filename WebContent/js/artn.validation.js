/**
 * Arotechno Framework
 * (Validation Check)
 * @author jhson
 * @since 2013.06.05
 * @version 1.0 
 */


/**
* 폼엘리먼트의 value 가 변화되면 keyup 이벤트 발생시키기
*
* @author hooriza at nhncorp.com
* @version 0.1
*
* @created Nov.8.2007.
*/
var Observe=function(e){this._o=e,this._value=e.value,this._bindEvents()};Observe.prototype._bindEvents=function(){var e=this,t=function(e,t,n){e.attachEvent?e.attachEvent("on"+t,n):e.addEventListener(t,n,!1)};t(this._o,"focus",function(){e._timer&&clearInterval(e._timer),e._timer=setInterval(function(){e._value!=e._o.value&&(e._value=e._o.value,e._fireEvent())},50)}),t(this._o,"blur",function(){e._timer&&clearInterval(e._timer),e._timer=null})},Observe.prototype._fireEvent=function(){if(document.createEvent){var e;window.KeyEvent?(e=document.createEvent("KeyEvents"),e.initKeyEvent("keyup",!0,!0,window,!1,!1,!1,!1,65,0)):(e=document.createEvent("UIEvents"),e.initUIEvent("keyup",!0,!0,window,1),e.keyCode=65),this._o.dispatchEvent(e)}else{var e=document.createEventObject();e.keyCode=65,this._o.fireEvent("onkeyup",e)}};
var Artn = Artn || {};

/**
 * 유효성 검사를 등록하고 관리한다.
 * @class
 */
Artn.Validation = {
	/**
	 * 객체 내에서 공통적으로 쓰이는 정규식 객체가 등록 되어 있다.
	 * <ul>
	 * <li>kor : 한국어 및 숫자</li>
	 * <li>eng : 영문 및 숫자</li>
	 * <li>id : 영문소문자, 숫자, 특수문자(-,_,.)</li>
	 * <li>num : 숫자</li>
	 * <li>dec : 10진수 양수, 음수 및 소수</li>
	 * </ul>
	 */
	_regex : {
		kor : {
			test : /^[ㄱ-ㅎㅃㅉㄸㄲ가-힣0-9\s]{0,}$/,
			match : /[ㄱ-ㅎㅃㅉㄸㄲ가-힣0-9\s]{0,}/
		},
		eng : {
			test : /^[A-z0-9\s\.]{0,}$/,
			match : /[A-z0-9\s\.]{0,}/
		},
		"id" : {
			test : /^[a-z0-9]{0,}[\-\_\.]{0,1}[a-z0-9]{0,}$/,
			match : /[a-z0-9]{0,}[\-\_\.]{0,1}[a-z0-9]{0,}/
		},
		num : {
			test : /^[0-9]{0,}$/,
			match : /[0-9]{0,}/
		},
		dec : {
			test : /^[-]?[0-9]{0,}[\.]{0,1}[0-9]{0,}$/,
			match : /^[-]?[0-9]{1,}[\.]{0,1}[0-9]{0,}/
		}
	},
	/**
	 * 객체 내에서 공통적으로 쓰이는 유효성 오류 메시지가 등록 되어 있다.
	 */
	_message : {
		showed : 0,
		required : "필수 입니다.",
		required_group : "좌측의 모든 입력란은 필수 입니다.",
		password : "비밀번호가 일치하지 않습니다.",
		kor : "한글만 가능합니다. 한/영 전환 상태를 확인하세요.",
		eng : "영문과 숫자, 공백만 가능합니다.",
		"id" : "영문 소문자와 숫자와 특수기호 1개만 쓸 수 있으며, 특수기호는 바(-), 언더바(_), 마침표(.)만 가능합니다.",
		num : "숫자만 가능합니다.",
		dec : "숫자 혹은 실수만 가능합니다.",
		emailTitle1 : "이메일 주소의 앞부분을 적어주세요.",
		emailTitle2 : "이메일 주소의 뒷부분을 적어주세요.",
		emailTitle3 : "이메일 주소의 뒷부분을 선택하세요.",
		phoneTitle1 : "전화번호의 앞부분을 적어주세요.",
		phoneTitle2 : "전화번호의 뒷부분을 적어주세요.",
		minlen : TrimPath.parseTemplate( "최소 ${minlen}자 이상 작성 하여야 합니다." ),
		userId : "사용 가능한 ID 입니다.",
		userIdNot : "이미 존재하는 ID 입니다.",
		userIdAlert : "사용 가능 여부를 다시 확인하십시요.",
		mixEngNum : "숫자와 영문을 반드시 조합하여 주십시요."
	},
	/**
	 * ID 및 비밀번호를 넣는 곳에서 title 값이 설정되어 있지 않을 때 쓰이는 메시지가 등록 되어 있다.
	 */
	_title : {
		"id" : "ID를 입력 하세요.",
		password : "비밀번호를 입력 하세요."
	},
	/**
	 * ajax 통신 시 현재 사용되어지는 input 객체를 임시로 등록하는 곳.
	 */
	_ajaxCurr : null,
	
	/**
	 * 유효성 검사기를 등록 한다.<br/>
	 * 생성 시 다음과 같은 조건의 선택자로 등록 한다.<br/>
	 * <strong>form.validator</strong>
	 */
	create : function(){
		$("*[id^='datepicker_']").attr("readonly", "readonly").datepicker({
			dateFormat: "yy-mm-dd"
		}).each(function(index){
			var year = $(this).data("year");
			var maxYear = $(this).data("max-year");
			
			if (maxYear){
				maxYear = new Date().getFullYear() + maxYear;
			}
			else{
				maxYear = new Date().getFullYear();
			}
			
			if (year){
				$(this).datepicker("option", {
					changeYear: true,
					changeMonth: true,
					yearRange: year + ":" + maxYear
				});
			}
		});

	    $("form.break-enter").bind("keypress", function(event){
	    	return ( event.keyCode !== 13 );
	    });
		
		$("form.validator").find("input[type!='hidden'][type!='submit'], select, textarea, .valid-group").each(function(index){
			var jqInput = $(this);
			var sRule = $(this).data("rule");

			if (sRule){
				try{
					Artn.Validation["regist_" + sRule ]( jqInput );
				}
				catch(e){
					try{console.log(e.toString() + ":" + sRule);}
					catch(e){}
				}
			}
			else if ( this.type === "button" ){
				return;
			}
			else if ( this.type === "password" ){
				Artn.Validation.regist_password( jqInput );
			}
			else if ( (this.type === "checkbox") || (this.type === "radio") ){
				
			}
			else if ( this.tagName === "INPUT"){
				jqInput.focusout(function(e){
					Artn.Validation.showMessage( $(this), "" );
				});
			}
			else if ( this.tagName === "SELECT" ){
				Artn.Validation.regist_select( this );
			}
			
			//Artn.Validation.registTooltip( jqInput );
		});

		$("*[data-rule='comboChain']").each(function(index){
			var jqSelect = $(this).find("select");
			jqSelect.change({to: jqSelect.parent().data("to"), url: jqSelect.parent().data("url"), keys: jqSelect.parent().data("keys")}, function(e){
				var sTo = e.data.to;
				var sUrl = e.data.url;
				var sKeys = e.data.keys;
				var jqSelect = $(this);
				var sName = jqSelect.attr("name");
				var mParams = {};
				mParams[ sName ] = jqSelect.val();
				mParams[ "keys" ] = sKeys;
				Artn.Ajax.data = e.data;
				$.extend(Artn.Ajax.data, {
					jqFrom: jqSelect,
					jqTo: $(sTo)
				});
				$.getJSON(sUrl, mParams, function(data){
					var saKeys = Artn.Ajax.data.keys.split(",");
					var template = TrimPath.parseTemplate( "<option value=\"${" + saKeys[0] + "}\">${" + saKeys[1] + "}</option>" );
					var iLen = data.length;
					Artn.Ajax.data.jqTo.empty();
					for(var i = 0; i < iLen; i++){
						Artn.Ajax.data.jqTo.append( template.process( data[i] ) );
					}
				});
			});
		});
		
		$("textarea[maxlength]").each(function(index){
			Artn.Validation.regist_textarea( $(this) );
		});
		
		$("form.validator").find("input[data-mixEngNum='true']").focusout(function(e){
			Artn.Validation.checkMixEngNum( $(this) );
		});
		
		//좌표 찾기 기능의 변경으로 새로 추가 함 - 2013.09.01 by shkang
	    //좌표 찾기 - execute 에서 뽑아 옴 - 2013.09.24 by jhson
	    $("input[name='map_button']").click(function(){
	        window.open( Artn.Const.MAP_COORD, "_blank", "width=600, height=500" );
	    });

		$("form.validator").submit( this.onsubmit );
		
		this.registBreakEnter();
	},
	/**
	 * 유효성 검사기가 적용된 Form Element를 대상으로 유효성 체크를 수행한다.
	 * @param {Integer} [index=0] jqElem 요소 중 검사를 할 개체에 대한 index 번호.
	 * @param {jQuery} [jqElem=$("form.validator")] 검사 할 Form 요소.
	 */
	check : function(index, jqElem){
		//var elemForm = ( (e.data) && (e.data.form !== undefined) )? e.data.form : this;
		var jqForm = (jqElem || $("form.validator").eq( index || 0 ));
		var bOK = this.checkRequired( jqForm );
		

		bOK = this.checkMinLength( jqForm ) && bOK;
		bOK = this.checkMixEngNum( jqForm ) && bOK;
		
		jqForm.find("textarea[maxlength]").each(function(index){
			var jqText = $(this);
			var iMaxLen = parseInt( jqText.attr("maxlength") );
			var isOverLen = parseInt( $("#__" + jqText.attr("name") + "_counter_hdn").val() ) > iMaxLen;

			bOK = bOK && (isOverLen === false);
		});
		
		this.checkHeightRemove( jqForm );

		return bOK;
	},
	/**
	 * 사용자가 Form 요소를 통하여 보내기(submit)전에 수행되는 이벤트 메서드.
	 */
	onsubmit : function(e){
		return Artn.Validation.check(0, $(this));
	},
	/**
	 * 입력 내용에 대하여 미리 정의 된 키워드를 이용하여 유효성을 검사 한다.
	 * 사용가능한 키워드는 다음과 같다.
	 * <ul>
	 * <li>kor : 한국어 및 숫자</li>
	 * <li>eng : 영문 및 숫자</li>
	 * <li>id : 영문소문자, 숫자, 특수문자(-,_,.)</li>
	 * <li>num : 숫자</li>
	 * <li>dec : 10진수 양수, 음수 및 소수</li>
	 * </ul>
	 * @param {String} strKey 유효성 검사 키워드. 
	 * @param {jQuery} jqInput 유효성 값을 검사 할 요소.
	 * @return {Boolean} 유효성 통과시 true. 아니면 false.
	 */
	checkValidByKey : function(strKey, jqInput){
		if (this._regex[ strKey ].test.test( jqInput.val() ) === false){
			var saMatchRet = jqInput.val().match( this._regex[ strKey ].match );
			var iLen = (saMatchRet)? saMatchRet.length : 0;
			var sValue = "";
			
			for(var i = 0; i < iLen; i++){
				sValue += saMatchRet[ i ];
			}
			jqInput.val( sValue );
			
			//this.showTooltip( jqInput, this._message[ strKey ] );
			this._message.showed = 2;
			return false;
		}
		else if (this._message.showed > 0){
			this._message.showed--;
			return true;
		}
		//this.showTooltip( jqInput, "" );
		this.showMessage( jqInput, "" );
		return true;
	},
	
	/**
	 * 한국어에 대한 유효성을 검사 한다. 통과 시 true. 아니면 false.
	 * @param {jQuery} jqInput 검사 할 요소.
	 * @return {Boolean}
	 */
	isKor : function(jqInput){ return this.checkValidByKey("kor", jqInput); },
	
	/**
	 * 영문에 대한 유효성을 검사 한다. 통과 시 true. 아니면 false.
	 * @param {jQuery} jqInput 검사 할 요소.
	 * @return {Boolean}
	 */
	isEng : function(jqInput){ return this.checkValidByKey("eng", jqInput); },
	
	/**
	 * 영문소문자와 숫자, 특수문자(-, _, .)에 대한 유효성을 검사 한다. 통과 시 true. 아니면 false.
	 * @param {jQuery} jqInput 검사 할 요소.
	 * @return {Boolean}
	 */
	isId  : function(jqInput){ return this.checkValidByKey("id",  jqInput); },
	
	/**
	 * 숫자에 대한 유효성을 검사 한다. 통과 시 true. 아니면 false.
	 * @param {jQuery} jqInput 검사 할 요소.
	 * @return {Boolean}
	 */
	isNum : function(jqInput){ return this.checkValidByKey("num", jqInput); },
	
	/**
	 * 10진수에 대한 유효성을 검사 한다. 통과 시 true. 아니면 false.
	 * @param {jQuery} jqInput 검사 할 요소.
	 * @return {Boolean}
	 */
	isDec : function(jqInput){ return this.checkValidByKey("dec", jqInput); },

	/**
	 * 해당 요소 우측에 메시지를 출력 한다.
	 * @param {jQuery} jqElem 메시지를 출력 하고자 하는 요소
	 * @param {String} strMsg 출력 할 메시지.
	 */
	showMessage : function(jqElem, strMsg){
		var jqValidMsg = null;
		
		if (jqElem.parent().hasClass("valid-group") === true){
			jqElem = jqElem.parent();
		}
		
		jqValidMsg = jqElem.nextAll(".valid-msg");
		
		if ( jqValidMsg.length === 0 ){
			jqValidMsg = jqElem.after("<span class=\"valid-msg\">" + strMsg + "</span>");
		}
		else{
			jqValidMsg.html( strMsg );
		}
	},
	
	/**
	 * 해당 요소 상단에 툴팁을 띄운다.
	 * @param {jQuery} jqElem 툴팁을 출력 하고자 하는 요소
	 * @param {String} strMsg 출력 할 메시지.
	 * @deprecated 툴팁 사용 시 UI가 가려져 불편함이 있기에 사용하지 않을 것을 권고 함.
	 */
	showTooltip : function(jqElem, strMsg){
		if (Artn.Environment.isMobile() === false){
			return;
		}
		if ( (strMsg !== "")){
			jqElem.tooltip("option", "content", strMsg);
			jqElem.tooltip("open");
		}
		else{
			jqElem.tooltip("option", "content", jqElem.data("title") );
		}
	},
	
	/**
	 * 인수로 넣은 요소의 이름을 이용하여 히든 필드를 생성, 체크 표시를 한다.<br/>
	 * 주로 자동완성등으로 선택된 내용에 대하여 체크 하고 싶을 때 쓰인다.
	 * @param {jQuery} jqElem 만들 대상이 될 개체.
	 */
	createHiddenChecked : function(jqElem){
		$( Artn.Util.createHidden( "__" + jqElem.attr("name") + "_checked", "true" ) ).insertBefore( jqElem );
	},
	
	/**
	 * 체크 표시 된 히든 필드를 제거 한다.<br/>
	 * 주로 자동완성등으로 선택된 내용에 대하여 체크 하고 싶을 때 쓰인다.
	 * @param {jQuery} jqElem 제거 대상이 될 개체.
	 */
	removeHiddenChecked : function(jqElem){
		jqElem.siblings("input[name='__" + jqElem.attr("name") + "_checked']").remove();
	},
	
	/**
	 * 해당 개체가 히든 체크표식이 되어있는지를 확인한다. 맞다면 true. 아니면 false
	 * @param {jQuery} jqElem 체크표식을 확인할 개체.
	 * @return {Boolean}
	 */
	isHiddenChecked : function(jqElem){
		return jqElem.siblings("input[name='__" + jqElem.attr("name") + "_checked']").length > 0;
	},
	
	/**
	 * 해당 개체에 툴팁 기능을 등록 한다.
	 * @param {jQuery} jqInput 툴팁 기능을 등록 할 개체
	 * @deprecated 본 기능 발현 시 UI를 가리게되어 사용자에게 불편하므로 사용치 않기를 권고함.
	 */
	registTooltip : function( jqInput ){
		jqInput.data("title", jqInput.get(0).title);
		jqInput.tooltip({
			position: {
				my: "right-20 middle",
				at: "left middle"
				/*my: "center bottom-10",
				at: "center top"*/
			},
			close : function(event, ui){
				
			}
		});
		jqInput.blur(function(e){
			$(this).tooltip("close");
		});
	},
	
	/**
	 * Form에 입력 후 Enter 키를 눌렀을 때 자동으로 submit이 수행되는 것을 방지하는 이벤트를 등록한다.
	 */
	registBreakEnter : function(){
		$("form.break-enter").bind("keypress", function(event){
	    	return ( event.keyCode !== 13 );
	    });
	},
	
	/**
	 * @ignore
	 * 사용하지 않음.
	 */
	checkPassword : function(){
		var iMinLen = 6;
		$("input[type='password']").each(function(index){
			iMinLen = parseInt( $(this).data("minlen") || iMinLen );
			
		});
	},
	
	/**
	 * Form 요소에 대한 필수 여부를 체크 한다.<br/>
	 * 필수여부를 모두 통과했다면 true, 하나라도 불통과면 false.
	 * @param {Element|jQuery|String} elemForm 검사 할 Form 요소.
	 * @return {Boolean}
	 */
	checkRequired : function(elemForm){
		var jqForm = $(elemForm);
		var bOK = true;
		var mbRadio = {};

		jqForm.find("*[required='required']").each(function(index){
			var jqInput = $(this);
			
			if ( jqInput.val() === "" ){
				Artn.Validation.showMessage( jqInput, Artn.Validation._message.required );
				bOK = false;
			}
		});
		
		jqForm.find("input[data-rule='id']").each(function(index){
			var jqInput = $(this);
			
			if ( jqInput.val() === "" ){
				Artn.Validation.showMessage( jqInput, Artn.Validation._message.required );
				bOK = false;
			}
			
			if ( bOK && ( jqInput.data("url") !== undefined ) ){
				if ( Artn.Validation.isHiddenChecked( jqInput ) === false ){
					Artn.Validation.showMessage( jqInput, Artn.Validation._message.userIdAlert );
					bOK = false;
				}
			}
		});
		
		jqForm.find("input[type='password']").each(function(index){
			var jqPw = $(this);
			var jqPwRe = jqForm.find("input[name='" + jqPw.attr("name") + "re']");
			var jqPwOld = jqForm.find("input[name='" + jqPw.attr("name") + "old']");
			
			if ((jqPwOld.length === 0) ||
				((jqPwOld.length === 1) && (jqPwOld.val() !== ""))
				){
				if (jqPwRe.length === 1){
					if (jqPw.val() !== jqPwRe.val()){
						Artn.Validation.showMessage( jqPwRe, Artn.Validation._message.password );
						bOK = false;
					}
				}
			}
			
		});
		
		jqForm.find("*[data-required='required']").each(function(index){
			var jqValidGroup = $(this);
			var sRule = jqValidGroup.data("rule");
			var bOKGroup = false;
			
			if ((sRule === "email") || (sRule === "phone")) {
				bOKGroup = Artn.Validation.checkTextboxGroup( jqValidGroup );
				
				if (bOKGroup === false){
					Artn.Validation.showMessage( jqValidGroup, Artn.Validation._message.required_group );
					bOK = false;
				}
			}
			else if (sRule === "survey"){
				var jqChildLast = jqValidGroup.children().not(".valid-msg").last();
				
				if (jqValidGroup.find("input[type='radio']:checked").length === 0){
					Artn.Validation.showMessage( jqChildLast, Artn.Validation._message.required );
					bOK = false;
				}
				else{
					Artn.Validation.showMessage( jqChildLast, "" );
				}
			}
		});
		
		jqForm.find("input[type='checkbox'][required='required']").each(function(index){
			var jqInput = $(this);

			if (jqInput.get(0).checked === false){
				//alert( " " + Artn.Validation._message.required );
				Artn.Validation.showMessage( $("label[for='" + jqInput.attr("id") + "']"), Artn.Validation._message.required );
				//Artn.Validation.showTooltip( jqInput, Artn.Validation._message.required );
				bOK = false;
			}
			else{
				Artn.Validation.showMessage( $("label[for='" + jqInput.attr("id") + "']"), "" );
			}
		});
		
		// TODO: 라디오 버튼에 대한 필수 체크 기능 작성 할 것 - 2013.07.29 by jhson
//		jqForm.find("input[type='radio'][required='required']").each(function(index){
//			var sName = $(this).attr("name");
//			
//			if ( mbRadio[sName] === undefined ){
//				mbRadio[sName] = true;
//			}
//		});
		
		jqForm.find("select[data-required]").each(function(index){
			if ( this.selectedIndex === 0 ){
				Artn.Validation.showMessage( $(this), Artn.Validation._message.required );
				bOK = false;
			}
		});
		
		return bOK;
	},
	
	/**
	 * 다수의 입력 박스(input, select 등)가 특정 요소로 그룹지어져 있을 때 이 들에 대하여 값의 길이를 확인한다.<br/>
	 * 주로 전화 번호의 길이 값을 확인할 때 쓰이며 각각 값의 길이는 3 이상이어야 한다.<br/>
	 * 모두 통과시엔 true, 아니면 false.
	 * @param {jQuery} jqValidGroup input Element를 여럿 감싸고 있는 부모 요소.
	 * @return {Boolean}
	 */
	checkTextboxGroup : function( jqValidGroup ){
		var jqTextList = jqValidGroup.find("input[type='text']");
		var bOK = true;
		var iLen = jqTextList.length;
		
		for(var i = 0; i < iLen; i++){
			if (jqTextList.eq( i ).val().length < 3 ){
				return false;
			}
		}
		
		return bOK;
	},
	
	/**
	 * 검사 할 Form Element 내의 data-minlen 속성이 설정된 압룍 요소들을 찾아 그들의 값이 설정된 최소 길이에 부합되는지를 검사 한다.<br/>
	 * 조건이 모두 맞으면 true, 아니면 false.
	 * @param {Element|jQuery|String} elemForm 최소 길이를 검사할 요소가 포함된 Form Element.
	 * @return {Boolean}
	 */
	checkMinLength : function( elemForm ){
		var jqForm = $( elemForm );
		var bOK = true;

		jqForm.find("input[data-minlen]").each(function(index){
			bOK = bOK && Artn.Validation.checkMinLengthSingle( $(this) );
		});
		
		return bOK;
	},
	
	/**
	 * 특정 요소의 값에 대한 최소 길이를 확인한다.<br/>
	 * 검사 할 요소에는 data-minlen 속성과 값이 존재 해야하며, 조건이 맞을 경우 true, 아니면 false 이다.
	 * @param {jQuery} jqInput 검사 할 input 요소.
	 * @return {Boolean}
	 */
	checkMinLengthSingle : function( jqInput ){
		var iMinLen = parseInt( jqInput.data("minlen") );
		var iLen = jqInput.val().length;
		
		if ((iLen > 0) && (iLen < iMinLen)){
			Artn.Validation.showMessage( jqInput, Artn.Validation._message.minlen.process( {"minlen": iMinLen} ) );
			return false;
		}

		return true;
	},
	
	/**
	 * 특정 요소의 값에 대하여 영문자와 숫자가 혼합되었는지의 여부를 확인한다.<br/>
	 * 혼합이 되었다면 true, 아니면 false.
	 * @param {jQuery} jqElem 검사 할 요소.
	 * @return {Boolean}
	 */
	checkMixEngNum : function( jqElem ){
		var jqInput = $(jqElem);
		
		if (jqInput.prop("tagName").toLowerCase() === "form"){
			var bOK = true;
			
			if (jqInput.prop("tagName").toLowerCase() === "form"){
				jqInput.find("input[data-mixEngNum='true']").each(function(index){
					bOK = Artn.Validation.checkMixEngNum( $(this) ) && bOK;
				});
			}
			
			return bOK;
		}
		else{
			try{
				var regexAlphabet = new RegExp( "[A-z]", "i" );
				var regexNumeric = new RegExp( "\\d" );
				
				if (regexAlphabet.test( jqInput.val() ) && 
					regexNumeric.test( jqInput.val() )){
					Artn.Validation.showMessage( jqInput, "");
					return true;
				}
				else{
					alert( $("label[for='" + jqInput.attr("id") + "']").text() + " 항목(은)는 " + Artn.Validation._message.mixEngNum );
					//Artn.Validation.showMessage( jqInput, Artn.Validation._message.mixEngNum);
					return false;
				}
			}
			catch(e){
				try{console.log(e);}
				catch(e){}
			}
		}
	},
	
	/**
	 * 
	 * @deprecated 사용되지 않음.
	 */
	checkHeightRemove : function( elemForm ){
//		var jqForm = $( elemForm );
//		
//		jqForm.find("textarea[data-height-remove]").each(function(index){
//			var jqTextarea = $( this );
//			var sText = jqTextarea.html();
//			
//			sText = sText.replace( /height=('|\")?[0-9]*('|\")?"/, "" );
//			jqTextarea.get(0).innerHTML = sText;
//		});
	},
	
	/**
	 * @ignore 사용되지 않음.
	 */
	checkCheckbox : function( elemCheckbox ){
		
	},
	
	/**
	 * @ignore 사용되지 않음.
	 */
	registKeyInput : function( jqInput, strArrKeys ){
		new Observe(jqInput.get(0));
		jqInput.keyup({keys: strArrKeys}, function(e){
			Artn.Validation.showMessage( $(this), this.value );
		});
	},
	
	/**
	 * 키 입력 이벤트를 등록 한다.<br/>
	 * 등록된 입력란은 사용자 입력에 실시간으로 유효성을 검사 하고 메시지를 출력 한다.
	 * @param {jQuery} jqInput 유효성 검사를 할 개체
	 * @param {String[]} 
	 */
	registMultiLangKeyupEvent : function( jqInput ){
		var iLen = jqInput.length;
		
		if (iLen > 0){
			for (var i = 0; i < iLen; i++ ){
				new Observe( jqInput.get(i) );
			}
		}
	},
	// FIXME: Ajax로 JSON 데이터를 Single로 받아올 시 ID 중복 체크가 안됨 - 2013.07.30 by jhson
	/**
	 * input 요소에 ID 작성 규칙에 대한 유효성 검사 기능을 등록 한다.<br/>
	 * 사용되는 data-* 속성은 다음과 같다.
	 * <table>
<thead style="background-color: #f80;">
<tr>
<td>attr.</td>
<td>type</td>
<td>desc.</td>
</tr>
</thead>
<tbody>
<tr>
<td>data-url</td>
<td>URL</td>
<td>
속성값이 설정되어 있다면 해당 URL에서 Ajax-JSON 통신을 하여 사용자가 작성하려는 ID가 서버내 저장된 ID와 중복되는지의 여부를 확인하여 메시지를 출력 해 준다.<br/>
중복 ID 확인 시 사용되는 key는 본 유효성 기능이 적용된 input 요소의 name 속성 값이 기준이 된다.<br/>
※ 검사 기준 시기는 focusout 이다.
</td>
</tr>
</tbody>
</table>
	 * @param {jQuery} jqInput 유효성 검사 기능을 등록하고 싶은 input 개체.
	 */
	regist_id : function( jqInput ){
		var sUrl = jqInput.data("url");
		var sTitle = jqInput.attr("title");
		
		if ( (sTitle === undefined) || (sTitle === "") ){
			jqInput.attr("title", this._title.id);
		}
		
		jqInput.keyup(function(e){
			//return Artn.Validation.isId( $(this) );
			$(this).val( $(this).val().toLowerCase() );
		});
		
		if ( (sUrl !== undefined) && (sUrl !== "") ){
			jqInput.focusout(function(e){
				var jqInput = $(this);
				
				Artn.Validation.removeHiddenChecked( jqInput );
				
				if ( Artn.Validation.checkMinLengthSingle( jqInput ) === false ) return;
				if ( jqInput.val().length === 0 ) return;
				
				
				jqInput.after( Artn.Const.AJAX_LOADING );
				Artn.Validation._ajaxCurr = jqInput;
				
				$.getJSON( jqInput.data("url"), {"id": jqInput.val()}, function(data){
					var jqInput = Artn.Validation._ajaxCurr;
					var sMsg = "";
					
					jqInput.next( Artn.Const.AJAX_LOADING_SMALL_CLASS ).remove();
					//console.log( data.length );
					
					if ( data.length !== undefined ){
						if ( data.length === 0 ){
							sMsg = Artn.Validation._message.userId;
							Artn.Validation.createHiddenChecked( jqInput );
						}
						else {
							sMsg = Artn.Validation._message.userIdNot;
						}
					}
					else{
						if ( data[ jqInput.attr( "name" ) ] === undefined ){
							sMsg = Artn.Validation._message.userId;
							Artn.Validation.createHiddenChecked( jqInput );
						}
						else {
							sMsg = Artn.Validation._message.userIdNot;
						}
					}
					
					Artn.Validation.showMessage( jqInput, sMsg );
				});
			});
		}
		
		//this.registMultiLangKeyupEvent( jqInput );
	},
	
	/**
	 * input 요소에 한국어 작성 규칙에 대한 유효성 검사 기능을 등록 한다.
	 * @param {jQuery} jqInput 유효성 기능을 추가 할 요소.
	 */
	regist_kor : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isKor( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
	
	/**
	 * input 요소에 영문 작성 규칙에 대한 유효성 검사 기능을 등록 한다.
	 * @param {jQuery} jqInput 유효성 기능을 추가 할 요소.
	 */
	regist_eng : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isEng( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
//	regist_lowerCase : function( jqInput ){
//		jqInput.keyup(function(e){
//			$(this).val( $(this).val().toLowerCase() );
//		});
//	},
	
	/**
	 * input 요소에 숫자 작성 규칙에 대한 유효성 검사 기능을 등록 한다.
	 * @param {jQuery} jqInput 유효성 기능을 추가 할 요소.
	 */
	regist_num : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isNum( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
	
	/**
	 * input 요소에 10진수 작성 규칙에 대한 유효성 검사 기능을 등록 한다.
	 * @param {jQuery} jqInput 유효성 기능을 추가 할 요소.
	 */
	regist_dec : function( jqInput ){
		jqInput.keyup(function(e){
			return Artn.Validation.isDec( $(this) );
		});
		this.registMultiLangKeyupEvent( jqInput );
	},
	
	/**
	 * input 요소에 비밀번호 작성 규칙에 대한 유효성 검사 기능을 등록 한다.<br/>
	 * 만약 input이 속한 form 요소 내에 다른 input[type='password']가 존재하며 그 이름이 등록된 input의 name에 <b>re</b>가 붙었다면,
	 * 현재 패스워드 요소 대비하여 re 패스워드 요소를 비밀번호 확인(password confirm)하기 위한 것으로 간주하여 submit 시 두가지 패스워드 값이 동일한지를 자동으로 판단 하여
	 * 메시지로 알려 준다. 
	 * @param {jQuery} jqInput 유효성 기능을 추가 할 요소.
	 */
	regist_password : function( jqInput ){
		var jqFormParent = jqInput.parents("form");
		var jqPwRe = jqFormParent.find("input[name='" + jqInput.attr("name") + "re']");
		//var jqOtherPwInput = jqFormParent.find("input[id^='" + jqInput.get(0).id + "']");
		var sTitle = jqInput.attr("title");
		
		if ( (sTitle === undefined) || (sTitle === "") ){
			jqInput.attr("title", this._title.password);
		}
				
		if (jqPwRe.length === 1){
			jqInput.change({other: jqPwRe}, function(e){
				Artn.Validation.showMessage( $(this), "" );
				Artn.Validation.showMessage( e.data.other, "" );
			});
			jqPwRe.change({ori: jqInput}, function(e){
				var jqInput = e.data.ori;
				var jqThis = $(this);
				
				if ( jqThis.val() !== jqInput.val() ){
					Artn.Validation.showMessage( jqThis, Artn.Validation._message.password );
				}
				else if ( jqThis.val() !== "" ){
					Artn.Validation.showMessage( jqThis, "<span class=\"confirmed\">OK</span>" );
				}
				else{
					Artn.Validation.showMessage( jqThis, "" );
				}
			});
		}
		/*
		if (jqOtherPwInput.length === 2){
			jqOtherPwInput.eq(0).change({other: jqOtherPwInput.eq(1)}, function(e){
				Artn.Validation.showMessage( $(this), "" );
				Artn.Validation.showMessage( e.data.other, "" );
			});
			
			jqOtherPwInput.eq(1).change({ori: jqInput}, function(e){
				var jqInput = e.data.ori;
				if ( this.value !== jqInput.val() ){
					Artn.Validation.showMessage( $(this), Artn.Validation._message.password );
				}
				else if ( this.value !== "" ){
					Artn.Validation.showMessage( $(this), "<span class=\"confirmed\">OK</span>" );
				}
				else{
					Artn.Validation.showMessage( $(this), "" );
				}
			});
		}*/
	},
	
	/**
	 * 이메일에 대한 유효성 검사를 등록한다.<br/>
	 * 등록 시 해당 요소는 텍스트박스 2개와 선택박스 1개를 소유하고 있어야 한다.<br/>
	 * 선택박스에서 <i>직접작성</i>을 선택 시 두번째 텍스트박스가 활성화 되어 메일서버 주소를 직접 적을 수 있게 된다.
	 * @param {jQuery} jqWrap 유효성 검사를 등록 할 요소
	 */
	regist_email : function( jqWrap ){
		var jqSelect = jqWrap.find("select");
		var jqEmailText = jqWrap.find("input[type='text']");
		
		jqEmailText.get(0).title = this._message.emailTitle1;
		jqEmailText.get(1).title = this._message.emailTitle2;
		//jqSelect.get(0).title = this._message.emailTitle3; - 익스 때문에 삭제함 -_-
		
		this.regist_id( jqEmailText.eq(0) );
		this.regist_eng( jqEmailText.eq(1) );
		
		if (jqSelect.val() !== "직접작성"){
			jqEmailText.eq(1).attr("readonly", true);
		}
		
		jqSelect.change({emailText: jqEmailText.eq(1)}, function(e){
			
			var jqSelect = $(this);
			var jqEmailText = e.data.emailText;
			
			if (jqSelect.val() === "직접작성"){
				jqEmailText.attr("readonly", false);
				jqEmailText.focus();
				jqEmailText.get(0).select();
			}
			else{
				jqEmailText.attr("readonly", true);
				jqEmailText.val( jqSelect.val() );
			}
			
		});
	},
	
	/**
	 * 전화번호에 대한 유효성 검사기를 등록 한다.<br/>
	 * 등록할 요소내에는 선택박스 1개(전화 번호 앞자리 ex:010, 011), 텍스트박스 2개(중간/뒷부분 3~4자리 번호)가 필요하다.<br/>
	 * 각각의 텍스트 박스는 자동으로 사용자의 숫자입력을 확인 해 준다.
	 * @param {jQuery} jqWrap 유효성 검사를 등록 할 요소.
	 */
	regist_phone : function( jqWrap ){
		var jqPhoneText = jqWrap.find("input[type='text']");
		
		jqPhoneText.get(0).title = this._message.phoneTitle1;
		jqPhoneText.get(1).title = this._message.phoneTitle2;
		this.regist_num( jqPhoneText );
	},
	
	/**
	 * 선택박스에 대하여 유효성 검사기를 등록 한다.<br/>
	 * 선택박스 내 option 요소들 중 최상위 요소의 text가 <b>필수</b>이거나 data-required 가 정의되어 있다면 필수로 동작하며,
	 * 선택된 내용에 대한 index가 0이 아니어야 한다.<br/>
	 * @param {Element|jQuery|String} elemSelect 유효성 검사를 등록 할 요소.
	 */
	regist_select : function( elemSelect ){
		var jqSelect = $(elemSelect) ;
		
		if ( (jqSelect.find("option").eq(0).text().indexOf("필수") >= 0) || 
			(jqSelect.attr("data-required") !== undefined) ){
			jqSelect.attr("data-required", "required");
			
			jqSelect.change(function(){
				if (this.selectedIndex > 0){
					Artn.Validation.showMessage( $(this), "" );
				}
			});
		}
	},
	
	/**
	 * 글쓰기영역(TextArea)에 대한 유효성 검사기를 등록 한다.<br/>
	 * 등록될 textarea 요소는 maxlength 의 값을 이용하여 작성되는 최대 글자수를 확인하여 textarea 하단에 글자수 현황을 출력 해 준다.
	 * @param {jQuery} jqText 유효성 검사를 등록 할 요소.
	 */
	regist_textarea : function( jqText ){
		var sCounterId = "__" + jqText.attr("name") + "_counter";
		var iMaxLength = parseInt( jqText.attr("maxlength") );
		var iTextLen = this.getTextAreaLength( jqText );
		
		jqText.after("<br/><span class=\"text-counter\" id=\"" + sCounterId + "\">" + "글자수 제한: (" + iTextLen + " / " + iMaxLength + ")" + "</span><input type=\"hidden\" id=\"" + sCounterId + "_hdn\" value=\"" + iTextLen + "\">");
		jqText.keyup({counterId: sCounterId, maxlength: iMaxLength, jqCounderHdn: $("#" + sCounterId + "_hdn")}, function(e){
			var jqCounter = $( "#" + e.data.counterId );
			var iTextLen = Artn.Validation.getTextAreaLength( $(this) );
			var sText = "글자수 제한: (" + iTextLen + " / " + e.data.maxlength + ")";
			
			if (iTextLen > e.data.maxlength){
				jqCounter.addClass("alert");
				sText = sText + " - 허용 글자수 최대 한도를 초과 하였습니다.";
			}
			else{
				jqCounter.removeClass("alert");
			}
			
			e.data.jqCounderHdn.val( iTextLen );
			jqCounter.text( sText );
		});
	},
	
	/**
	 * textarea의 글자수를 확인한다.
	 * @param {jQuery} jqText textarea 요소
	 * @return {Integer} 
	 */
	getTextAreaLength : function( jqText ){
		var regex = /\n/gi;
		var sValue = jqText.val();
		var saMatch = sValue.match( regex );
		var iCrLfLen = (saMatch)? saMatch.length : 0;
		
		return sValue.length + (iCrLfLen * 4);
	},
	
	/**
	 * 우편번호 검색 기능을 등록 한다.<br/>
	 * 등록 시 해당 textbox를 클릭하면 우편번호 검색 다이얼로그가 팝업 된다.<br/>
	 * 등록되는 input 요소는 다음과 같은 data-* 속성을 필요로 한다.
	 * <table>
<thead style="background-color: #f80;">
<tr>
<td>attr.</td>
<td>type</td>
<td>desc.</td>
</tr>
</thead>
<tbody>
<tr>
<td>data-to</td>
<td>선택자 | <strong>'.address'</strong></td>
<td>우편번호 검색후 주소 내용을 넣을 곳에 대한 선택자. 지번 주소가 들어간다.</td>
</tr>
<tr>
<td>data-tonew</td>
<td>선택자 | <strong>'.address_new'</strong></td>
<td>우편번호 검색후 주소 내용을 넣을 곳에 대한 선택자. 새주소(도로명 주소)가 들어간다.</td>
</tr>
<tr>
<td>data-ajaxurl</td>
<td>URL | <strong>'/zipcode'</strong></td>
<td>우편번호 검색 후 XML로 결과 내용을 반환해 줄 수 있는 URL을 설정 한다.</td>
</tr>
</tbody>
</table>
	 * 
	 * @param {jQuery} jqInput 우편번호 검색기를 적용할 요소
	 */
	regist_zipcode : function( jqInput ){
		var LIST_ID = "__tbodyZipcode__";
		var DIALOG_ID = "__dialog_zipcode__";
		var FORM_ID = "__form_zipcode__";
		var PAGE_CTRL_ID = "__pageCtrlZipcode__";
		var PAGE_CTRL_COMMENT = "※ 결과물이 많을 시 좀 더 상세히 입력 해 주세요<br/>※ 검색 결과에서 찾을 수 없다면 아래의 주소로 가신 뒤 검색 하시고 직접 입력하시길 바랍니다.<br/>▶▶▶<a href=\"http://www.juso.go.kr/openIndexPage.do\" target=\"_blank\">도로명주소 안내시스템</a>";
		
		var sDataTo = jqInput.data("to") || ".address";
		var sDataToNew = jqInput.data("tonew") || ".address_new";
		var sDataAjaxUrl = jqInput.data("ajaxurl");
		var jqDialog = null;
		var jqAddress = $(sDataTo);
		var jqAddressNew = $(sDataToNew);
		
		var fnOpenDialog = function(e){
			e.data.dialogTarget.dialog("open");
			return false;
		};
		
		if (sDataAjaxUrl === undefined){
			//sDataAjaxUrl = "http://www.juso.go.kr/support/AddressMainSearch.do?searchType=location_newaddr";
			sDataAjaxUrl = Artn.Const.ZIPCODE;
		}
		
		$("<div id=\"" + DIALOG_ID + "\" title=\"우편번호 및 주소 검색기\">"+
				"<form id=\"" + FORM_ID + "\" action=\"" + sDataAjaxUrl + "\" class=\"artn-search\" data-type=\"list\" data-to=\"#" + LIST_ID + "\" data-buttons=\"#" + PAGE_CTRL_ID + "\">"+
				"<div><label for=\"__keyword__\">주소 검색</label><input type=\"text\" id=\"__keyword__\" name=\"keyword\" value=\"\" /><input type=\"submit\" class=\"artn-button board\" name=\"dong-search\" value=\"검색\"/></div>"+
				"<table class=\"board-list zipcode-search-result\"><thead><tr><th class=\"m-hdn\">번호</th><th style=\"width: 6em;\">우편번호</th><th>주소</th></tr></thead>"+
				"<tbody id=\"" + LIST_ID + "\" data-cross-domain=\"true\">"+
				"<!--<tr><td class=\"m-hdn\">{row_num}</td><td>{zipcode}</td><td><a href=\"#\" class=\"select close\">{address}</a>" +
				"<input type=\"hidden\" name=\"zipcode\" value=\"{zipcode}\"/>" +
				"<input type=\"hidden\" name=\"address\" value=\"{address}\"/>" +
				"<input type=\"hidden\" name=\"address_new\" value=\"{address_new}\"/>" +
				"</td></tr>-->"+
				"</tbody></table>"+
				"<div id=\"" + PAGE_CTRL_ID + "\"><div><button class=\"artn-button board prev\" type=\"button\">이전</button><button class=\"artn-button board next\" type=\"button\">다음</button></div><span class=\"comment\">" + PAGE_CTRL_COMMENT + "</span></div>" +
				"<div id=\"loading_" + DIALOG_ID + "\" class=\"artn-loading-overlay\"><span class=\"artn-loading-img\"></span></div>" +
				"</form></div>")
		.appendTo("body");
		
		jqDialog = $("#" + DIALOG_ID);
		
		jqDialog.dialog({
			width: 900,
			height: 600,
			autoOpen: false,
			show: {
                effect: "fade",
                duration: 500
            },
            hide: {
                effect: "fade",
                duration: 250
            }
		});
		
		Artn.AsyncSearch.create("#" + FORM_ID)
		.dataerror(function(e){
			//console.log(e.item.response);
			Artn.Ajax.AsyncSearch.data = Artn.Validation.parseZipcodeData(e.item.response);
		});
		Artn.List.create("#" + LIST_ID)
		.selectclick({zipcode: jqInput, address: jqAddress, addressNew: jqAddressNew}, function(e){
			e.data.zipcode.val( e.item.zipcode );
			e.data.address.val( e.item.address );
			e.data.addressNew.val( e.item.address_new );
			e.data.address.nextAll("input[type='text']").eq(0).focus();
		})
		.itemadd({dialogTarget: jqDialog}, function(e){
			$(e.currentTarget).find(".close").click({dialogTarget: e.data.dialogTarget}, function(e){
				e.data.dialogTarget.dialog("close");
			});
		});
		
		jqInput
		.after( $("<button type=\"button\" class=\"artn-button board\" style=\"color: #333\">우편번호 검색</button>").click({dialogTarget: jqDialog}, fnOpenDialog) );
		//jqInput.click({dialogTarget: jqDialog}, fnOpenDialog);
		//jqAddress.click({dialogTarget: jqDialog}, fnOpenDialog);
		//jqAddressNew.click({dialogTarget: jqDialog}, fnOpenDialog);

		//jqInput.attr("readonly", true);
		//jqAddress.attr("readonly", true);
	},
	
	/**
	 * 우편번호 XML 데이터를 JSON 데이터로 변경한다.
	 * @param {String} data XML 데이터
	 * @return {Map[]}
	 */
	parseZipcodeData : function(data){
		var jqXml = $(data);
		var maData = [];
		var jqMatchTd;
		var sDong = "";
		var sNewAddr = "";
		
		jqXml.find("tr:even").each(function(index){
			jqMatchTd = $(this).children("td");
			sDong = jqMatchTd.eq(1).find("b").text();
			sNewAddr = jqMatchTd.eq(1).find("a").text();
			
			if (sDong){
				sNewAddr += "(" + sDong + ")";
			}
			//if ((sDong == null) || (sNewAddr == null)) break;
			
			maData[index] = {
				row_num: jqMatchTd.eq(0).text(),
				address_new: sNewAddr.trim(),
				address: jqMatchTd.eq(2).text(),
				zipcode: jqMatchTd.eq(3).text()
			};
		});
		
		return maData;
	}
	
//	,
//	regist_coordinate : function(jqButton){
//		var sDialogMap = "";
//		sDialogMap += "<div id=\"dialog_Coordinate\">";
//		sDialogMap += "<div id=\"wrap_innerCoord\">";
//		sDialogMap += " <div id=\"map_panel\">";
//		sDialogMap += " <input id=\"searchTextField\" type=\"text\"></div>";
//		sDialogMap += " <div id=\"map-canvas\"></div>";
//		sDialogMap += " <input type=\"text\" id=\"coordinate\"/>";
//		sDialogMap += " <input type=\"button\" id=\"map_send\" value=\"좌표사용\"/>";
//		sDialogMap += "</div>";
//		sDialogMap += "</div>";
//		jqButton.after(sDialogMap);
//		
//		var mapOptions = {
//			center: new google.maps.LatLng(37.566535, 126.97796919999996),
//		    zoom: 13,
//		    mapTypeId: google.maps.MapTypeId.ROADMAP
//		};
//		var map = new google.maps.Map(document.getElementById('map-canvas'),
//				mapOptions);
//	
//		var input = /** @type {HTMLInputElement} */(document.getElementById('searchTextField'));
//		var autocomplete = new google.maps.places.Autocomplete(input);
//		autocomplete.bindTo('bounds', map);
//		
//		var infowindow = new google.maps.InfoWindow();
//		var marker = new google.maps.Marker({
//		    map: map
//		});
//		
//		var fnOpenDialog = function(e){
//			e.data.dialogTarget.dialog("open");
//		};
//		jqDialog = $("#dialog_Coordinate");
//		
//		jqDialog.dialog({
//			width: 630,
//			height: 550,
//			autoOpen: false,
//			show: {
//                effect: "fade",
//                duration: 500
//            },
//            hide: {
//                effect: "fade",
//                duration: 250
//            }
//		});
//		
//		google.maps.event.addListener(autocomplete, 'place_changed', function() {
//		    infowindow.close();
//		    marker.setVisible(false);
//		    input.className = '';
//		    var place = autocomplete.getPlace();
//		    if (!place.geometry) {
//		      // Inform the user that the place was not found and return.
//		      input.className = 'notfound';
//		      return;
//		    }
//	
//		    // If the place has a geometry, then present it on a map.
//		    if (place.geometry.viewport) {
//		      map.fitBounds(place.geometry.viewport);
//		    } else {
//		      map.setCenter(place.geometry.location);
//		      map.setZoom(17);  // Why 17? Because it looks good.
//		    }
//		    var sLocation = place.geometry.location.toString();
//		    var sCoordinate = sLocation.substring(1,sLocation.length-1);
//		    $("#coordinate").val(sCoordinate);
//		    
//		    marker.setIcon(/** @type {google.maps.Icon} */({
//		      url: place.icon,
//		      size: new google.maps.Size(71, 71),
//		      origin: new google.maps.Point(0, 0),
//		      anchor: new google.maps.Point(17, 34),
//		      scaledSize: new google.maps.Size(35, 35)
//		    }));
//		    marker.setPosition(place.geometry.location);
//		    marker.setVisible(true);
//	
//		    var address = '';
//		    if (place.address_components) {
//		      address = [
//		        (place.address_components[0] && place.address_components[0].short_name || ''),
//		        (place.address_components[1] && place.address_components[1].short_name || ''),
//		        (place.address_components[2] && place.address_components[2].short_name || '')
//		      ].join(' ');
//		    }
//		    
//		    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
//		    infowindow.open(map, marker);
//		});
//	
//		google.maps.event.addDomListener(window, 'load', initialize);
////		$("#dialog_Coordinate").dialog("option", {
////        	modal: true,//다이얼로그 외에는 클릭 안됨
////        	width: 850,
////    		height: 750
////		});
//		
//		jqButton.click({dialogTarget: jqDialog}, fnOpenDialog);
//		
//		$("#map_send").click({dialogTarget: jqDialog, to: jqButton.data("to")}, function(e){
//			$(e.data.to).val($("#cooldinate").val());
////			$(opener.document).find("textbox_zipcode_group").val();
//			e.data.dialogTarget.dialog("close");
//		});
//		
////		$("input[name='map_button']").click(function(){
////			$("#dialog_Coordinate").dialog("open");
////		});
//	}
};