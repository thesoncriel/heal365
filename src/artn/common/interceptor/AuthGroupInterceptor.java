package artn.common.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class AuthGroupInterceptor implements Interceptor {


	/**
	 * 
	 */
	private static final long serialVersionUID = -2411013070636136939L;

	@Override
	public void destroy() { }

	@Override
	public void init() { }

	@Override
	public String intercept(ActionInvocation actInvo) throws Exception {
		String sName = actInvo.getInvocationContext().getName();
		
		try{
			if(sName.equals("edit") || sName.equals("modify") || sName.equals("write")){
				if (actInvo.getInvocationContext().getSession().containsKey("user") == false){
					return "login";
				}	
			}
			
		} catch(Exception e){}

		
		return actInvo.invoke();
	}
}

