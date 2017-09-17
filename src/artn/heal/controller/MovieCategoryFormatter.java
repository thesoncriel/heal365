package artn.heal.controller;

import java.util.Map;

import artn.common.FieldFormatter;

public class MovieCategoryFormatter extends FieldFormatter {
	private static MovieCategoryFormatter instance = null;
	
	public static MovieCategoryFormatter getInstance(){
		if (instance == null){
			instance = new MovieCategoryFormatter();
		}
		
		return instance;
	}

	protected MovieCategoryFormatter(){}
	@Override
	public String fillCategory(Map<String, Object> params, String categoryName){
		try {
			StringBuilder sb = new StringBuilder();
			//boolean is365plus = params.get("cate_movie0").toString().equals("SF");
			
			sb.append(convertToUnderbarFormat(params, categoryName + '0', 2));
			
			sb.append(convertToIntFormat(params, categoryName + '1', 2))
			.append(convertToIntFormat(params, categoryName + '2', 1))
			.append(convertToIntFormat(params, categoryName + '3', 4))
			.append(convertToIntFormat(params, "vas_high", 2));
			
//			if (is365plus == true){
//				
//			}
//			else{
//				sb.append(convertToUnderbarFormat(params, categoryName + '1', 2))
//				.append(convertToZeroFormat(params, categoryName + '2', 1))
//				.append(convertToZeroFormat(params, categoryName + '3', 4))
//				.append(convertToZeroFormat(params, "vas_high", 2));
//			}

			params.put(categoryName, sb.toString());
			//params.put("cate_sub", tryParseInt(params, "cate_sub1", 0)); // TODO: 추후 checkbox에 의한 다중 선택 항목이 존재 할 경우 수정 할 것.
			
			return sb.toString();
		} catch (Exception e) {
			params.put(categoryName, "");
			e.printStackTrace();
		}
		
		return null;
	}
}
