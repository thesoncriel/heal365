package artn.heal.controller;

import java.io.IOException;
import java.util.Map;

import artn.common.ILogger;
import artn.common.model.User;
import artn.database.DBManager;
import artn.database.IDBManager;

public class LogManager implements ILogger {
	
	private static ILogger logMgr;
	
	public static ILogger getInstance(){
		if (logMgr == null){
			logMgr = new LogManager();
		}
		return logMgr;
	}
	protected LogManager(){}
	
	public void write(User user, String msg, int logType) throws Exception{
		Map<String, Object> mUser = user.toMap();
		
		if (msg != null){
			mUser.put("log_type", logType);
			mUser.put("msg", msg);
		}
		else{
			mUser.put("log_type", logType);
			mUser.put("msg", convertToMessage(logType));
		}
		insertLog(mUser);
	}
	
	// FIXME: 사용자가 많아져 로그 할 것이 많아지면 시스템 오버헤드가 일어날 수 있음. 텍스트 파일로 뺐다가 사용자가 세션에서 제거되면 DB에 기록하는 방법으로 할 것.
	protected void insertLog(Map<String, Object> map) throws IOException{
		new DBManager().insert("common-log", map);
	}

	// TODO: 필요 시 추가 할 것.
	public String convertToMessage(int logType){
		
		switch(logType){
			case 0: return "";
			case 1: return "로그인을 하였습니다.";
			case 2: return "로그아웃을 하였습니다.";
			case 3: return "개인정보를 수정 하였습니다.";
			default: return "";
		}
	}
}
