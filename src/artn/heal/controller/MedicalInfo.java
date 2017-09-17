package artn.heal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import artn.common.Util;
import artn.common.model.User;
import artn.database.DBManager;
import artn.heal.controller.AbsHeal365ActionController;

public class MedicalInfo {
	private int readingLimit = 10;
	private int readingCount = 0;
	private DBManager dbm = null;
	private User user = null;
	private String idMedi = "";
	private String mediName = "";
	private Heal365AuthManager auth;
	public static MedicalInfo getInstanceBySession(Map<String, Object> session){
		try{
			if (session.containsKey("medicalInfo") == false){
				MedicalInfo medicalInfo = new MedicalInfo((User)session.get("user"));
				session.put("medicalInfo", medicalInfo);
				
				return medicalInfo;
			}
			else{
				return (MedicalInfo)session.get("medicalInfo");
			}
		}
		catch(Exception ex){
			return null;
		}
		
	}
	
	public MedicalInfo(User user){
		this.user = user;
		try {
			this.dbm = new DBManager();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String getIdMedi(){
		if (readingCount == 0){
			loadIdMedi();
			readingCount++;
		}
		else if (readingCount >= readingLimit){
			readingCount = 0;
		}
		else{
			readingCount++;
		}
		
		
		return idMedi;
	}
	
	public String getMediName(){
		return mediName;
	}
	
	protected void loadIdMedi(){
		ActionContext context = ActionContext.getContext();
		Map<String, Object> session = context.getSession();
		
		Map<String, Object> mParam = null;
		List<Map<String, Object>> lmResult = null;
		auth = new Heal365AuthManager(user);
		try{
			mParam = Util.getInstance().createMap();
			mParam.put("id_user", user.getId());
			if(auth.getIsAdmin() == false){
				mParam.put("group_type", 4);	
			}
			
			lmResult = dbm.select("group-user-single", mParam);
			if(auth.getIsAdmin() || auth.getIsSiteUser()){
				if(session.containsKey("idGroup")){
					idMedi = session.get("idGroup").toString();
					mediName = session.get("groupName").toString();
				}
			}
			else{
				idMedi = lmResult.get(0).get("id_group").toString();
				mediName = lmResult.get(0).get("group_name").toString();
			}
			return;
		}catch(NullPointerException ex){
			//System.out.println("MedicalInfo.loadIdMedi::\r\n" + ex);
		}catch(Exception ex){
			//System.out.println("MedicalInfo.loadIdMedi::\r\n" + ex);
		}
		idMedi = "0";
		mediName = "";
	}
}
