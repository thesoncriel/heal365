package artn.common.manager;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.swing.text.View;

import artn.common.Property;
import artn.common.model.Environment;
import artn.common.model.User;
import artn.common.model.Visitor;
import artn.database.DBManager;

public class LoginManager implements HttpSessionBindingListener {
//	private HttpSession session;
	private static LoginManager loginManager = null;
	private Map<String, User> loginUser = new Hashtable<String, User>();
	private Map<String, Map<String, Object>> usingList = new HashMap<String, Map<String, Object>>();
	
	private DBManager dbm = null;
	
	public static synchronized LoginManager getInstance(){
		if (loginManager == null){
			loginManager = new LoginManager();
		}
		return loginManager;
	}
	
	protected LoginManager(){
		super();
		try {
			dbm = new DBManager();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}

	
	public String login(Map<String, Object> params, Map<String, Object> session){
		Map<String, Object> mUser;
		List<Map<String, Object>> lmAuthGroup = null;
		Map<String, Object> sessionOther;
		User user;
		DBManager dbm = null;
		
		if ((session.containsKey("visitor") == false) || (session.containsKey("environment") == false)){
			return "죄송합니다. 다시한번 로그인 하여 주십시요.";
		}
		
		try {
			dbm = DBManager.getInstanceFromSession(session);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		dbm.open();
		
		try{
			mUser = dbm.selectOneNonOpen("user-single", params);
		}
		catch(Exception ex){
			dbm.close();
			return "서버 오류 입니다. 로그인을 다시 수행 하시길 바랍니다."; 
		}
		
		if ((mUser == null) || (mUser.size() == 0)){
			dbm.close();
			return "아이디가 존재하지 않습니다.";
		}
		else if (mUser.get("pw").equals(params.get("pw")) == false){
			dbm.close();
			return "비밀번호가 일치하지 않습니다.";
		}
		
		params.put("id_user", mUser.get("id"));
		try{
			lmAuthGroup = dbm.selectNonOpen("group-user-all", params);
		}catch(Exception e){}
		
		dbm.close();
		
		user = new User( mUser );
		if(lmAuthGroup != null){
			user.putAuthGroup( lmAuthGroup );
		}
		session.put( "user",  user);
		loginUser.put( session.get("sessionId").toString(), user);		
		
		try{
			if (Property.getInstance().getBoolean("artn.user.multiLogin") == false){
				if (isUsing(user.getId()) == true){
					sessionOther = usingList.get(user.getId());
					sessionOther.remove("user");
				}
			}
		}
		catch(Exception ex){}
		
		usingList.put(user.getId(), session);
		
		Visitor visitor = (Visitor)session.get("visitor");
		Environment environment = (Environment)session.get("environment");
		visitor.setIdUser(user.getId());
		visitor.doInsert(dbm);
		
		return "";
	}
	
	public boolean isUsing(String id){
		return usingList.containsKey(id);			
	}	
	
	public void logout(Map<String, Object> session){
		try{
			String sMedifitTaSession = "";
			loginUser.remove(session.get("sessionId").toString());
			usingList.remove( ((User)session.get("user")).getId() );
			session.remove("user");
			if(session.containsKey("medifit_ta")){
				sMedifitTaSession = session.get("medifit_ta").toString();
			}
			session.clear();
			if("".equals(sMedifitTaSession) == false){
				session.put("medifit_ta",sMedifitTaSession);
			}
		}
		catch(NullPointerException ex){}
	}
		
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSession session = event.getSession();
		//System.out.println(session.getId());
		session.setAttribute("sessionId", session.getId());
		
		try{
			loginUser.remove(session.getId());
		}
		catch(Exception ex){}
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		User user = null;
		
		try{
			user = (User)event.getSession().getAttribute("user");
		}
		catch(Exception ex){}
		
		if (user != null){
			loginUser.remove(event.getSession().getId());
		}
	}
	
	public int getUserCount() {
		return loginUser.size();
	}

}
