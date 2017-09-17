package artn.common.controller;

import java.io.IOException;
import java.util.Map;
import java.util.Random;

import artn.common.FileNameChangeMode;
import artn.common.manager.LoginManager;
import artn.common.model.User;

public class GroupSurveyAction extends AbsUploadActionController {
	/**
	 * 
	 */
	private static final long serialVersionUID = -886343068109405829L;
	
	@Override
	public String list() throws Exception{
		doList("group-survey-all");
		return SUCCESS;
	}
	
	@Override
	public String show() throws Exception {
		doShow("group-survey-single");
		return SUCCESS;
	}
	
	@Override
	public String edit() throws Exception {
		show();
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {		
		int iMaxNum = 6;
		int iTotalCheck = 0;
		String sName = "";
		
		for(int i = 0; i < iMaxNum; i++){
			sName = "check" + i;
			if(getParams().containsKey(sName)){
				iTotalCheck += Integer.parseInt(getParams().get(sName).toString());
			}			
		}		
		getParams().put("check", iTotalCheck);
		
		doEdit("group-survey-modify");
		return SUCCESS;
	}
	
	@Override
	public String write() throws Exception {		
			return SUCCESS;
	}
	
	@Override
	public String delete() throws Exception {		
		return SUCCESS;
	}
	
	
}
