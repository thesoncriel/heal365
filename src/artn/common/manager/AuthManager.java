package artn.common.manager;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.model.User;

public class AuthManager{
	private final static int SUPER_ADMIN = 0x60000000;
	private final static int SEMI_ADMIN = 0x20000000;
	private final static int USER_INFO_EDITABLE = 0x8000000;
	
	private final static int GROUP_ADMIN = 0xC000000;
	private final static int GROUP_MANAGER_L3 = 0x4000000;
	private final static int GROUP_MANAGER_L2 = 0x2000000;
	private final static int GROUP_MANAGER_L1 = 0x1000000;
	
	private final static int SEMI_STAFF_L4 = 0x800000;
	private final static int SEMI_STAFF_L3 = 0x400000;
	private final static int SEMI_STAFF_L2 = 0x200000;
	
	private final static int GROUP_USER = 0x40000;
	private final static int NORMAL_USER = 0x20000;
	
	private User user = null;
	private int authUser = 0;
	
	public AuthManager(User user){
		this.user = user;
		try{
			authUser = user.getAuthUser();
		}
		catch(NullPointerException ex){
			authUser = 0;
			this.user = new User();
		}
	}
	
	protected User user(){ return user; }
	protected int getAuthUser(){ return authUser; }
	
	public boolean getIsGuest(){
		return authUser == 0;
	}
	
	public boolean getIsAdmin(){
		return (authUser & SEMI_ADMIN) == SEMI_ADMIN;
	}
	
	public boolean getIsSuperAdmin(){
		return (authUser & SUPER_ADMIN) == SUPER_ADMIN;
	}
	
	public boolean getIsUserInfoEditable(){
		return getIsAdmin() || ((authUser & USER_INFO_EDITABLE) == USER_INFO_EDITABLE);
	}
	
	public boolean getIsGroupAdmin(){
		return getIsAdmin() || ((user.getAuthGroup() & GROUP_ADMIN) == GROUP_ADMIN);
	}
	public boolean isGroupAdmin(Object idGroup){
		return getIsAdmin() || ((user.getAuthGroup(idGroup.toString()) & GROUP_ADMIN) == GROUP_ADMIN);
	}
	
	public boolean getIsGroupManagerL3(){
		return getIsAdmin() || (user.getAuthGroup() & GROUP_MANAGER_L3) == GROUP_MANAGER_L3;
	}
	
	public boolean getIsGroupManagerL2(){
		return getIsAdmin() || (user.getAuthGroup() & GROUP_MANAGER_L2) == GROUP_MANAGER_L2;
	}
	
	public boolean getIsGroupManagerL1(){
		return getIsAdmin() || (user.getAuthGroup() & GROUP_MANAGER_L1) == GROUP_MANAGER_L1;
	}
	
	public boolean getIsGroupManager(){
		return getIsAdmin() || (user.getAuthGroup() & (GROUP_MANAGER_L1 | GROUP_MANAGER_L2 | GROUP_MANAGER_L3)) != 0;
	}
	
	public boolean getIsSemiStaffL4(){
		return getIsAdmin() || (user.getAuthGroup() & SEMI_STAFF_L4) == SEMI_STAFF_L4;
	}
	
	public boolean getIsSemiStaffL3(){
		return getIsAdmin() || (user.getAuthGroup() & SEMI_STAFF_L3) == SEMI_STAFF_L3;
	}
	
	public boolean getIsSemiStaffL2(){
		return getIsAdmin() || (user.getAuthGroup() & SEMI_STAFF_L2) == SEMI_STAFF_L2;
	}
	
	public boolean getIsGroupUser(){
		return getIsAdmin() || (user.getAuthGroup() >= GROUP_USER) || ( (user.getAuthGroup() & GROUP_USER) == GROUP_USER);
	}
	
	public boolean isGroupUser(Object idGroup){
		return (user.getAuthGroup(idGroup.toString()) >= GROUP_USER) || ( (user.getAuthGroup(idGroup.toString()) & GROUP_USER) == GROUP_USER);
	}
	
	public boolean getIsHighGroupUser(){
		return getIsAdmin() || (user.getAuthGroup() >= GROUP_USER);
	}

	public boolean getIsSiteUser(){
		return  (authUser & NORMAL_USER) == NORMAL_USER;
	}
	
	public boolean getIsHighSiteUser(){
		return  (authUser >= NORMAL_USER);
	}
	
	public boolean getIsGroupStaff(){
		return (user.getAuthGroup() & 0x7000000) > 0;
	}
	
	public boolean getIsSiteStaff(){
		return getIsAdmin() || (user.getAuthUser() & 0x7000000) > 0;
	}
	public boolean isAuthByName(String name){
		try {
			return (Boolean)this.getClass().getMethod("getIs" + name).invoke(this);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean menu(int place){
		return ( (this.user.getRestrictMenu() >> (place - 1)) & 1  ) > 0;
	}
	public boolean userEdit(int place){
		return ( (this.user.getRestrictUserEdit() >> (place - 1)) & 1  ) > 0;
	}
}
