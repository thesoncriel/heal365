package artn.common.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import artn.common.Const;
import artn.common.IActionController;
import artn.common.manager.AuthManager;
import artn.common.model.User;
import artn.database.IDBManager;
import artn.database.DBManager;

public abstract class AbsActionController extends ActionSupport implements IActionController  {
	/**
	 * 
	 */
	public static final String ERROR_AUTH = "error_auth";
	public static final String MAIN = "main";
	public static final String INDEX = "index";
	public static final String MENU = "menu";
	public static final String JOIN = "join";
	public static final String GOTOBACK = "gotoback";
	public static final String JSONSHOW = "jsonshow";
	public static final String JSONLIST = "jsonlist";
	public static final String TEXT_RESPONSE = "text_response";
	public static final String BEFORE_REQUEST = "before_request";
	
	private static final long serialVersionUID = -4488248587753628803L;
	private IDBManager dbm;
	private Map<String, Object> session;
	private Map<String, Object> mParams;
	protected Map<String, Object> doShowResult;
	protected List<Map<String, Object>> doListResult;
	private int rowCount = 0;
	protected String err = "";
	private String actionURI;
	//private Map<String, String> singleParams = new HashMap<String, String>();
	private Map<String, File[]> fileParams = new HashMap<String, File[]>();
	private Map<String, String[]> arrayParams = new HashMap<String, String[]>();
	protected boolean showIsNull = true;
	private int multiParamArrayLength = 0;
	private boolean converted = false;
	protected AuthManager authMgr;
	private User user;
	private Map<String, String> error = null;

	public Map<String, Object> getModel() {
		mParams = new HashMap<String, Object>();
		return mParams;
	}

	public IDBManager dbm() {
		if (dbm == null){
			try {
				dbm = DBManager.getInstanceFromSession(session());
//				dbm = new DBManager();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return dbm;
	}

	public Map<String, File[]> getFileParams(){
		if (converted == false){
			getParams();
		}
		return fileParams;
	}
	public Map<String, String[]> getArrayParams(){
		if (converted == false){
			getParams();
		}
		return arrayParams;
	}
	
	public Map<String, Object> getParams(){
		if (converted == false){
			this.convertSingleParamAtArray( mParams );
			ActionContext.getContext().getParameters().putAll(mParams);
			mParams = ActionContext.getContext().getParameters();
		}
		return mParams;
	}
	public Map<String, Object> getSession(){
		return session();
	}
	protected Map<String, Object> session(){
		if (session == null){
			session = ActionContext.getContext().getSession();
		}
		return session;
	}
	@SuppressWarnings("unchecked")
	protected Map<String, Object> sessionToMap(String key){
		try{
			return (Map<String, Object>)session.get(key);
		}
		catch(ClassCastException ex){}
		catch(NullPointerException ex){}
		
		return null;
	}
	
	public int getRowCount(){
		return rowCount;
	}
	
	public Map<String, String> getError(){
		if (this.error == null){
			this.error = new HashMap<String, String>();
		}
		return this.error;
	}

	private Map<String, Object> convertSingleParamAtArray(Map<String, Object> params){
		Iterator<Entry<String, Object>> entryIter = params.entrySet().iterator();
		Entry<String, Object> entry = null;
		String sKey = "";
		Object objValue = null;
		String[] saValues = null;
		File[] fileValues = null;
		this.multiParamArrayLength = 0;
		
		fileParams.clear();
		arrayParams.clear();

		while(entryIter.hasNext() == true){
			entry = entryIter.next();
			sKey = entry.getKey();
			objValue = entry.getValue();
			if (objValue instanceof java.lang.String[]){
				saValues = (String[])entry.getValue();
				if (saValues.length > 1){
					arrayParams.put(sKey, saValues);
					if (multiParamArrayLength == 0){
						multiParamArrayLength = saValues.length;
					}
				}
				else{
					params.put(sKey, saValues[0]);
				}
			}
			else if (objValue instanceof java.io.File[]){
				fileValues = ((File[])entry.getValue());
				fileParams.put(sKey, fileValues);
			}
		}
		converted = true;
		
		return params;
	}
	

	public Map<String, Object> getShowData() {
		if (doShowResult == null){
			showIsNull = true;
			doShowResult = new HashMap<String, Object>();
		}
		return doShowResult;
	}


	public List<Map<String, Object>> getListData() {
		return doListResult;
	}
	
	public void setActionURI(String uri){
		this.actionURI = uri;
	}
	public String getActionURI(){
		return actionURI;
	}
	
	public boolean hasFileParams(){
		if(converted == false){
			getParams();
		}
		
		return this.fileParams.size() > 0;
	}
	public boolean hasArrayParams(){
		return this.arrayParams.size() > 0;
	}
	
	public void doList(String queryKey){
		doListResult = dbm().select(queryKey, getParams());
		try{
			rowCount = Integer.parseInt(doListResult.get(0).get(Const.KEY_ROW_COUNT).toString());
		}
		catch(Exception ex){
			err = ex.toString();
			rowCount = 0;
		}
	}
	public void doShow(String queryKey){
		doShow(queryKey, true);
	}
	public void doShow(String queryKey, boolean open){
		if ((getParams().containsKey("id") == true) &&
				(getParams().get("id").equals("") == false)){
			setActionURI("modify.action");
		}
		else{
			setActionURI("write.action");
		}
		if (open == true) dbm().open();
		doShowResult = dbm().selectOneNonOpen(queryKey, getParams());
		if (open == true) dbm().close();
		showIsNull = false;
	}
	
	public void doEdit(String queryKey){
		dbm().open();
		dbm().updateNonCommit(queryKey, getParams());
		dbm().commit();
		dbm().close();
	}
	public void doEdit(String... queryKey){
		dbm().open();
		for(String qryKey: queryKey){
			dbm().updateNonCommit(qryKey, getParams());
		}
		dbm().commit();
		dbm().close();
	}
	
	public void doEdit(String queryKey, boolean doCommit){
		if (doCommit) dbm().open();
		dbm().updateNonCommit(queryKey, getParams());
		if (doCommit){
			dbm().commit();
			dbm().close();
		}
	}


	public boolean getShowIsNull(){
		return showIsNull || (doShowResult == null);
	}
	public boolean getListIsNull(){
		return (this.doListResult == null) || (this.doListResult.size() == 0);
	}
	public boolean getHasLogin(){
		return user() != null;
	}
	
	public int getMultiParamArrayLength(){
		return this.multiParamArrayLength;
	}
	public void setMultiParamArrayLengthByKey(String key){
		try{
			this.multiParamArrayLength = this.arrayParams.get(key).length;
		}
		catch(NullPointerException ex){
			this.err = ex.toString();
			this.multiParamArrayLength = 0;
		}
	}
	
	protected User user(){
		if (user == null){
			try{
				user = (User)session().get("user");
			}
			catch(NullPointerException ex){ }
		}
		return user;
	}

	public AuthManager getAuth(){
		if (authMgr == null){
			authMgr = new AuthManager(user());
		}
		return authMgr;
	}
	
	public boolean isNullParams(String key){
		return getParams().containsKey(key);
	}
		// TODO: 요청 URI 가져오는 로직 구현해야됨. - 2013.08.05 by jhson  
	/*
	public String getSaveRequestURI(){

		return ActionContext.getContext().get( "javax.servlet.forward.request_uri" ).toString() + "____";
		//return ActionContext.getContext().getValueStack().pop().toString();// .findValue( "javax.servlet.forward.request_uri" ).toString() + "ddd";
		//return ActionContext.getContext().getContextMap().get("javax.servlet.forward.request_uri").toString();
		//ActionContext.getContext(). request.getAttribute( "javax.servlet.forward.request_uri" )
	}*/

	public abstract String list() throws Exception;
	public abstract String show() throws Exception;
	public abstract String edit() throws Exception;
	public abstract String write() throws Exception;
	public abstract String modify() throws Exception;
	public abstract String delete() throws Exception;
}
