package artn.heal.controller;

import java.util.List;
import java.util.Map;
import artn.common.FieldFormatter;
import artn.common.JSON;

public class CombAction extends AbsHeal365ActionController{

	/**
	 * 
	 */
	public static final String JSON_TEMPLATE = "{\r\n\"subject\": \"%1s\", \"cate_movie0\": \"%2s\", \"desc\": \"%3s\", \"useCount\": %4s, \"tracks\": %5s\r\n}\r\n";
	public static final String[] JSON_FIELD = new String[]{
		"subject"};
	public static final String[] JSON_FIELD_TRACKS = new String[]{
		"seq", "id_movie", "file_img", "file_webm",
		"file_mp4", "file_ogg", "file_mp3", "subject_movie",
		"repeat_cnt", 
		"nth", "left_right", "popup", "popup_msg", "popup_action"};
	
	private static final long serialVersionUID = -4410652540104788252L;
	private FieldFormatter fieldFormat = MovieCategoryFormatter.getInstance();
	private List<Map<String, Object>> groupList = null;
	
	@Override
	public String list() throws Exception {
		if (user() == null) return LOGIN;
		setActionURI("list.action");
		this.fieldFormat.fillCategory(getParams(), "cate_movie");
		doList("comb-all");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		if (user() == null) return LOGIN;
		
		doShow("comb-single");
		doShowSub("movieList","comb-single-sub");
		readSubData_GroupList();
		if(getParams().containsKey("json") == true){
			doEdit("comb-view-cnt");
		}
		return successOrJsonShow();
	}
	// FIXME: 추 후 프레임워크 적용 시 수정 할 것 - by jhson - 2013.07.11
	protected void readSubData_GroupList(){
		dbm().open();
		groupList = dbm().select("group-company-list", getParams());
		dbm().close();
	}

	@Override
	public String edit() throws Exception {
		if (user() == null) return LOGIN;
		
		show();
		return "success";
	}
	
	public String json() throws Exception {
		doShow("comb-single");
		doShowSub("comb-single-sub");
		return "success";
	}
	
	public String combsublist() throws Exception {
		doList("comb-single-sub");
		return successOrJsonList();
	}
	
	public String searchOne() throws Exception {
		String sUsedCombId = "";
		String sSearchedCombId = "";
		
		doShow("comb-single-search");
		
		sSearchedCombId = getShowData().get("id").toString();
		getShowData().put("left_right_user", getParams().get("left_right").toString());
		getShowData().put("menu", getParams().get("menu").toString());
		getShowData().put("cate_movie1", getParams().get("cate_movie1").toString());
		getShowData().put("direction", getParams().get("direction").toString());
		getShowData().put("left_right", getParams().get("left_right").toString());
		
		if (session().containsKey("combId") == true){
			sUsedCombId = session().get("combId").toString();
		}
		if (sUsedCombId.equals(sSearchedCombId) == false){
			session().put("combId", sSearchedCombId);
			session().put("nth", 1);
		}
		
		return "success";
	}
	
	@Override
	public String getJsonShow(){
		Map<String, Object> data = getShowData();
		StringBuilder sbSubJson = JSON.encode(getSubData().get("movieList"));
		
		return String.format(JSON_TEMPLATE, 
				data.get("subject"), data.get("cate_movie0"), "", "1", 
				sbSubJson
				);
	}
//	public String getJSON(){
//		Map<String, Object> data = getShowData();
//		StringBuilder sbSubJson = JSON.encode(getSubData().get("movie-list"));
//		
//		return String.format(JSON_TEMPLATE, 
//				data.get("subject"), data.get("cate_movie0"), "", "1", 
//				sbSubJson
//				//JSON.convertWithSplit(sb, JSON_FIELD_TRACKS, data)
//				);
//	}

	public String getJsonList(){
		return JSON.encode(getListData()).toString();
	}

//	@Override
//	public void onAfterConvert(Object sender, Map<String, Object> params) {
//		
//	}

	public List< Map<String, Object> > getGroupList(){
		return this.groupList;
	}

	@Override
	public String write() throws Exception {
		return "success";
	}

	@Override
	public String modify() throws Exception {
		/////////// ?? ofAfterConvert 에서 옮겨옮
		if (getParams().containsKey("_fromPrescript") == true){
			String[] saVas = getParams().get("vas").toString().split("-");
			
			if (getParams().containsKey("id_comb") == true){
				getParams().put("id", getParams().get("id_comb"));
			}
			else{
				getParams().remove("id");
			}
			getParams().put("id_user_creator", getParams().get("id_therap"));
			getParams().put("subject", getParams().get("subject_comb"));
			getParams().put("vas_low", saVas[0]);
			getParams().put("vas_high", saVas[1]);
		}
		else{
			getParams().put("id_user_creator", getParams().get("id_user"));
		}

		fieldFormat.fillCategory(getParams(), "cate_movie");
		/////////
		if (getParams().containsKey("id") == false){
			getParams().put("id", util.getIdByNowDateTime());
		}
		
		valid.checkEmptyValue(getParams(), "", "cate_movie2", "cate_movie3");
		valid.checkEmptyValue(getParams(), 0, "vas_high", "id_group");
		
		doEdit("comb-modify");
		if (getArrayParams().containsKey("nth") == true){
			doEditSub("comb-modify-cont-365plus", "comb-delete-cont", "seq");
		}
		else{
			doEditSub("comb-modify-cont", "comb-delete-cont", "seq");
		}
		return "success";
	}

	@Override
	public String delete() throws Exception {
		return null;
	}
	
}
