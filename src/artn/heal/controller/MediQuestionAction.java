package artn.heal.controller;

import java.io.IOException;
import java.util.Map;
import java.util.Random;

import artn.common.FileNameChangeMode;
import artn.common.controller.AbsUploadActionController;
import artn.common.manager.LoginManager;
import artn.common.model.User;

public class MediQuestionAction extends AbsHeal365ActionController {
	/**
	 * 
	 */
	private static final long serialVersionUID = -886343068109405829L;
	
	public String getIdMedi(){
		return MedicalInfo.getInstanceBySession(session()).getIdMedi();
	}
	
	@Override
	public String list() throws Exception{
		try{
			user().setIdGroup(getIdMedi());
			if( auth().getIsAdmin() && session().get("idGroup").equals("") == false){
				getParams().put("id_medi", session().get("idGroup"));
			}
			else if( (auth().getIsAdmin() == false) && (auth().getIsGroupStaff() == false) && (auth().getIsNurse() == false) ){
				getParams().put("id_user", user().getId());
				getParams().put("id_medi", session().get("idGroup"));
			}else if( auth().getIsAdmin() == false ){
				getParams().put("id_medi", Integer.parseInt( getIdMedi().toString() ));
			}
			doList("medi-question-all");
			return successOrJsonList();
		}
		catch(Exception ex){
			return LOGIN;
		}
	}
	
	@Override
	public String show() throws Exception {
		try{
			user().setIdGroup(getIdMedi());
			doShow("medi-question-single");
			return successOrJsonShow();
		}
		catch(Exception ex){
			return LOGIN;
		}
	}
	
	@Override
	public String edit() throws Exception {
		try{
			user().setIdGroup(getIdMedi());
			show();
			return SUCCESS;
		}
		catch(Exception ex){
			return LOGIN;
		}
	}

	@Override
	public String modify() throws Exception {
		try{
			valid.checkEmptyValue(getParams(), 0, "height", "weight", "feet_size");
			valid.checkEmptyValue(getParams(), "", "text1", "text2");
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
			
			int idMedi = 0;
			if (auth().getIsAdmin() == false){
				idMedi = Integer.parseInt( getIdMedi().toString() );
				getParams().put("medi_name", user().getGroupInfo(getIdMedi().toString()).get("group_name") );
			}
			else{
				getParams().put("medi_name", "" );
			}
			getParams().put("id_medi", idMedi);
			doEdit("medi-question-modify");
			return SUCCESS;
		}
		catch(Exception ex){
			return LOGIN;
		}
	}
	
	@Override
	public String write() throws Exception {
		try{
			user().setIdGroup(getIdMedi());
			return SUCCESS;
		}
		catch(Exception ex){
			return LOGIN;
		}
	}
	
	@Override
	public String delete() throws Exception {		
		return SUCCESS;
	}
	
	
}
