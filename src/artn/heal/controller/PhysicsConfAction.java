package artn.heal.controller;

import java.util.List;
import java.util.Map;

public class PhysicsConfAction extends AbsHeal365ActionController {


	/**
	 * 
	 */
	private static final long serialVersionUID = -8506508433651702268L;
	private List<Map<String, Object>> fieldList = null;
	
	@Override
	public String list() throws Exception {		
		doList("physics-conf-all"); //TODO: 그룹정보 & 항목정보 조인하여 표현		
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		dbm().open();
		doList("physics-conf-show");
		doShowSub("fieldList", "physics-field-all", "completeConfList", "physics-complete-conf-all");
		dbm().close();
/*		readSubData_FieldList();*/
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {		
		return SUCCESS;
	}
/*	protected void readSubData_FieldList(){
		dbm().open();
		fieldList = dbm().select("medi-check-field-all", getParams());
		dbm().close();
	}
*/
	@Override
	public String modify() throws Exception {
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		doEditSub("physics-conf-modify", "physics-conf-delete", "id_medi_check_field", "id", true);
		return SUCCESS;
	}
	
	public String completeModify() throws Exception {
		doEditSub("physics-complete-conf-modify", "physics-complete-conf-delete", "seq");
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {

		return SUCCESS;
	}
	
	

}
