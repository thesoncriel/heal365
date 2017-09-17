package artn.heal.controller;

public class Heal365DefaultAction extends AbsHeal365ActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8303587580638559347L;
	
	public String getIdMedi(){
		return MedicalInfo.getInstanceBySession(session()).getIdMedi();
	}
	
	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String show() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String edit() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String write() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String modify() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	public String healMediUser() throws Exception{
		if (user() == null) return LOGIN;
		return SUCCESS;
	}
}
