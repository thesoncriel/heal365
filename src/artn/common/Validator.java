package artn.common;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validator {
	private static Validator field = null;
	private static final String SIMPLE_XSS_REGEX = "(?i)(.)*(<(/)?(script|xmp|iframe|body|object|applet|embed|form))(/)?(.)*>?(.)*";
	private static final Pattern[] XSS_PATTERNS = new Pattern[] {
		Pattern.compile(SIMPLE_XSS_REGEX),
		// Script fragments
		Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
		// src='...'
		Pattern.compile(SIMPLE_XSS_REGEX + "(.*?)src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile(SIMPLE_XSS_REGEX + "(.*?)src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// lonely script tags
		Pattern.compile("</script>", Pattern.CASE_INSENSITIVE),
		Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// eval(...)
		Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// alert(...)
		Pattern.compile("alert\\((.*?)\\)\\;", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("alert\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// expression(...)
		Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		// javascript:...
		Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
		// vbscript:...
		Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
			
			// onload(...)=...
		Pattern.compile("onload(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),		
		Pattern.compile("onmousewheel(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onclick(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onkeydown(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onkeypress(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onchange(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("ondblclick(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onkeyup(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onsubmit(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onblur(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("refresh(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onfocus(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onerror(.*?)=", 		Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("onmouseover(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
		Pattern.compile("style(.*?)=", 	Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
	};
	
	public static Validator getInstance(){
		if (field == null){
			field = new Validator();
		}
		return field;
	}
	
	protected Validator(){}
	
	public Map<String, Object> splitAndPutToMap(Map<String, Object> data, String key, String delimiter){
		return splitAndPutToMap(data, key, delimiter, 0);
	}
	public Map<String, Object> splitAndPutToMap(Map<String, Object> data, String key, String delimiter, int numLimit){
		try{
			String[] saValue = data.get(key).toString().split(delimiter);
			int inc = 0;
			
			if ((numLimit > 0) && (saValue.length != numLimit)){
				while(inc < numLimit){
					++inc;
					data.put(key + inc, "");
				}
				return data;
			}
			for(String sValue : saValue){
				++inc;
				data.put(key + inc, sValue);
			}
		}
		catch(NullPointerException ex){}
		
		return data;
	}
	
	public Map<String, Object> insertNowToMap(Map<String, Object> data, String key){
		data.put(key, Util.getInstance().getNow());
		return data;
	}
	
	public Map<String, Object> appendAndPutToMap(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, String delimiter){
		try{
			StringBuilder sb = new StringBuilder();
			String[] sList = dataSrc.get(key);
			
			for(String sItem : sList){
				sb.append(sItem)
				.append(delimiter);
			}
			sb.deleteCharAt(sb.length() - 1);
			
			dataDest.put(key, sb.toString());
		}
		catch(NullPointerException ex){
			dataDest.put(key, "");
		}
		
		return dataDest;
	}
	
	public void checkEmptyValue(Map<String, Object> params, Object defValue, String... keywords){
		boolean isNumericField = (defValue instanceof Integer) || (defValue instanceof Double);
		String sValue = null;
		
		if (isNumericField == false){
//			if (defValue == null){
//				for(String key : keywords){
//					if ((params.containsKey(key) == false) ||
//							(params.get(key).equals("") == true)){
//						params.remove(key);
//					}
//				}
//			}
//			else{
				for(String key : keywords){
					if ((params.containsKey(key) == false) ||
							(params.get(key).equals("") == true)){
						params.put(key, defValue);
					}
				}
//			}
		}
		else{
			for(String key : keywords){
				if (params.containsKey(key) == true){
					if ( (sValue = params.get(key).toString() ).equals("") == true ){
						params.put(key, defValue);
					}
					else if (sValue.length() > 1){
						if (sValue.startsWith(".") == true){
							params.put(key, '0' + sValue);
						}
						else if (sValue.endsWith(".") == true){
							params.put(key, sValue + '0');
						}
					}
				}
				else{
					params.put(key, defValue);
				}
			}
		}
	}
	public void checkEmptyValue(Map<String, Object> params, Object defValue, String key){
		if ((params.containsKey(key) == false) ||
				(params.get(key).equals("") == true)){
			params.put(key, defValue);
		}
	}
	

	public void checkEmptyValues(Map<String, String[]> arrayParams, String defValue, String keyword, String lengthCriteriaKey){
		try{
			int iLen = arrayParams.get(lengthCriteriaKey).length;
			String[] saValues = arrayParams.get(keyword);
			String[] saTemp;
			int i = 0;
			
			if (saValues.length < iLen){
				saTemp = saValues;
				saValues = new String[iLen];
				
				for(; i < saTemp.length; i++){
					if ((saTemp[i] == null) || (saTemp[i].equals("") == true)){
						saValues[i] = defValue;
					}
					else{
						saValues[i] = saTemp[i];
					}
				}
			}
			
			for(; i < iLen; i++){
				if ((saValues[i] == null) || (saValues[i].equals("") == true)){
					saValues[i] = defValue;
				}
			}
		}
		catch(Exception ex){
			arrayParams.remove(keyword);
		}
	}
	
	public void checkFileExists(Map<String, Object> params, String key){
		String sFileExists = "";
		Object oFileName = params.get(key);
		
		if ( (oFileName instanceof java.lang.String != false) &&
			 (params.containsKey(key) == false) &&
			 (params.containsKey(key + "FileName") == false) && 
			 (params.containsKey(sFileExists = key + "_exists") == true) &&
			 (params.get(sFileExists).equals("") == false) ){
			params.put(key, params.get(sFileExists).toString());
		}
	}
	
	public void checkFileExists(Map<String, Object> params, String... keywords){
		String sFileExists = "";
		Object oFileName = null;
		
		for(String key : keywords){
			oFileName = params.get(key);
			
			if ( (oFileName instanceof java.lang.String != false) &&
				 (params.containsKey(key) == false) &&
				 (params.containsKey(key + "FileName") == false) && 
				 (params.containsKey(sFileExists = key + "_exists") == true) &&
				 (params.get(sFileExists).equals("") == false) ){
				params.put(key, params.get(sFileExists).toString());
			}
		}
	}
	
	public void checkFileArrayAdjusting(Map<String, Object> params, Map<String, String[]> arrayParams, Map<String, File[]> fileParams, String fileKey, String... followKeys ){
		String[] saFileExists;
		String sFileExistsKey, sValue;
		Map<String, String[]> msaFollowData = new HashMap<String, String[]>();
		int iNewIdx = 0, iOldIndex = 0, iLenFile, iLenExists;
		
		
		if (fileParams.containsKey(fileKey) == true){
			sFileExistsKey = fileKey + "_exists";
			iLenFile = fileParams.get(fileKey).length;
			
			// 배열 파라메터로 만들기 위해 맵에 스트링 배열 생성
			for(String sFollowKey : followKeys){
				msaFollowData.put(sFollowKey, new String[iLenFile]);
			}
						
			if ((arrayParams.containsKey(sFileExistsKey) == true)){
				saFileExists = arrayParams.get(sFileExistsKey);
				iLenExists = saFileExists.length;
				
				for(int i = 0; i < iLenExists; i++){
					if (saFileExists[i].equals("") == true){
						for(String sFollowKey : followKeys){
							sValue = arrayParams.get(sFollowKey)[i];
							
							if (sValue.equals("") == true){
								msaFollowData.get(sFollowKey)[iNewIdx] = null;
							}
							else{
								msaFollowData.get(sFollowKey)[iNewIdx] = sValue;
							}
						}
						iNewIdx++;
					}
				}
			}
			else{
				String sFileExists = params.get(sFileExistsKey).toString();
				
				if (sFileExists.equals("") == true){
					for(String sFollowKey : followKeys){
						if (params.get(sFollowKey) == null){
							msaFollowData.remove(sFollowKey);
						}
						else{
							msaFollowData.get(sFollowKey)[0] = params.get(sFollowKey).toString();
						}
					}
				}
			}
		}
		
		arrayParams.putAll(msaFollowData);
	}
	
	public int mergeIntValuesToMap(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		String[] saValue = dataSrc.get(key);
		int iSum = 0;
		
		if (saValue != null){
			for(String sVal : saValue){
				iSum = iSum | Integer.parseInt(sVal);
			}
		}
		else if (dataDest.containsKey(key) == true){
			iSum = Integer.parseInt(dataDest.get(key).toString());
		}
		
		dataDest.put(key, iSum);
		
		return iSum;
	}
	
	public List<Integer> convertToCheckboxListValues(int value){
		return convertToCheckboxListValues(value, 31);
	}
	
	public List<Integer> convertToCheckboxListValues(int value, int size){
		List<Integer> list = new ArrayList<Integer>();
		int iShift = 1;
		
		for(int i = 1; i <= size; i++){
			if ((value & iShift) > 0){
				list.add(i);
			}
			iShift <<= 1;
		}
		
		return list;
	}
	
	public void replaceCRLFToBRTags(Map<String, Object> dataDest, String key){
		String sContent = " ";
		
		try{
			sContent = dataDest.get(key).toString();
		}
		catch(NullPointerException ex){
			dataDest.put(key, sContent);
			return;
		}
		
		if (sContent.contains("<br") == false){
			dataDest.put(key, sContent.replaceAll("\r\n", "<br/>"));
		}
	}
	
	public void replaceBRTagsToCRLF(Map<String, Object> dataDest, String key){
		String sContent = "";
		
		try{
			sContent = dataDest.get(key).toString();
		}
		catch(NullPointerException ex){}
		
		dataDest.put(key, sContent.replaceAll("<br(/)>", "\r\n"));
	}
	
	public void trim(Map<String, Object> data, String... keys){
		for(String sKey : keys){
			if (data.containsKey(sKey) == true) data.put(sKey, data.get(sKey).toString().trim());
		}
	}
	
	public void appendParamValueByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, int decPlace){
		String[] saValue = dataSrc.get(key);
		StringBuilder sb = new StringBuilder();
		
		if (saValue != null){
			for(String sValue : saValue){
				sb.append( String.format("%0" + decPlace + "d", Integer.parseInt(sValue)) );
			}
			dataDest.put(key, sb.toString());
		}
		else{
			dataDest.put(key, "");
		}
	}
	public void mergeValueToOtherKey(Map<String, Object> dataDest, int srcVal, String destkey, int useLength, int shift){
		int iSum = 0;
		int iShift = 0;
		int iMax = useLength * shift;
		
		for(iShift = 0; iShift < iMax; iShift += shift){
			iSum |= srcVal << iShift;
		}
		
		dataDest.put(destkey, iSum);
	}
	public void mergeMultiValuesByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		mergeMultiValuesByKey(dataDest, dataSrc, key, 0, 0);
	}
	public void mergeMultiValuesByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, int shift){
		mergeMultiValuesByKey(dataDest, dataSrc, key, 0, shift);
	}
	public void mergeMultiValuesByKey(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key, int useLength, int shift){
		Map<String, String[]> params = dataSrc;
		
		if (params.containsKey(key) == false) return;
		
		String[] saValue = params.get(key);
		int iLen = (useLength > 0)? useLength : saValue.length;
		int iSum = 0;
		
		for(int i = 0; i < iLen; ++i){
			iSum |= Integer.parseInt(saValue[i]) << (shift * i);
		}
		
		dataDest.put(key, iSum);
	}
	
	public void removeTags(Map<String, Object> data, String keyFrom, String keyTo){
		String sValue = data.get(keyFrom).toString();
		
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>"); 
	    Matcher m = p.matcher(sValue); 
	    sValue = m.replaceAll("");		 
		
		data.put(keyTo, sValue);
	}
	
	public void removeTags(Map<String, Object> data, String keyFrom, String keyTo, int lengthLimit){
		String sValue = data.get(keyFrom).toString();
		
		Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>"); 
	    Matcher m = p.matcher(sValue); 
	    sValue = m.replaceAll("").substring(0, lengthLimit);	 
		
		data.put(keyTo, sValue);
	}
	
	public void extractFirstImgSrc(Map<String, Object> data, String keyFrom, String keyTo){
		try{
			String sValue = data.get(keyFrom).toString();
			int indexImgBegin = sValue.indexOf("<img");
			//int indexImgEnd = sValue.indexOf(">", indexImgBegin);
			int indexSrcBegin = 0, indexSrcEnd = 0;
			
			if (indexImgBegin < 0){
				data.put(keyTo, "");
				return;
			}
			
			//sValue = sValue.substring(indexImgBegin, indexImgEnd);
			indexSrcBegin = sValue.indexOf("src=", indexImgBegin) + 5;
			indexSrcEnd = sValue.indexOf("\"", indexSrcBegin);
			
			sValue = sValue.substring(indexSrcBegin, indexSrcEnd).replace("&amp;", "&");
			data.put(keyTo, sValue);
		}
		catch(Exception ex){
			data.put(keyTo, "");
		}
	}
	
	public String toEmail(Map<String, String[]> data, String key){
		String[] saEmail = data.get(key);
		
		try{
			if (saEmail.length < 2){
				return "";
			}
			
			return saEmail[0] + '@' + saEmail[1];
		}
		catch(Exception ex){}
		return "";
	}
	public String toEmail(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		String sEmail = toEmail(dataSrc, key);
		dataDest.put(key, sEmail);
		return sEmail;
	}
	
	public String toPhone(Map<String, String[]> data, String key){
		String[] saPhone = data.get(key);
		
		try{
			switch(saPhone.length){
				case 2: return saPhone[0] + '-' + saPhone[1];
				case 3: return saPhone[0] + '-' + saPhone[1] + '-' + saPhone[2];
				case 4: return saPhone[0] + '-' + saPhone[1] + '-' + saPhone[2] + '-' + saPhone[3];
				default : return "";
			}
		}
		catch(Exception ex){}
		return "";
	}
	public String toPhone(Map<String, Object> dataDest, Map<String, String[]> dataSrc, String key){
		String sPhone = toPhone(dataSrc, key);
		dataDest.put(key, sPhone);
		return sPhone;
	}
	
	public void surveyToOne(Map<String, Object> dataDest, String key){
		int i = 0;
		int iSum = 0;
		String sName = "";
		
		while(dataDest.containsKey(sName = key + i) == true){
			iSum |= Integer.parseInt( dataDest.get( sName ).toString() );
			i++;
		}
		
		dataDest.put(key, iSum);
	}
	
	public void surveyToOne(Map<String, Object> dataDest, String key, int maxCount){
		int i = 0;
		int iSum = 0;
		String sName = "";
		
		while(i < maxCount){
			if (dataDest.containsKey(sName = key + i) == true){
				iSum |= Integer.parseInt( dataDest.get( sName ).toString() );
			}
			
			i++;
		}
		
		dataDest.put(key, iSum);
	}
	
	public void removeMaliciousCode(Map<String, Object> params, String... keywords) {
		Matcher matcher = null;
		String sContents = "";
		for(String key : keywords){
			if (params.containsKey(key) == true){
				sContents = params.get(key).toString();
				
				for (Pattern pattern : XSS_PATTERNS) {
					matcher = pattern.matcher(sContents);
					sContents = matcher.replaceAll("");
				}
				
				params.put(key, sContents);
			} else {
				params.put(key, sContents);
			}
		}
    }
}
