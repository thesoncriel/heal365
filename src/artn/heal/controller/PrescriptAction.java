package artn.heal.controller;

import java.util.Map;

import artn.common.model.User;

public class PrescriptAction extends AbsHeal365ActionController{

	private static final long serialVersionUID = -533559835624683766L;
	
	private boolean isManageList = false;
	private String sStats_start = "";
	private String sStats_end = "";
	
	public String getIdMedi(){
		return MedicalInfo.getInstanceBySession(session()).getIdMedi();
	}
	
	@Override
	public String list() throws Exception {
		if (getParams().containsKey("search_div") == false){
			getParams().put("search_div", "");
		}
		setActionURI("list.action");
		doList("prescript-all");
		return SUCCESS;
	}
	
	public String listAdmin() throws Exception {
		getParams().put("is_admin", 1);
		getParams().remove("id_user");
		getParams().remove("id_medi");
		isManageList = true;
		getParams().put("id_medi", session().get("idGroup"));
		list();
		return SUCCESS;
	}
	
	public String listMediStaff() throws Exception {
		if (getParams().containsKey("id_medi") == false){
			getParams().put("id_medi", getIdMedi() );
		}
		isManageList = true;
		
		getParams().put("group_type", 0x4);
		getParams().remove("is_admin");
		
		list();
		return SUCCESS;
	}
	
	public String listPatient() throws Exception {
		getParams().put("id_medi", session().get("idGroup"));
		getParams().put("id_user", user().getId().toString());
		getParams().put("group_type", 0x4);
		getParams().remove("is_admin");
		
		list();
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		String sFieldVal = "";
		String[] saFieldVal;
		int iFieldVal = 0;
		
		doShow("prescript-single");
		getParams().put("id_medi", getShowData().get("id_medi"));
		doShowSub("combList","prescript-single-sub");
		getParams().remove("id");
		getParams().put("id_medi_question",getShowData().get("id_medi_question"));
		getParams().put("id_complete",getShowData().get("id_medi_check"));
		doShowSub("mediCheck","medi-check-complete-single","mediQuestion","medi-question-single");
		String pain_since = "";
		dbm().open();
		for(int i = 0; i < getSubData().get("mediCheck").size(); i++){
			if(getSubData().get("mediCheck").get(i).get("field_type").equals(1)){
				getParams().put("id", getSubData().get("mediCheck").get(i).get("id_medi_check_field"));
				sFieldVal = dbm().selectOneNonOpen("medi-check-field-single", getParams()).get("field_label").toString();
				try{
					iFieldVal = (int)Float.parseFloat(getSubData().get("mediCheck").get(i).get("field_value").toString());
					saFieldVal = sFieldVal.split(",");
					getSubData().get("mediCheck").get(i).put("field_result",saFieldVal[iFieldVal - 1]);
				}catch(Exception e){
					getSubData().get("mediCheck").get(i).put("field_result","");
				}
			}
		}
		getParams().put("id_complete",getShowData().get("id_physics"));
		getParams().put("id_task",getShowData().get("id_physics"));
		doShowSub("physics","physics-complete-single","approval","approval-process-all");
		for(int i = 0; i < getSubData().get("physics").size(); i++){
			if(getSubData().get("physics").get(i).get("field_type").equals(1)){
				getParams().put("id", getSubData().get("physics").get(i).get("id_medi_check_field"));
				sFieldVal = dbm().selectOneNonOpen("physics-field-single", getParams()).get("field_label").toString();
				try{
					iFieldVal = (int)Float.parseFloat(getSubData().get("physics").get(i).get("field_value").toString());
					saFieldVal = sFieldVal.split(",");
					getSubData().get("physics").get(i).put("field_result",saFieldVal[iFieldVal - 1]);
				}catch(Exception e){
					getSubData().get("physics").get(i).put("field_result","");
				}
			}
		}
		
		dbm().close();
		if(getShowData().get("pain_since") == ""){
			pain_since = "10월";
		}else{
			pain_since = getShowData().get("pain_since").toString();
		}
		
		String pain1 = pain_since.substring(0,pain_since.length()-1);
		String pain2 = pain_since.substring(pain_since.length()-1);
		
		getShowData().put("pain_since1",pain1);
		getShowData().put("pain_since2",pain2);
		getShowData().put("id_medi", getIdMedi());
		getShowData().put("id_writer", user().getId());
		getShowData().put("id_writer_last", user().getId());
		getShowData().put("medi_name", getMediName());
		getShowData().put("writer_name", user().getName());
		getShowData().put("writer_last_name", user().getName());
		
		if (getSubData().get("combList").size() <= 1){
			//getSubData().get("combList").clear();
		}
		if (getShowIsNull() == true) return ERROR_AUTH;
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		Object oIdComb = null;
		show();
		
		if ((getShowIsNull() == false) && 
			(getShowData().get("status").toString().equals("1") == true) &&
			(auth().getIsTherap() == true)){
			getShowData().put("therap_name", user().getName());
			getShowData().put("id_therap", user().getId());
			getShowData().put("status", 100);
		}
		
		oIdComb = getShowData().get("id_comb");
		
		if ((oIdComb == null) || ("".equals(oIdComb))){
			getShowData().put("id_comb", util.getIdByNowDateTime());
		}
			
		return SUCCESS;
	}


// 처방전 삭제 기능 추가 20130702 - thkim
	public String delete() throws Exception {
		doEdit("prescript-delete");
		if (getArrayParams().containsKey("id") == true){
			doEditSub("prescript-delete", "prescript-delete", "id");
		}
		if (getAuth().getIsAdmin()){
			return "admin";
		}
		return "mediStaff";
	}
	
	@Override
	public String write() throws Exception {
		
		Map<String, Object> map = getShowData();
		//Map<String, Object> mGroup = (Map<String, Object>) session().get("group");
		User user = user();
		
		/*System.out.println(map);*/
		
		String sNow = getUtil().getNow();
		int id = 0;
		int idMedi = 0;
		
		map.put("doctor_name", user.getName());
		map.put("id_doctor", user.getId());
		
		if (auth().getIsAdmin() == false){
			idMedi = Integer.parseInt( getIdMedi().toString() );
			map.put("medi_name", user().getGroupInfo(getIdMedi().toString()).get("group_name") );
		}
		else{
			map.put("medi_name", "" );
		}
		map.put("id_medi", idMedi);
		
		
		if (auth().getIsAdmin() || auth().getIsTherap()){
			map.put("therap_name", user.getName());
			map.put("id_therap", user.getId());
			map.put("status", 100);
		}
		else{
			map.put("id_therap", "");
			map.put("status", 1);
		}
		
		
		map.put("date_upload_fmt", sNow);
		map.put("date_end_fmt", util.addDate(sNow, 7 * 4));
		map.put("id_comb", util.getIdByNowDateTime());
		
		dbm().insert("prescript-create", map);
		id = Integer.parseInt(dbm().selectOne("common-inserted-id", map).get("id").toString());
		
		map.put("id", id);
		map.put("id_fmt", String.format("%04d", id));
		map.put("id_medi_fmt", String.format("%03d", idMedi));
		
		map.put("cate_movie1", 1);
		map.put("weekly_chk", 0x1111111);
		if(auth().getIsAdmin()){
			getParams().put("id_medi", session().get("idGroup"));
		}else{
			getParams().put("id_medi", getIdMedi());	
		}
		doShowSub("mediCheck","medi-check-conf-show","physics","physics-conf-show");
		System.out.println(getSubData());
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		/*String[] saBP = getParams().get("bp").toString().split("-");*/
		
		int iWeeklyChkDaily = Integer.parseInt(getParams().get("weekly_chk_daily").toString());
		
		/*getParams().put("bp_low", saBP[0]);
		  getParams().put("bp_high", saBP[1]);
		*/
		getParams().put("pres_comb_seq", 1);
		
		if (getParams().containsKey("curr_sick") == false){
			getParams().put("curr_sick", 0);
		}
		
		valid.checkEmptyValue(getParams(), 0, "height", "weight", "bmi", "pain_dir", "pain_since1", "id_medi_check", "id_medi_question","id_physics");
		valid.checkEmptyValue(getParams(), 1, "frequency", "intensity", "duration", "form");
		getParams().put("pain_since", getParams().get("pain_since1").toString() + getParams().get("pain_since2").toString());
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "pain_site_check");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "pain_type");
		valid.appendParamValueByKey(getParams(), getArrayParams(), "rom", 3);
		
		validDateUpload();
		valid.checkEmptyValue(getParams(), util.addDate(util.getNow(), 28), "date_end");
		
		
		if (iWeeklyChkDaily > 0){
			valid.mergeValueToOtherKey(getParams(), iWeeklyChkDaily, "weekly_chk", 7, 4);
		}
		else{
			valid.mergeMultiValuesByKey(getParams(), getArrayParams(), "weekly_chk", 7, 4);
		}
		
		valid.mergeMultiValuesByKey(getParams(), getArrayParams(), "curr_sick");
		doEdit("prescript-modify", "prescript-modify-sub", "medi-check-update");
		getParams().put("id", getParams().get("id_comb"));
		return (getParams().containsKey("_write") == true)? INPUT : SUCCESS;
	}
	
	protected void validDateUpload(){
		try{
			String sDateUpload = getParams().get("date_upload").toString();
			String sNow = "";
			
			if (sDateUpload.length() <= 10){
				sNow = util.getNow();
				getParams().put("date_upload", sDateUpload + " " +sNow.split(" ")[1]);
			}
		}
		catch(Exception ex){
			getParams().put("date_upload", util.getNow());
		}
		
	}
	
	public boolean getIsManageList(){
		return isManageList;
	}
	
	public String beforeList() throws Exception{
		if (getAuth().getIsAdmin()){
			return "admin";
		}
		
		return "mediStaff";
	}

	public String stats() throws Exception {
		getArrayParams().put("user_age_group", new String[]{
			"10대", "20대", "30대", "40대", "50대", "60대", "70대"
		});
		dbm().open();
		doShowSub("ageGroup", "prescript-stats-ageGroup", false);
		doShowSub("painSite", "prescript-stats-painSite", false);
		doShowSub("painSiteByAge", "prescript-stats-painSiteByAgeGroup", false, "user_age_group");
		dbm().close();
		
		return SUCCESS;
	}
	
	public String statsPainSite() throws Exception {
		if(auth().getIsAdmin() == true){
			getParams().put("admin", true);
			getParams().put("id_medi", session().get("idGroup"));
		}else if (auth().getIsNurse() || auth().getIsGroupStaff()){
			getParams().put("admin", false);
			getParams().put("id_medi", getIdMedi());
		}else if (auth().getIsPatient() || auth().getIsUser()) {
			getParams().put("admin", false);
			getParams().put("id_user", user().getId());
			getParams().put("id_medi", session().get("idGroup"));
		}
		else if (getParams().containsKey("id_medi") == false){
			getParams().put("admin", false);
			getParams().put("id_medi", 0);			
		}
		
		if(getParams().containsKey("date_stats_start") == false){
			getParams().put("date_stats_start", util.getToday());
			getParams().put("date_stats_end", util.getToday());
		}
		dbm().open();
		doShowSub("GroupCnt", "medi-painsite-group-count");//필드정보
		doList("medi-painsite-user-count");
		dbm().close();
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
