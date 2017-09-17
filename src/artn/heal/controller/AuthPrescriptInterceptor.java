package artn.heal.controller;

import java.util.Map;

import artn.common.model.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthPrescriptInterceptor implements Interceptor {


	/**
	 * 
	 */
	private static final long serialVersionUID = 5290898130758798255L;

	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		Map<String, Object> session = actInvo.getInvocationContext().getSession();
		User user = (User)session.get("user");
		String sName = actInvo.getInvocationContext().getName();
		Heal365AuthManager auth = new Heal365AuthManager(user);
		MedicalInfo medicalInfo = null;
		
		if (user == null) return "login";
		
		medicalInfo = MedicalInfo.getInstanceBySession(session);
		user.setIdGroup(medicalInfo.getIdMedi());
		
		if (auth.getIsAdmin() == false){
			if (sName.equals("list") == true){
				return "error_auth";
			}
			else if ((sName.equals("listm") == true) && (auth.getIsDoctor() == false) && (auth.getIsTherap() == false) && (auth.getIsNurse() == false)) {
				return "error_auth";
			}
			else if ((sName.equals("write") == true) && (auth.getIsDoctor() == false) && (auth.getIsTherap() == false)){
				return "error_auth";
			}
			else if ((sName.equals("delete") == true) && (auth.getIsDoctor() == false) && (auth.getIsTherap() == false)){
				return "error_auth";
			}
			else if ((sName.equals("modify") == true) && (auth.getIsDoctor() == false) && (auth.getIsTherap() == false)) {
				return "error_auth";
			}
		}
		
		return actInvo.invoke();
	}

}
