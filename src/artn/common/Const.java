package artn.common;

import java.io.IOException;

import org.apache.ibatis.io.Resources;

public final class Const {
	public static final String KEY_ROW_COUNT = "row_count";
	public static final String KEY_ROW_NUMBER = "row_number";
	public static final String KEY_ROW_NUMBER_ASCENDING = "rnum_asc";
	public static final String KEY_PAGE = "page";
	public static final String KEY_ROW_LIMIT = "rowlimit";
	public static final String KEY_OFFSET = "offset";
	public static final String PATH_CONFIG = "artn/common/common.properties";
	public static final String CONTENTS_NORMAL = "sub100";
	
	private static String rootPath;
	
	public static String getRootPath(){ return rootPath; }
	
	static {
		try {
			rootPath = Resources.getResourceAsFile(Const.PATH_CONFIG)
					.getParentFile() // common
					.getParentFile() // artn
					.getParentFile() // classes
					.getParentFile() // WEB-INF
					.getParentFile() // ROOT
					.getCanonicalPath().toString().replace("%20", " ");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
