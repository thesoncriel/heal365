package artn.heal.controller;

import java.io.IOException;

import artn.common.Const;
import artn.common.FieldFormatter;
import artn.common.FileNameChangeMode;

public class MovieAction extends AbsHeal365ActionController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4798330299259545876L;
	private String uploadPath = "";
	private String movieCategory = "";
	private MovieCategoryFormatter fieldFormat = MovieCategoryFormatter.getInstance();
	private boolean is365plus = false;
	
	public MovieAction(){
		uploadPath = Const.getRootPath() + "/media/";
	}

	public String getThumbnail(){
		if ((getShowData().isEmpty() == true) || 
				(getShowData().containsKey("file_img") == false)){
			return "none.png";
		}
		return getShowData().get("file_img").toString();
	}

	@Override
	public String list() throws Exception {
		if (user() == null) return LOGIN;
		
		setActionURI("list.action");
		this.fieldFormat.fillCategory(getParams(), "cate_movie");
		doList("movie-all");
		return successOrJsonList();
	}
	
	public String json() throws Exception {
		doList("movie-all-ajax");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		if (user() == null) return LOGIN;
		
		doShow("movie-single");
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {
		if (user() == null) return LOGIN;
		
		doShow("movie-single");
//		valid.checkEmptyValue(getShowData(), 0, "vas_low");
//		String sVasLow = getShowData().get("vas_low").toString();
//		String sVasHigh = getShowData().get("vas_high").toString();
//		
//		if ((sVasHigh == null) || (sVasHigh.equals("") == true)){
//			getShowData().put("vas_high", "");
//		}
//		else{
//			getShowData().put("vas_high", sVasLow + "-" + sVasHigh);
//		}
		
		
		return "success";
	}
	
//	@Override
//	public void onAfterConvert(Object sender, Map<String, Object> params) {
//
//	}

//	@Override
//	public void onFileValueFound(Object sender, Map<String, File[]> params) {
//		
//	}

	@Override
	public String write() throws Exception {
		return "success";
	}

	@Override
	public String modify() throws Exception {
		String sVas = "";
		String[] saVas;
		
		try{
			is365plus = getParams().get("cate_movie0").equals("SF");
			movieCategory = fieldFormat.fillCategory(getParams(), "cate_movie");
		}
		catch(NullPointerException ex){
			is365plus = false;
		}
		
		try {
			if (is365plus == true){
				saveFileToAuto(uploadPath, movieCategory, FileNameChangeMode.parentheses);
			}
			else{
				saveFileToAuto(uploadPath, "", FileNameChangeMode.parentheses);
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
//		try{
//			sVas = getParams().get("vas_high").toString();
//			if(sVas.equals("") == true){
//				getParams().put("vas_low", 0);
//				getParams().put("vas_high", 0);
//			}
//			else{
//				saVas = sVas.split("-");
//				getParams().put("vas_low", saVas[0]);
//				getParams().put("vas_high", saVas[1]);
//			}
//		}
//		catch(Exception ex){
//			getParams().put("vas_low", 0);
//			getParams().put("vas_high", 0);
//		}
		
		//valid.checkEmptyValue(getParams(), 0, "vas_high"); // vas_high 값이 없거나 빈 스트링일 경우 0값으로 초기화 추가 - 2013.04.03 by jhson
		valid.checkEmptyValue(getParams(), "", "cate_movie2", "cate_movie3", "vas_high", "file_img", "file_webm", "file_mp4", "file_ogg", "file_mp3", "file_smi");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "cate_sub_loc");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "cate_sub_tool");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "cate_sub_mode");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "cate_sub_part");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "cate_sub_mecha");
		valid.checkEmptyValue(getParams(), "제목없음", "subject");
		
		doEdit("movie-modify");
		return "success";
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	protected String successOrView(){
		if ((getParams().containsKey("view") == true) &&
			(getParams().get("view").equals("") == false)){
			return getParams().get("view").toString();
		}
		
		return successOrJsonShow();
	}
}
