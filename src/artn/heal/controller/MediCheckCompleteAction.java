package artn.heal.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import artn.common.model.User;

public class MediCheckCompleteAction extends AbsHeal365ActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4872645947728701945L;

	private String sStats_start = "";
	private String sStats_end = "";
	private int iTodayYear = 0;
	
	@Override
	public String list() throws Exception {
		if(auth().getIsAdmin() && session().get("idGroup").equals("") == false){
			getParams().put("id_medi", session().get("idGroup"));
		}
		else if (auth().getIsNurse() || auth().getIsGroupStaff()){
			getParams().put("id_medi", getIdMedi());			
		}
		else if ( auth().getIsPatient() || auth().getIsUser()) {			
			getParams().put("id_user", user().getId());
			getParams().put("id_medi", session().get("idGroup"));
		}
		else if (getParams().containsKey("id_medi") == false){
			getParams().put("id_medi", 0);			
		}

		String sYear = new SimpleDateFormat("yyyy").format(new Date()).toString();
		iTodayYear = Integer.parseInt(sYear) ;
		
		dbm().open();
		doShowSub("fieldInfo", "medi-check-complete-conf-all");//필드정보
		doList("medi-check-complete-all");//데이터
		dbm().close();
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		//doList("medi-check-conf-show");
		String sFieldVal = "";
		String[] saFieldVal;
		int iFieldVal = 0;
		dbm().open();
		doList("medi-check-complete-single");
		for(int i = 0; i < getListData().size(); i++){
			if(getListData().get(i).get("field_type").equals(1)){
				getParams().put("id", getListData().get(i).get("id_medi_check_field"));
				sFieldVal = dbm().selectOneNonOpen("medi-check-field-single", getParams()).get("field_label").toString();
				try{
					iFieldVal = (int)Float.parseFloat(getListData().get(i).get("field_value").toString());
					saFieldVal = sFieldVal.split(",");
					getListData().get(i).put("field_result",saFieldVal[iFieldVal - 1]);
				}catch(Exception e){
					getListData().get(i).put("field_result","");
				}
				
			}
		}
		dbm().close();
		return successOrJsonList();
	}

	@Override
	public String edit() throws Exception {
		show();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		ArrayList<Integer> liIndex;
		
		valid.checkEmptyValue(getParams(), 0, "id_medi");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		valid.checkEmptyValue(getParams(), user().getId(), "id_user", "id_writer", "id_writer_last");
		valid.checkEmptyValue(getParams(), user().getName(), "user_name", "writer_name", "writer_last_name");
		
		if (getArrayParams().containsKey("field_value") == true){
			liIndex = getNotEmptyFieldIndicesByKeyName("field_value");
			
			dbm().open();
			
			for(Integer index : liIndex){
				mergeParams(index, "id_medi_check_field", 
						"field_name", "field_value", "field_type", "field_unit", 
						"position_group", "position_seq");
				mergeParamsWithEmptyDataToNull(
					index, "id");
				
				if (getParams().get("field_type").equals("0")){
					getParams().put("field_result", dbm().selectOneString("medi-check-field-getResult", getParams()) );
				}
				else{
					getParams().put("field_result", getResultByFieldLabel());
				}
				
				
				dbm().updateNonCommit("medi-check-data-modify", getParams());
			}
			
			dbm().commit();
			dbm().close();
		}
		else{
			// 진짜 필드 하나만 쓰는 곳이 있을까 -_-; 여튼 적으면 좋을 듯..
		}

		return SUCCESS;
	}
	
	protected ArrayList<Integer> getNotEmptyFieldIndicesByKeyName(String key){
		ArrayList<Integer> liIndex = new ArrayList<Integer>();
		String[] saFieldValue = getArrayParams().get("field_value");
		int iLen = saFieldValue.length;
		
		for(int i = 0; i < iLen; i++){
			try{
				if (saFieldValue[i].length() > 0){
					liIndex.add(i);
				}
			}
			catch(Exception ex){}
		}
		
		return liIndex;
	}
	
	protected void mergeParamsWithEmptyDataToNull(int index, String... keys){
		String sVal;
		
		for(String key : keys){
			sVal = getArrayParams().get( key )[ index ];
			
			if (sVal.equals("")){
				getParams().remove(key);
			}
			else{
				getParams().put(key, sVal);
			}
		}
	}
	protected void mergeParams(int index, String... keys){
		String sVal;
		
		for(String key : keys){
			sVal = getArrayParams().get( key )[ index ];
			
			getParams().put(key, sVal);
		}
	}
	
	protected String getResultByFieldLabel(){
		String[] saFieldLabel = getParams().get("field_label_" + getParams().get("id_medi_check_field") ).toString().split(",");
		int iValue = Integer.parseInt(getParams().get("field_value").toString());
		
		return saFieldLabel[ iValue - 1 ] + getParams().get("field_unit");
	}

	@Override
	public String delete() throws Exception {

		return SUCCESS;
	}
	
	public String stats() throws Exception {
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
		doShowSub("fieldInfo", "medi-check-complete-conf-all", "GroupCnt", "complete-stats-group-count");//필드정보
		String sField = "";
		for(int i = 0; i < getSubData().get("fieldInfo").size(); i++){
			sField = getSubData().get("fieldInfo").get(i).get("field_column").toString().split("_")[0];
			getSubData().get("fieldInfo").get(i).put("field_column", sField);
		}
		doList("complete-stats-user-count");
		dbm().close();
		sStats_start = getParams().get("date_stats_start").toString();
		sStats_end = getParams().get("date_stats_end").toString();
		return SUCCESS;
	}
	
	public boolean getIsLinkedPres(){
		return false;
	}
	
	public boolean getIsCompleted(){
		return false;
	}

	public String getDateStatsStart(){
		return sStats_start;
	}
	
	public String getDateStatsEnd(){
		return sStats_end;
	}
	
	public Integer getTodayYear(){
		return iTodayYear;
	}
}
