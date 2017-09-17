package artn.heal.controller;

public class MediStatsAction extends AbsHeal365ActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8533352252310980193L;

	private String sStats_start = "";
	private String sStats_end = "";
	
	@Override
	public String list() throws Exception {
		if (user() == null) return LOGIN;
		if( (auth().getIsSiteUser() || auth().getIsAdmin()) && session().get("idGroup").equals("") == false){
			getParams().put("id_group", session().get("idGroup"));
		}
		else if(getAuth().getIsAdmin() == false){
			getParams().put("id_group", getIdMedi());
		}
		getParams().put("auth_group", "262144");
		doList("medi-stats-personal-all");
		getParams().remove("auth_group");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String edit() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public String totalStats() throws Exception{
		if (user() == null) return LOGIN;
		if(auth().getIsAdmin() == true){
//			getParams().put("admin", true);
			getParams().put("id_medi", session().get("idGroup"));
		}else if (auth().getIsNurse() || auth().getIsGroupStaff()){
//			getParams().put("admin", false);
			getParams().put("id_medi", getIdMedi());
		}else if (auth().getIsPatient() || auth().getIsUser()) {	
//			getParams().put("admin", false);
			getParams().put("id_user", user().getId());
			getParams().put("id_medi", session().get("idGroup"));
		}
		else if (getParams().containsKey("id_medi") == false){
//			getParams().put("admin", false);
			getParams().put("id_medi", 0);			
		}
		if(getParams().containsKey("date_stats_start") == false){
			getParams().put("date_stats_start", util.getToday());
			getParams().put("date_stats_end", util.getToday());
		}
		//mediCheck
		doShowSub("checkFieldInfo", "medi-check-complete-conf-all", "checkGroupCnt", "complete-stats-group-count");//필드정보
		String sField = "";
		for(int i = 0; i < getSubData().get("checkFieldInfo").size(); i++){
			sField = getSubData().get("checkFieldInfo").get(i).get("field_column").toString().split("_")[0];
			getSubData().get("checkFieldInfo").get(i).put("field_column", sField);
		}
		//physics
		doShowSub("physicsFieldInfo", "physics-complete-conf-all", "physicsGroupCnt", "physics-complete-stats-group-count");//필드정보
		for(int i = 0; i < getSubData().get("physicsFieldInfo").size(); i++){
			sField = getSubData().get("physicsFieldInfo").get(i).get("field_column").toString().split("_")[0];
			getSubData().get("physicsFieldInfo").get(i).put("field_column", sField);
		}
		//prescript
		doShowSub("prescriptGroupCnt", "medi-painsite-group-count");//필드정보
		sStats_start = getParams().get("date_stats_start").toString();
		sStats_end = getParams().get("date_stats_end").toString();
		return SUCCESS;
	}
	
	public String stats(){
		if (user() == null) return LOGIN;
		if(session().get("idGroup").equals("") == false){
			getParams().put("id_group", session().get("idGroup"));	
			getParams().put("id_medi", session().get("idGroup"));
		}
		else if(getParams().containsKey("id_medi") == false){
			getParams().put("id_group", getIdMedi());
			getParams().put("id_medi", getIdMedi());
		}else{
			getParams().put("id_group", getParams().get("id_medi"));
			getParams().put("id_medi", getParams().get("id_medi"));
		}
		getParams().put("dateGroup", true);
		//userStatus
		doShow("group-user-single");
		if(getParams().containsKey("date_stats_start") == false){
			getParams().put("date_stats_start", getShowData().get("date_join"));
			getParams().put("date_stats_end", util.getToday());
		}
		getParams().put("rowlimit", 100);
		//mediQuestion
		doShowSub("questionList","medi-question-all");
		//mediCheck
		doShowSub("checkFieldInfo", "medi-check-complete-conf-all", "checkList", "medi-check-complete-all");//필드정보
		String sField = "";
		//physics
		doShowSub("physicsFieldInfo", "physics-complete-conf-all", "physicsList", "physics-complete-all");//필드정보
		//prescript
		doShowSub("prescriptList", "medi-painsite-user-count");//필드정보
		sStats_start = getParams().get("date_stats_start").toString();
		sStats_end = getParams().get("date_stats_end").toString();
		return SUCCESS;
	}
	public String getDateStatsStart(){
		return sStats_start;
	}
	
	public String getDateStatsEnd(){
		return sStats_end;
	}
}
