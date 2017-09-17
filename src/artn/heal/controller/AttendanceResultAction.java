package artn.heal.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import artn.common.controller.DefaultAction;
import artn.common.model.Environment;

public class AttendanceResultAction extends DefaultAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2225609207447676284L;
	
	private InputStream inputStream = null;

	private String fileName;
	
	public String excel() throws Exception {
		try{
			List<Map<String, Object>> lmField = null;
			List<Map<String, Object>> lmData = null;
			String sMonth = String.format("%02d", Integer.parseInt(getParams().get("excelMonth").toString()));
			String sDateUpload = getParams().get("excelYear") +"-"+ sMonth;
			getParams().put("date_upload", sDateUpload);
			dbm().open();
			if(getParams().containsKey("action")){
				if( "medicheck".equals(getParams().get("action").toString())){
					lmField = dbm().selectNonOpen("medi-check-excel-field", getParams());
					lmData = dbm().selectNonOpen("medi-check-excel-data", getParams());
						this.fileName = lmField.get(0).get("medi_name")+"_건강검진_" + sDateUpload + ".xls";	
				}else if("physics".equals(getParams().get("action").toString())){
					lmField = dbm().selectNonOpen("physics-excel-field", getParams());
					lmData = dbm().selectNonOpen("physics-excel-data", getParams());
					this.fileName = lmField.get(0).get("medi_name")+"_물리치료_" + sDateUpload + ".xls";
				}
			}
			dbm().close();
			this.fileName = encFileName(fileName);

			HSSFWorkbook createExcel = new HSSFWorkbook();
			ByteArrayOutputStream baos = null;
			HSSFSheet createSheet = createExcel.createSheet("sheet");
			HSSFRow createRow;
			HSSFCell createCell;
			int iDataSize = lmData.size();
			int iNameSize = lmField.size();//nameMap.size();
			
			int iFieldNameId = 0;	//field 테이블의 id_medi_check_id
			int iDataNameId = 0;	//data 테이블의 id_medi_check_id
			int iRow = 0;
			int iBeforeIdComplete = 0;
			int iAfterIdComplete = 0;
			
			//data가 있을경우만 내용 삽입. 없으면 필드만 생성
			if(iDataSize > 0){
				for (int rowNum = 0; rowNum <= iDataSize; rowNum++) {
					//Row가 0번째가 아닐 경우  
					if(rowNum != 0){
						iAfterIdComplete = Integer.parseInt(lmData.get(rowNum-1).get("id_complete").toString());
						iDataNameId = Integer.parseInt(lmData.get(rowNum-1).get("id_medi_check_field").toString());
						//id_complete가 다를 경우 Row를 변경 해준다.
						if(iBeforeIdComplete == 0 || iBeforeIdComplete != iAfterIdComplete){
							iBeforeIdComplete = iAfterIdComplete;
							iRow++;
						}	
					//Row가 0번째 일 경우 Row 생성
					}else{
						createRow = createSheet.createRow(iRow);
					}
					
					createRow = createSheet.getRow(iRow);
					//Row가 0번 째가 아니고 Row가 존재하지 않을 경우 Row 생성
					if(rowNum != 0 && createRow == null){
						createRow = createSheet.createRow(iRow);
					}
									
					for (int cellNum = 0; cellNum <= iNameSize; cellNum++) {
						//엑셀 필드 생성
						if(rowNum == 0){
							if(cellNum == 0){
								createCell = createRow.createCell(cellNum);
								createCell.setCellValue("환자명");
							}else{
								createCell = createRow.createCell(cellNum);
								createCell.setCellValue(lmField.get(cellNum-1).get("field_name").toString());
							}
							if(cellNum == iNameSize){
								if("physics".equals(getParams().get("action"))){
									createCell = createRow.createCell(cellNum+1);
									createCell.setCellValue("통증부위");
									createCell = createRow.createCell(cellNum+2);
									createCell.setCellValue("작성자");
									createCell = createRow.createCell(cellNum+3);
									createCell.setCellValue("최종 작성자");
									createCell = createRow.createCell(cellNum+4);
									createCell.setCellValue("진단일");
								}else{
									createCell = createRow.createCell(cellNum+1);
									createCell.setCellValue("작성자");
									createCell = createRow.createCell(cellNum+2);
									createCell.setCellValue("최종 작성자");
									createCell = createRow.createCell(cellNum+3);
									createCell.setCellValue("진단일");		
								}
							}
						//엑셀 내용 삽입
						}else{
							if(cellNum == 0){
								createCell = createRow.createCell(0);
								createCell.setCellValue( lmData.get(rowNum-1).get("user_name").toString() );
							}else{
								iFieldNameId = Integer.parseInt(lmField.get(cellNum-1).get("id_medi_check_field").toString());
								createCell = createRow.getCell(cellNum);
								
								if(createCell == null){
									createCell = createRow.createCell(cellNum) ;
									if(iDataNameId == iFieldNameId){
										createCell.setCellValue( lmData.get(rowNum-1).get("field_value").toString()+" "+lmData.get(rowNum-1).get("field_unit").toString() );
									}
								}else if(iDataNameId == iFieldNameId){
									createCell = createRow.getCell(cellNum);
									createCell.setCellValue( lmData.get(rowNum-1).get("field_value").toString()+" "+lmData.get(rowNum-1).get("field_unit").toString() );
								}
								if(cellNum == iNameSize){
									if(createRow.getCell(cellNum+1) == null){
										if("physics".equals(getParams().get("action"))){
											int iPainSite = 0;
											createCell = createRow.createCell(cellNum+1);
											iPainSite = Integer.parseInt(lmData.get(rowNum-1).get("pain_site_check").toString());
											createCell.setCellValue(painSite(iPainSite));
											createCell = createRow.createCell(cellNum+2);
											createCell.setCellValue(lmData.get(rowNum-1).get("writer_name").toString());
											createCell = createRow.createCell(cellNum+3);
											createCell.setCellValue(lmData.get(rowNum-1).get("writer_last_name").toString());
											createCell = createRow.createCell(cellNum+4);
											createCell.setCellValue(lmData.get(rowNum-1).get("date_upload_fmt").toString());
										}else{
											createCell = createRow.createCell(cellNum+1);
											createCell.setCellValue(lmData.get(rowNum-1).get("writer_name").toString());
											createCell = createRow.createCell(cellNum+2);
											createCell.setCellValue(lmData.get(rowNum-1).get("writer_last_name").toString());
											createCell = createRow.createCell(cellNum+3);
											createCell.setCellValue(lmData.get(rowNum-1).get("date_upload_fmt").toString());
										}
									}
								}
							}
						}
					}
					HSSFFormulaEvaluator.evaluateAllFormulaCells(createExcel);
					 for(int i = 0; i <= iNameSize+4; i++){
						 createSheet.autoSizeColumn(i); //cell 크기 자동 맞춤
					  }
					
				}
			}
			
			try {	
				baos = new ByteArrayOutputStream();
				createExcel.write(baos);
				inputStream = new ByteArrayInputStream(baos.toByteArray());
			} catch (Exception e) {
				e.printStackTrace();
				inputStream = null; 
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
			setResponse("0|오류");
			return TEXT_RESPONSE;
		}
		
		return SUCCESS;
	}
	
	public InputStream getInputStream(){
		return inputStream;
	}
	
	public String getFileName(){
		return fileName;
	}
	
	protected String encFileName(String value) throws Exception{
		String sBrowser = Environment.getInstanceBySession(getSession()).getBrowserName();
		
		if (sBrowser.indexOf("IE") >= 0){
			return URLEncoder.encode(value, "UTF-8");
		}
		else{
			return new String(value.getBytes("UTF-8"), "ISO-8859-1");
		}
	}
	
	public String painSite(int iPainSite){
		int iShift = 1;
		String sPainSiteResult = "";
		String saPainStieList[] = {"목(좌)","목(우)","어깨(좌)","어깨(우)","허리"
									,"손목(좌)","손목(우)","발목(좌)","발목(우)","손가락(좌)"
									,"손가락(우)","무릎(좌)","무릎(우)","팔꿈치(좌)","팔꿈치(우)"
									,"허벅지(좌)","허벅지(우)","종아리(좌)","종아리(우)"};
		
		for(String sPainSite : saPainStieList){
			if ((iPainSite & iShift) > 0 ){
				sPainSiteResult = sPainSiteResult + sPainSite + " / ";
			}
			iShift <<= 1;
		}
		return sPainSiteResult;
	}
	/* 엑셀 출력부 기능 추가/변경 - 2014.02.20 by jhson [종료] */
	
}
