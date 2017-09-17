package artn.common.controller;

import java.util.Map;

import artn.common.Util;
import artn.common.model.User;

public class SurveyAction extends AbsSubDataActionController {

	@Override
	public String list() throws Exception {
		doList("survey-all");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		doList("survey-single");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		doList("survey-single");
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		/* 제목  */
		
		//id_group  파라미터 X
		valid.checkEmptyValue(getParams(), 0, "id_group");
		
		//id 파라미터 X
		
		//question_count 파라미터 X
		valid.checkEmptyValue(getParams(), 0, "question_count");
		
		if(getArrayParams().containsKey("question_cont")){
			getParams().put("question_count", getArrayParams().get("question_cont").length); 
		} else {
			getParams().put("question_count", 1);
		}
		//work_type 파라미터 O
		
		//subject 파라미터 O
		
		//date_upload  파라미터 X 디비에 NOW()
		
		//id_writer  파라미터 X
		/*getParams().put("id_writer", user().getId());*/
		/*valid.checkEmptyValue(getParams(),user().getId(),"id_writer");*/
		
		//writer_name  파라미터 X
		/*getParams().put("writer_name", user().getName());*/
		/*valid.checkEmptyValue(getParams(),user().getName(), "writer_name");*/
		
		//date_start 파라미터 O
		
		//date_end 파라미터 O
		
		//opt 파라미터 O
		
		
		doEdit("survey-modify");
		if(getParams().containsKey("id") == false){
			doShow("common-inserted-id");
			getParams().put("id_survey", getShowData().get("id").toString());
		}else{
			getParams().put("id_survey", getParams().get("id"));
			getParams().remove("id");
		}
		
		/* 설문조사 문항 DB  */
		//id 파라미터 X
		
		//id_servey 파라미터 X 입력하자 마자 아이디값 불러와서 저장
	
		//seq 파라미터 O
		String[] seq = getArrayParams().get("seq");
		
		//work_type 파라미터 X 위쪽에 있는 값 가져와서 저장
		
		
		//question_cont 파라미터 O
		String[] question_cont = getArrayParams().get("question_cont");
				
		//question_type 파라미터 O
		String[] question_type = getArrayParams().get("question_type");
		
		//question_item 파라미터 O
		String[] question_item = getArrayParams().get("question_item");
		
		
		doEditSub("survey-question-modify","survey-question-delete","seq");
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	public String answer_open() throws Exception {
		doList("survey-single");
		return SUCCESS;
	}
	
	public String answer_complete() throws Exception {
		
		//id 오토인그리먼트
		
		//id_survey 파라미터 O
		
		
		//id_question  파라미터 O
		
		//seq  파라미터 O
		
		//wortk_type  파라미터 O
		
		//answer_int
		boolean survey = false;
		if(getArrayParams().containsKey("seq")){
			String[] answer_int = new String[getArrayParams().get("seq").length];
			for(int i = 0 ; i < getArrayParams().get("seq").length ;i ++ ){
				answer_int[i] = getParams().get("answer_int"+(i+1)).toString();
				if( getArrayParams().get("question_type")[i].equals("0") && answer_int[i].equals("1")){
					survey = true;
				}
			}
			getArrayParams().put("answer_int",answer_int);
			
			doEditSub("survey-answer-modify","","seq");
		}else{
			
			if(getParams().get("question_type").equals("0") && getParams().get("answer_int1").equals("1")){
				survey = true;
			}
			getParams().put("answer_int", getParams().get("answer_int1"));
			doEdit("survey-answer-modify");
		}
		
		/**/
		if(survey){
			return "login_survey";
		}
		//answer_text
		
		//id_user 파라미터 O
		
		//user_name 파라미터 O
		
		//date_upload
		
		return SUCCESS;
	}

	

}
