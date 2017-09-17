package artn.common.interceptor;

import java.util.Map;

import artn.common.manager.AuthManager;
import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthGroupUserInterceptor implements Interceptor {


	/**
	 * 
	 */
	private static final long serialVersionUID = -3903693331419168084L;

	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		Map<String, Object> session = actInvo.getInvocationContext().getSession();
		Map<String, Object> params = actInvo.getInvocationContext().getParameters();
		User user = User.getInstanceFromSession(session);
		String sName = actInvo.getInvocationContext().getName();
		AuthManager auth = null;
		String sIdGroup = "";
		
		try{
			if (actInvo.getInvocationContext().getSession().containsKey("user") == false){
				return "login";
			}
			auth = new AuthManager(user);
			if(sName.equals("list")){
				if(auth.getIsAdmin() == false && params.containsKey("id_group") == false){
					return "error_auth";
				}else if(params.containsKey("id_group")){
					sIdGroup = extractIdGroup(params);
					user.setIdGroup(sIdGroup);
				}
			}
			
		} catch(Exception e){}

		
		return actInvo.invoke();
	}
	
	protected String extractIdGroup(Map<String,Object> params){
		try{
			return ( (String[])params.get("id_group") )[0];
		}catch(Exception e){
			return null;
		}
	}
}

