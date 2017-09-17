package artn.heal.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MediCheckProgressAction extends AbsHeal365ActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4529207977161065086L;

	@Override
	public String list() throws Exception {
		doList("medi-check-progress-all"); //TODO: 그룹정보 & 항목정보 조인하여 표현
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		try{
			List<Map<String, Object>> lmResult = null;
			dbm().open();
			lmResult = dbm().selectNonOpen("medi-check-complete-sing", getParams());
			if(lmResult.size() == 0){
				dbm().close();
				getShowData().put("error", "dataNo");
				return successOrJsonShow();
			}
			getParams().put("id_complete", Integer.parseInt(lmResult.get(0).get("id_complete").toString()));
			doList("medi-check-complete-single");

			String sFieldVal = "";
			String[] saFieldVal;
			int iFieldVal = 0;
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
		catch(Exception ex){
			ex.printStackTrace();
		}
		return"";
	}

	@Override
	public String edit() throws Exception {
		show();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		getShowData().put("id_medi", getIdMedi());
		getShowData().put("id_writer", user().getId());
		getShowData().put("id_writer_last", user().getId());
		getShowData().put("medi_name", getMediName());
		getShowData().put("writer_name", user().getName());
		getShowData().put("writer_last_name", user().getName());
		
		getParams().put("id_medi", getIdMedi());
		
		doList("medi-check-conf-show");
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		List<Map<String,Object>> lmResult = null;
		ArrayList<Integer> liIndex;
		String[] saField;
		valid.checkEmptyValue(getParams(), 0, "id_medi");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		valid.checkEmptyValue(getParams(), user().getId(), "id_user", "id_writer", "id_writer_last");
		valid.checkEmptyValue(getParams(), user().getName(), "user_name", "writer_name", "writer_last_name");
		
		doShow("medi-check-user-gender");
		getParams().put("gender", getShowData().get("gender"));
		
		allCheck();
		if (getArrayParams().containsKey("field_value") == true){
			liIndex = getNotEmptyFieldIndicesByKeyName("field_value");
			
			dbm().open();
			
			lmResult = dbm().selectNonOpen("medi-check-complete-conf-all", getParams());
			for(int iConf = 0; iConf < lmResult.size(); iConf++){
				for(int iParam = 0; iParam < getArrayParams().get("id_medi_check_field").length; iParam++){
					if(lmResult.get(iConf).get("field_id").toString().equals(getArrayParams().get("id_medi_check_field")[iParam].toString())){
						if(getArrayParams().get("field_value")[iParam].equals("")){
							getArrayParams().get("field_value")[iParam] = null;
						}
						saField = lmResult.get(iConf).get("field_column").toString().split("_");
						getParams().put(saField[0]+"_value", getArrayParams().get("field_value")[iParam]);
						getParams().put(saField[0]+"_result", getArrayParams().get("field_result")[iParam]);
					}
				}
			}
			dbm().updateNonCommit("medi-check-complete-modify", getParams());
			getParams().put("id_complete", Integer.parseInt(dbm().selectOne("common-inserted-id", getParams()).get("id").toString()));
			for(Integer index : liIndex){
				mergeParams(index, "id_medi_check_field", 
						"field_name", "field_value", "field_type", "field_unit", 
						"position_group", "position_seq", "field_result");
				mergeParamsWithEmptyDataToNull(
					index, "id");
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
	
	public String complete() throws Exception{
		int iMax = 0;
		List<Map<String, Object>> lmCompleteTarget = null;
		
		dbm().open();
		lmCompleteTarget = dbm().selectNonOpen("medi-check-data-complete-target", getParams());		
		iMax = dbm().selectOneInteger("medi-check-data-getMaxIdComplete", getParams());
		getParams().put("id_complete", iMax);

		for(Map<String, Object> map : lmCompleteTarget){
			getParams().put("id", map.get("id"));
			dbm().updateNonCommit("medi-check-data-complete", getParams());
		}

		copyToComplete(lmCompleteTarget);
		
		dbm().commit();
		dbm().close();
		
		return SUCCESS;
	}
	
	protected void copyToComplete(List<Map<String, Object>> lmCompleteTarget){
		if ((lmCompleteTarget == null) || (lmCompleteTarget.size() == 0)) return;
		
		String sFieldName = "";
		for(Map<String, Object> map : lmCompleteTarget){
			valid.checkEmptyValue(map, "field1_result", "field_column");
			// seq, field_id를 여기서 참조 할 경우 valid 쓸 것... -_-;
			
			sFieldName = map.get("field_column").toString();
			
			if (sFieldName.endsWith("result")){
				getParams().put(sFieldName, map.get("field_result"));
				getParams().put(sFieldName.replace("result", "value"), map.get("field_value"));
			}
			else{
				getParams().put(sFieldName, map.get("field_value"));
				getParams().put(sFieldName.replace("result", "result"), map.get("field_result"));
			}
		}
		
		dbm().updateNonCommit("medi-check-complete-modify", getParams());
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
	
	public boolean getIsLinkedPres(){
		return false;
	}
	
	public boolean getIsCompleted(){
		return false;
	}
	
	protected void allCheck(){
		Map<String, String[]> lmParams = getArrayParams();
		int iLen = lmParams.get("field_value").length;
		Map<String, Object> mParam = null;
		String[] saResult = new String[iLen];
		
		for(int i = 0; i < iLen; i++){
			mParam = util.createMap();
			mParam.put("result_code", lmParams.get("result_code")[i]);
			mParam.put("field_value", lmParams.get("field_value")[i]);
			mParam.put("field_type", lmParams.get("field_type")[i]);
			mParam.put("field_label", lmParams.get("field_label")[i]);
			
			saResult[i] = All_check(mParam);
		}
		
		getArrayParams().put("field_result", saResult);
	}
	
	public String All_check(Map<String, Object> mParam){
		
		String [] saCode = getArrayParams().get("result_code");
		
		String code = mParam.get("result_code").toString();
		String value1 = mParam.get("field_value").toString();
		String value2 = "";
		String gender = getParams().get("gender").toString();
		String sFieldType = mParam.get("field_type").toString();
		String[] saFieldLabel = null;
		
		if (sFieldType.equals("1") == true){
			
			try{
				saFieldLabel = mParam.get("field_label").toString().split(",");
				return saFieldLabel[ Integer.parseInt(value1) - 1];
			}
			catch(Exception ex){
				return "";
			}
		}
		
		if(code.equals("bp1")){
			
			for(int i = 0; i < saCode.length; i++){
				if(saCode[i].equals("bp2") == true){
					value2 = getArrayParams().get("field_value")[i];
					break;
				}
			}
			
			return Blood_Check(value1, value2);
			
		}else if(code.equals("bp2")){
			
			for(int i = 0; i < saCode.length; i++){
				if(saCode[i].equals("bp1") == true){
					value2 = getArrayParams().get("field_value")[i];
					break;
				}
			}
			
			return Blood_Check(value2, value1);
			
		}else if(code.equals("fat")){
			
			return Fat_check(value1);
			
		}
		
		/*else if(code.equals("bp2")){
			
			for(int i = 0; i < saCode.length; i++){
				if(saCode[i].equals("bp1") == true){
					value2 = getArrayParams().get("field_value")[i];
					break;
				}
			}
			
			return Blood_Check(value2, value1);
			
		}*/else if(code.equals("gh")){
			
			for(int i = 0; i < saCode.length; i++){
				if(saCode[i].equals("glu") == true){
					value2 = getArrayParams().get("field_value")[i];
					break;
				}
			}
			
			return HulDang_check(value1,value2);
			
		}else if(code.equals("an")){
			
			return HB_check(gender, value1);
			
		}else if(code.equals("tc")){
			
			return TC_check(value1);
		/*}else if(code.equals("blood")){
			return Pat_check(weight, fatKg);*/
			
		}else if(code.equals("ts")){
			
			return T_Score_check(value1);
		}
		return "";
	}
	
	
	//혈압 비교 값
		public String Blood_Check(String LowhulYap,String HighhulYap){
			String result = "";
			try{
				
			/*	String LowhulYap = "80";
				String HighhulYap = "125";*/
				int LowhulYap_int = Integer.parseInt(LowhulYap);
				int HighhulYap_int = Integer.parseInt(HighhulYap);
				
				if(LowhulYap_int == 80 && HighhulYap_int == 120){
					result = "적정혈압";
					return result;
					
				}else if( (LowhulYap_int >= 80 && LowhulYap_int <= 90) && (HighhulYap_int >= 120 && HighhulYap_int <= 140) ){
					result = "정상혈압";
					return result;
					
				}else if( (LowhulYap_int >= 91 && LowhulYap_int <= 110) && (HighhulYap_int >= 141 && HighhulYap_int <= 180) ){
					result = "경미한 고혈압";
					return result;
					
				}else if( LowhulYap_int >= 111 && HighhulYap_int <= 181){
					result = "중증 고혈압";
					return result;
					
				}else if( (LowhulYap_int <= 80 && HighhulYap_int <= 120) || (LowhulYap_int >= 80 && HighhulYap_int <= 120) || (LowhulYap_int <= 80 && HighhulYap_int >= 120)){
					result = "측정불가";
					return result;
					
				}else{
					result = "측정불가";
					return result;
				}
			}catch(Exception e){
				result="미측정";
				return result;
			}
			
		}
		
		//당화혈색소 비교 값
		public String HulDang_check(String DangHwaHulDang,String HulDang){
			String result = "";
				try{
					int DangHwaHulDang_int = Integer.parseInt(DangHwaHulDang);
					if(!HulDang.equals("")){	
						if( (DangHwaHulDang_int  <= 12 && DangHwaHulDang_int >= 9) || (DangHwaHulDang_int  >= 12) ){
							result = "헙병증의 위험 높음";
							return result;
						}else if(DangHwaHulDang_int  >= 7 && DangHwaHulDang_int  <= 8){
							result = "합병증의 위험 있음";
							return result;
						}else if(DangHwaHulDang_int  <= 6){
							result = "정상범위";
							return result;
						}
					}
					result = "측정불가";
					return result;
				}catch(Exception e){
					result="미측정";
					return result;
				}
			
		}
		
		//헤모글로빈
		public String HB_check(String M_W,String HB){
			
				String result = "";
			try{	
				int HB_int = Integer.parseInt(HB);
				
				if(M_W.equals("m") && HB_int >= 13 && HB_int <= 17){
					result = "정상수치";
					return result;
					
				}else if(M_W.equals("w") && HB_int >= 12 && HB_int <= 16){
					result = "정상수치";
					return result;
					
				}else{
					result = "비정상";
					return result;
				}
			}catch(Exception e){
				result="미측정";
				return result;
			}
		}
			
		//고지혈증
		public String TC_check(String tc){
			String result = "";
			
			try{
				
			
			int tc_int = Integer.parseInt(tc);
			
			if(tc_int <= 200){
				result = "정상범위";
				return result;
				
			}else if(tc_int >= 201 && tc_int <= 240){				
				result = "경계수치";
				return result;
				
			}else if(tc_int >= 241){
				result = "고지혈증";
				return result;
				
			}else{
				result = "측정불가";
				return result;
				
			}
			}catch(Exception e){
				result="미측정";
				return result;
			}
		}
		
		
		
		
		
		//체지방 검사
		public String Pat_check(String weight,String fatKg){
				/*체지방률% = (본인 체지방량kg x 100) ÷ 본인 체중kg*/
						
				/*String height = "170.5";
				float height_float = Float.parseFloat(height);*/
			/*	String weight = "83.7";*/
			String result = "";
			try{	
				
				/*String fatKg = "15.8";*/
				float weight_float = Float.parseFloat(weight);
				float fatKg_float = Float.parseFloat(fatKg);
				
				float fatPersent = (fatKg_float * 100) / weight_float;
				
				float fat_round =  Math.round(fatPersent *10f) / 10f;
				
				if(fat_round <= 17.9){
					result = "표준이하";
					return result;
					
				}else if(fat_round >= 18.0 && fat_round <= 28.0){
					result = "표준";
					return result;
					
				}else if(fat_round >= 28.1){
					result = "표준이상";
					return result;
				}else{
					result = "측정불가";
					return result;
				}
			}catch(Exception e){
				result="미측정";
				return result;
			}
				
		}
		
	//체지방량	
		public String Fat_check(String fat){
			
		String result = "";
		try{	
			
			float weight_float = Float.parseFloat(fat);
			
			float fat_round =  Math.round(weight_float *10f) / 10f;
			
			if(fat_round <= 11.1){
				result = "표준이하";
				return result;
				
			}else if(fat_round >= 11.2 && fat_round <= 17.8){
				result = "표준";
				return result;
				
			}else if(fat_round >= 17.9){
				result = "표준이상";
				return result;
			}else{
				result = "측정불가";
				return result;
			}
		}catch(Exception e){
			result="미측정";
			return result;
		}
			
	}
		
		
		//골다골증
		public String T_Score_check(String T_Score){
			String result = "";
		try{
			float T_Score_f = Float.parseFloat(T_Score);
			
		
			if(T_Score_f >= -1.1){
				result = "정상";
				return result;
				
			}else if(T_Score_f <= -1.1 && T_Score_f >= -2.5){
				result = "골다소증";
				return result;
				
			}else if(T_Score_f <= -2.6){
				result = "골다공증";
				return result;
				
			}else{
				result = "측정불가";
				return result;
				
			}
		}catch(Exception e){
				result="미측정";
				return result;
		}
				

		}
		
		//니코틴
		public String nicotin_check(String nicotin){
			
				String result = "";
				/*String nicotin = "b";*/
			try{
					if(nicotin.equals("1")){
						
						result = "양성";
						return result;
						
					}else if(nicotin.equals("2")){
						
						result = "무효";
						return result;
						
					}else if(nicotin.equals("3")){
						
						result = "음성";
						return result;
						
					}else{
						result = "측정불가";
						return result;
						
					}
			}catch(Exception e){
				result="미측정";
				return result;
			}
			
		}
				
				//요성분
		public String Yo_check(String Yo){
			/*String Yo = "a";*/
			String result = "";
		try{
			if(Yo.equals("1")){
				result = "음성";
				return result;
			}else if(Yo.equals("2")){
				result = "양성";
				return result;
			}else{
				result = "측정불가";
				return result;
			}
		}catch(Exception e){
			result="미측정";
			return result;
		}

		}
							

}
