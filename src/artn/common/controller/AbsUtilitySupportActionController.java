package artn.common.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import artn.common.Const;
import artn.common.JSON;
import artn.common.Property;
import artn.common.Util;
import artn.common.Validator;

public abstract class AbsUtilitySupportActionController extends AbsActionController {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8221988525151833202L;

	protected String contents = null;
	private String responseText = "";
	private String[] keyArray = null;
	
	protected Util util = Util.getInstance();
	protected Validator valid = Validator.getInstance();
	protected Property prop = Property.getInstance();
	
	protected String successOrJsonList(){ return (getParams().containsKey("json"))? JSONLIST : SUCCESS; }
	protected String successOrJsonShow(){ return (getParams().containsKey("json"))? JSONSHOW : SUCCESS; }
	protected String successOrJsonList(String... keys){ keyArray = keys; return successOrJsonList(); }
	protected String successOrJsonShow(String... keys){ keyArray = keys; return successOrJsonShow(); }
	protected String successOrLogin(){ return returnBeforeCheckLogin(SUCCESS); }
	protected String successOrAuth(String authName){ return returnBeforeCheckAuth(SUCCESS, authName); }
	protected String returnBeforeCheckLogin(String retStr){ return (user() != null)? retStr : LOGIN; }
	protected String returnBeforeCheckAuth(String retStr, String authName){
		return (getAuth().isAuthByName(authName) == true)? retStr : ERROR_AUTH; 
	}
	
	public Util getUtil(){
		return util;
	}
		
	public String getJsonList(){
		if (keyArray != null){
			return JSON.encode(new StringBuilder(), getListData(), keyArray).toString();
		}
		else{
			return JSON.encode(getListData(), getParams().get("keys")).toString();
		}
	}
	public String getJsonShow(){
		if (keyArray != null){
			return JSON.encode(new StringBuilder(), getShowData(), keyArray).toString();
		}
		else{
			return JSON.encode(getShowData(), getParams().get("keys")).toString();
		}
	}
	
	public InputStream getJsonShowStream(){
		try {
			return new ByteArrayInputStream( getJsonShow().getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	public InputStream getJsonListStream(){
		try {
			return new ByteArrayInputStream( getJsonList().getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}

	public int getPage(){
		Map<String, Object> mapParams = getParams();
		if ((mapParams.containsKey(Const.KEY_PAGE) == true)){
			return Integer.parseInt(mapParams.get(Const.KEY_PAGE).toString());
		}
		return 1;
	}
	// FIXME: 다양한 컨텐츠 코드로 변환할 수 있게 변경 할 것 - 2013.09.06 by jhson
	public String getContentsCode(){
		if (contents == null){
			if (getParams().containsKey("contents") == true){
				contents = getParams().get("contents").toString();
				if (contents.equals("") == false){
					return contents;
				}
					
			}
			contents = Const.CONTENTS_NORMAL;
		}
		return contents;
	}
	
	public InputStream getResponseStream(){
		try {
			return new ByteArrayInputStream( responseText.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public void setResponse(String text){
		this.responseText = text;
	}
	public String getResponse(){
		return this.responseText;
	}
	
	public void InsertQueryKey(String listKey, String subKey){
		List<Map<String, Object>> listParam;
		List<Map<String, Object>> subParam;
		
		dbm().open();
			listParam =	dbm().selectNonOpen(listKey, util.createMap());
			session().put("listParam", listParam);
		if(subKey != null || subKey != ""){
			subParam = dbm().selectNonOpen(subKey, util.createMap());
			session().put("subParam", subParam);
		}
		dbm().close();
	}
	
	public ByteArrayInputStream makeExcel(List<Map<String, Object>> data, String... keys) {
		ArrayList<String> lsKeys = new ArrayList<>();
		
		Collections.addAll(lsKeys, keys);
		
		return makeExcel(data, lsKeys);
	}
	
	public ByteArrayInputStream makeExcel(List<Map<String, Object>> data, List<String> keys) {
		HSSFWorkbook createExcel = new HSSFWorkbook();
		ByteArrayOutputStream baos = null;
		
		HSSFSheet createSheet = createExcel.createSheet("sheet");
		HSSFCell createCellname;
		HSSFRow createRow;
		HSSFCell createCell;
		//String sKey = "";
		
		Map<String, Object> nameMap =  data.get(0);
		Map<String, Object> createCellMap;
		HSSFRow createRowName = createSheet.createRow(0);
		
		
		int iDataSize = data.size();
		int iNameSize = keys.size();//nameMap.size();
		int nameCellNum = 0;
		
		String[] createKeyset = new String[ iNameSize ];
		
		for(String sKey : keys){
			createCellname = createRowName.createCell(nameCellNum);
			createCellname.setCellValue( sKey );
			createKeyset[nameCellNum] = sKey;
			nameCellNum++;
		}

		for (int rowNum = 1; rowNum <= iDataSize; rowNum++) {
			createRow = createSheet.createRow(rowNum);
			createCellMap = data.get(rowNum - 1);

			for (int cellNum = 0; cellNum < iNameSize; cellNum++) {
				createCell = createRow.createCell(cellNum);
				if(createCellMap.get(createKeyset[cellNum]) == null){
					createCell.setCellValue("");
				}else{
					createCell.setCellValue( createCellMap.get(createKeyset[cellNum]).toString() );
				}
			}
		}
		try {	
			baos = new ByteArrayOutputStream();
			createExcel.write(baos);

			return new ByteArrayInputStream(baos.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
			return null; 
		}
	}
	
	public ByteArrayInputStream makeExcel(List<Map<String, Object>>... Data) {
		
		HSSFWorkbook createExcel = new HSSFWorkbook();
		ByteArrayOutputStream baos = null;
		
		for(int i =0 ; i < Data.length ; i++){
			HSSFSheet createSheet = createExcel.createSheet("sheet"+(i+1));
			HSSFCell createCellname;
			HSSFRow createRow;
			HSSFCell createCell;
			String sKey = "";
			
			Map<String, Object> nameMap =  Data[i].get(0);
			Map<String, Object> createCellMap;
			HSSFRow createRowName = createSheet.createRow(0);
			Iterator<String> iterKeys = nameMap.keySet().iterator();
			
			int iDataSize = Data[i].size();
			int iNameSize = nameMap.size();
			int nameCellNum = 0;
			
			String[] createKeyset = new String[ iNameSize ];
			
	
			while (iterKeys.hasNext()) {
				sKey = iterKeys.next();
	
				createCellname = createRowName.createCell(nameCellNum);
				createCellname.setCellValue( sKey );
				createKeyset[nameCellNum] = sKey;
				nameCellNum++;
			}
			for (int rowNum = 1; rowNum <= iDataSize; rowNum++) {
				createRow = createSheet.createRow(rowNum);
				createCellMap = Data[i].get(rowNum - 1);
	
				for (int cellNum = 0; cellNum < iNameSize; cellNum++) {
					createCell = createRow.createCell(cellNum);
					createCell.setCellValue( createCellMap.get(createKeyset[cellNum]).toString() );
				}
			}
		}
		try {	
			baos = new ByteArrayOutputStream();
			createExcel.write(baos);

			return new ByteArrayInputStream(baos.toByteArray());
		} catch (Exception e) {
			e.printStackTrace();
			return null; 
		}
	}
}
