<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="cmb">${param.cmb }</s:set>
<s:set var="val">${param.val }</s:set>
<s:set var="sub">${param.sub }</s:set>
<s:set var="chain">${param.chain }</s:set>

<s:if test='%{#cmb in {"cate_movie0", "cate_comb0"}}'>
	<s:select name="%{#cmb}" id='%{"combobox_" + #cmb}' list='%{#{
		"__": "-",
		"HL": "힐링업365",
		"SF": "365PLUS"
	}}' value="val" theme="simple"/>
</s:if>

<s:elseif test='%{#cmb == "cate_movie1"}'>
	<s:if test='%{#sub == "SF"}'>
	<s:select name="%{#cmb}" id='%{"combobox_" + #cmb}' list='%{#{
		"": "-",
		"1": "The head and neck region",
		"2": "The upper back, shoulder, and arm region",
		"3": "The elbow-to-finger region",
		"4": "The torso region",
		"5": "The lower torso region",
		"6": "The hip, thigh, and knee regions",
		"7": "The leg, ankle, and foot regions"
	}}' value="val" theme="simple"/>
	</s:if>
	
	<s:elseif test='%{#sub == "HL_kor"}'>
	<s:set var="cmbList" value='%{#{
		"": "-",
		"1": "목 (Neck)",
		"2": "어깨 (Shoulder)",
		"3": "팔꿈치 (Elbow)",
		"4": "허리 (Trunk)",
		"5": "엉덩이 (Hip)",
		"6": "무릎 (Knee)",
		"7": "발목 (Ankle)"
	}}'/>
	<s:iterator value="#cmbList" var="cmbItem" status="status">
	<s:if test='%{#status.index == #val}'>
	<s:property value='%{#cmbItem.value}'/>
	</s:if>
	</s:iterator>
	</s:elseif>
	
	<s:else>
	<s:select name="%{#cmb}" id='%{"combobox_" + #cmb}' list='%{#{
		"": "-",
		"1": "목 (Neck)",
		"2": "어깨 (Shoulder)",
		"3": "팔꿈치 (Elbow)",
		"4": "허리 (Trunk)",
		"5": "엉덩이 (Hip)",
		"6": "무릎 (Knee)",
		"7": "발목 (Ankle)"
	}}' value="val" theme="simple"/>
	</s:else>
</s:elseif>

<s:elseif test='%{#cmb in {"cate_movie2", "cate_comb2"}}'>
	<s:select name="%{#cmb}" id='%{"combobox_" + #cmb}' list='%{#{
		"": "-",
		"1": "Lateral",
		"2": "Front",
		"3": "Rear"
	}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb in {"cate_vas", "vas_high", "vas_low", "body_vas"}}'>
	<s:select name='%{#cmb}' id='%{"combobox_" + #cmb}' list='%{#{
		"": "-",
		"0-2.9": "0.0 ~ 2.9",
		"3-5.9": "3.0 ~ 5.9",
		"6-10": "6.0 ~ 10.0"
	}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "vas"}'>
	<s:select name='%{#cmb}' id='%{"combobox_" + #cmb}' list='%{#{
		"0-0.9": "0.0 ~ 0.9",
		"1-1.9": "1.0 ~ 1.9",
		"2-2.9": "2.0 ~ 2.9",
		"3-3.9": "3.0 ~ 3.9",
		"4-4.9": "4.0 ~ 4.9",
		"5-5.9": "5.0 ~ 5.9",
		"6-6.9": "6.0 ~ 6.9",
		"7-7.9": "7.0 ~ 7.9",
		"8-8.9": "8.0 ~ 8.9",
		"9-9.9": "9.0 ~ 9.9",
		"10-10": "10.0"
	}}' value="val" theme="simple"/>
</s:elseif>

<s:if test='%{#cmb in {"left_right"}}'>
	<s:select name="%{#cmb}" id='%{"combobox_" + #cmb}' list='%{#{
		"": "-",
		"L": "좌",
		"R": "우"
	}}' value="val" theme="simple"/>
</s:if>


<s:elseif test='%{#cmb in {"cate_movie3", "cate_comb3"}}'>
	<s:if test='%{#sub == "1.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Vertex pain",
		"2": "Frontal headache",
		"3": "Temporal headache",
		"4": "Eye and eyebrow pain",
		"5": "Cheek and jaw pain",
		"6": "Toothache",
		"7": "Ear and temporomanibular joint pain",
		"8": "Back-of-head pain",
		"9": "Throat and front-of-neck pain",
		"10": "Back-of-neck pain"
	}}' value="val" theme="simple"/>
	</s:if>

	<s:elseif test='%{#sub == "1.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Vertex pain",
		"2": "Frontal headache",
		"3": "Temporal headache",
		"4": "Eye and eyebrow pain",
		"5": "Cheek and jaw pain",
		"6": "Toothache",
		"7": "Ear and temporomanibular joint pain",
		"8": "Throat anf front-of-neck pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "1.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Vertex pain",
		"2": "Back-of-head pain",
		"3": "Back-of-neck pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "2.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"1": "-"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "2.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Front-of-shoulder pain",
		"2": "Front-of-arm pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "2.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Upper-thoracic back pain",
		"2": "Back-of-shoulder pain",
		"3": "Mid-thoracic back pain",
		"4": "Back-of-arm pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "3.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"1": "-"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "3.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Medical epicondylar pain",
		"2": "Olecranon pain",
		"3": "Lateral epicondylar pain",
		"4": "Ulnar forearm pain",
		"5": "Dorsal forearm pain",
		"6": "Radial forearm pain",
		"7": "Dorsal wrist and hand pain",
		"8": "Base-of-thumb and radial hand pain",
		"9": "Dorsal finger pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "3.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Lateral epicondylar pain",
		"2": "Antecubital pain",
		"3": "Medial epicondylar pain",
		"4": "Radial forearm pain",
		"5": "Volar forearm pain",
		"6": "Ulnar forearm pain",
		"7": "Base-of-thumb and radial hand pain",
		"8": "Volar wrist and palmar pain",
		"9": "Volar finger pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "4.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Side-of-chest pain",
		"2": "Sacral and gluteal pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "4.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Front-of-chest pain",
		"2": "Side-of-chest pain",
		"3": "Abdominal pain",
		"4": "Sacral and gluteal pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "4.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Side-of-chest pain",
		"2": "Low thoracic back pain",
		"3": "Lumbar pain",
		"4": "Sacral and gluteal pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "5.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Buttock pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "5.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Lower abdominal pain",
		"2": "Buttock pain",
		"3": "Pelvic pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "5.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Lumbar pain",
		"2": "Buttock pain",
		"3": "Ilisosacral pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "6.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Lateral thigh and hip pain",
		"2": "Medial thigh pain",
		"3": "Lateral knee pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "6.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Lateral thigh and hip pain",
		"2": "Anterior thigh pain",
		"3": "Medial thigh pain",
		"4": "Anterior knee pain",
		"5": "Lateral knee pain",
		"6": "Anteromedial knee pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "6.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Lateral thigh and hip pain",
		"2": "Posterior thigh pain ",
		"3": "Medial thigh pain",
		"4": "Posterior knee pain",
		"5": "Lateral knee pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "7.1"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Anterior leg pain",
		"2": "Lateral leg pain",
		"3": "Posterior leg pain",
		"4": "Anterior ankle pain",
		"5": "Lateral ankle pain",
		"6": "Posterior ankle pain",
		"7": "Dorsal forefoot pain",
		"8": "Dorsal great toe pain",
		"9": "Dorsal lesser toe pain",
		"10": "Heel pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:elseif test='%{#sub == "7.2"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Anterior leg pain",
		"2": "Lateral leg pain",
		"3": "Medial ankle pain",
		"4": "Anterior ankle pain",
		"5": "Lateral ankle pain",
		"6": "Dorsal forefoot pain",
		"7": "Dorsal great toe pain",
		"8": "Dorsal lesser toe pain"
	}}' value="val" theme="simple"/>
	</s:elseif>
	
	<s:elseif test='%{#sub == "7.3"}'>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-",
		"1": "Posterior leg pain",
		"2": "Lateral leg pain",
		"3": "Posterior ankle pain",
		"4": "Lateral ankle pain",
		"5": "Plantar midfoot pain",
		"6": "Metatarsal head pain",
		"7": "Plantar great toe pain",
		"8": "Plantar lesser toe pain",
		"9": "Heel pain"
	}}' value="val" theme="simple"/>
	</s:elseif>

	<s:else>
	<s:select name="cate_movie3" id="combobox_cate_movie3" list='%{#{
		"": "-"
	}}' value="val" theme="simple"/>
	</s:else>
</s:elseif>

<s:if test='%{(#chain != null) && (#chain != "")}'>
<input type="hidden" name="combochain" value="{'actor': ${param.chain}, 'chain': '${param.cmb}', 'ajaxUrl': '/include/combobox-data/cate_movie.jsp'}"/>
</s:if>