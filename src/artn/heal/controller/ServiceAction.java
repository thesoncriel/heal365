package artn.heal.controller;

import java.util.HashMap;
import java.util.Map;

public class ServiceAction extends AbsHeal365ActionController{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 112457915233302391L;
	
	private Map<String, String> insFieldInfo = new HashMap<String, String>(){{	//나눠준 데이터 합치는데 참고
		put("phone", "-");
		put("email", "@");
	}};
	
	@Override
	public String list() throws Exception{
		String saServiceType = "";
		setActionURI("list.action");
		
		if (getParams().containsKey("service_type") == true){
			saServiceType = getParams().get("service_type").toString();
		}
		doList("service-all");
		
		return "success";
	}

	@Override
	public String edit() throws Exception {
//		show();
		return "success";
	}
	
	@Override
	public String show() throws Exception {		//나눠준 데이터 합치는데 참고
		doShow("service-single");

		if (getShowIsNull() == true) return "success";
		int i;
		String sPhone = this.getShowData().get("phone").toString();
		String sEmail = this.getShowData().get("email").toString();
		//String sZipCodeHome = this.getShowData().get("zipcode_home").toString();
		//String sZipCodeCorp = this.getShowData().get("zipcode_corp").toString();
		String[] saPhone = sPhone.split("-");
		String[] saEmail = sEmail.split("@");
		for(i=0; i<2; i++){
			this.getShowData().put("email" + (i+1), saEmail[i]);
			//this.getShowData().put("zipcode_home" + (i+1), saZipCodeHome[i]);
		}
		for(i=0; i<3; i++){
			this.getShowData().put("phone" + (i+1), saPhone[i]);
		}
		
		return "success";
	}

	public boolean getService(){
		boolean bRet = false;
		String[] saServiceType = new String[]{
				"A", "B"
		};
		
		for(String bt : saServiceType){
			bRet = bRet || (getParams().get("service_type").equals(bt) == true);
		}
		
		return bRet;
	}

	// FIXME :
//	@Override
//	public void onMultiValueFound(Object sender, Map<String, String[]> params) { //나눠준 데이터 합치는데 참고
//		String sKey = "";
//		for(Entry<String, String[]> entry : params.entrySet()){
//			sKey = entry.getKey(); // 캐싱
//			appendParamNames(params, sKey, this.insFieldInfo.get(sKey));
//		}
//	}
	
	public void appendParamNames(Map<String, String[]> params, String key, String delimiter){ //나눠준 데이터 합치는데 참고
		StringBuilder sb = new StringBuilder();
		String[] sList = params.get(key);
		
		for(String sItem : sList){
			sb.append(sItem)
			.append(delimiter);
		}
		sb.deleteCharAt(sb.length() - 1);
		
		getParams().put(key, sb.toString());
	}
		
	@Override
	public String write() throws Exception {
		return SUCCESS;
	}
	@Override
	public String modify() throws Exception {
		doEdit("service-modify");
		return SUCCESS;
	}
	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}