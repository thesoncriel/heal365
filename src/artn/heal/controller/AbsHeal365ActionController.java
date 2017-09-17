package artn.heal.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.Const;
import artn.common.controller.AbsUploadActionController;
import artn.common.manager.AuthManager;

public abstract class AbsHeal365ActionController extends AbsUploadActionController {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8441278242968226884L;
	private Heal365AuthManager authMgr;
	private MedicalInfo mediInfo;
	private String contents;
	private List<Map<String, Object>> maApprover;

	@Override
	public AuthManager getAuth(){
		if (authMgr == null){
			authMgr = new Heal365AuthManager(user());
			//user().setIdGroup(getIdMedi());
		}
		return authMgr;
	}
	
	public MedicalInfo getMedicalInfo(){
		if (mediInfo == null){
			mediInfo = MedicalInfo.getInstanceBySession(session());
		}
		return mediInfo;
	}
	
	public String getIdMedi(){
		return getMedicalInfo().getIdMedi();
	}
	
	public String getMediName(){
		return getMedicalInfo().getMediName();
	}
	
	public boolean getHasApprover() {
		return (maApprover != null) && (maApprover.size() > 0); 
	}
	
	protected void readApprover(int idMedi) {		
		Map<String, Object> mParams = new HashMap<String, Object>();		
		mParams.put("id_group", idMedi);		
		maApprover = dbm().select("approver-user-all", mParams);		
	}
	
	public List<Map<String, Object>> getApproverList(){
		return maApprover;
	}
	
	public String saveIdMedi() throws Exception{
		try{
			user().setIdGroup(getParams().get("idGroup").toString());
			session().put("idGroup", getParams().get("idGroup"));
			session().put("groupName", getParams().get("groupName"));
			setResponse("success");
		}catch(Exception e){
			setResponse("fail");	
		}
		return TEXT_RESPONSE;
	}
/*	public boolean getIsApprover(){
		if(0X2000)
	}*/

// 컨텐츠 코드 정리에 따라 삭제 함. - 2014.01.17 by jhson
//	@Override
//	public String getContentsCode(){
//		if (contents == null){
//			if (getParams().containsKey("contents") == true){
//				contents = getParams().get("contents").toString();
//				if (contents.equals("") == false){
//					return contents;
//				}
//					
//			}
//			if (auth().getIsPatient() == true)				contents = "sub103";
//			else if (getAuth().getIsAdmin() == true)		contents = Const.CONTENTS_NORMAL;
//			else if (getAuth().getIsSiteStaff() == true ) 	contents = Const.CONTENTS_SITE_STAFF;
//			else if (user().getHasAnyGroup() == true) 		contents = Const.CONTENTS_GROUP_MANAGER;
//			else 											contents = Const.CONTENTS_USER;
//		}
//		
//		return contents;
//	}
	
//	@Override
//	public Object getAuth(){
//		if (authMgr == null){
//			authMgr = new Heal365AuthManager(sessionToMap("user"));
//		}
//		return authMgr;
//	}
	
	protected Heal365AuthManager auth(){
		getAuth();
		return authMgr;
	}
}
