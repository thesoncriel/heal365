package artn.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class Util {
	private static Util _util;

	public static Util getInstance(){
		if (_util == null){
			_util = new Util();
		}
		return _util;
	}
	
	protected Util(){}
	
	public Map<String, Object> createMap(){
		return new HashMap<String, Object>();
	}
	
	public String today(){
		return getDateFormat().format(new Date());
	}
	public String getToday(){
		return today();
	}
	public String getNow(){
		return getDateTimeFormat().format(new Date());
	}
	
	protected SimpleDateFormat getDateFormat(){
		return new SimpleDateFormat("yyyy-MM-dd"); 
	}
	protected SimpleDateFormat getDateTimeFormat(){
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	}
	
	public String getIdByNowDateTime(){
		return new SimpleDateFormat("yyyyMMddhhmmss").format(new Date());
	}
	public String formatDate(Date date){
		return getDateFormat().format(date);
	}
	public String addDate(String date, int addVal){
		try{
			SimpleDateFormat datefmt = getDateFormat();
			Date dateFm = datefmt.parse(date);
			Calendar cal = Calendar.getInstance();
			
			cal.setTime(dateFm);
			cal.add(Calendar.DATE, addVal);
			
			return datefmt.format(cal.getTime());
		}catch(Exception ex){}
		
		return "";
	}
	
	public int dateDiff(String fromDate, String toDate){
		try{
			SimpleDateFormat datefmt = getDateFormat();
			Date dateFm = datefmt.parse(fromDate);
			Date dateTo = datefmt.parse(toDate);
			long lDiffDate = dateTo.getTime() - dateFm.getTime();
			
			return (int)(lDiffDate / (24 * 60 * 60 * 1000) );
		}catch(Exception ex){}
		
		return 0;
	}
}
