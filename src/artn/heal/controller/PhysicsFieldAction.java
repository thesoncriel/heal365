package artn.heal.controller;

public class PhysicsFieldAction extends AbsHeal365ActionController {

	

	/**
	 * 
	 */
	private static final long serialVersionUID = 5705051898616701225L;

	@Override
	public String list() throws Exception {
		doList("physics-field-all");
		return SUCCESS;
	}

	@Override
	public String show() throws Exception {
		doShow("physics-field-single");
		return successOrJsonShow("id", "field_name", "field_unit");
	}

	@Override
	public String edit() throws Exception {
		list();
		return SUCCESS;
	}

	@Override
	public String write() throws Exception {
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		String[] saNullableKeys = new String[]{
			"id",
			"result0", 
			"result1", "result1min", "result1max",
			"result2", "result2min", "result2max",
			"result3", "result3min", "result3max",
			"result4", "result4min", "result4max",
			"result5", "result5min", "result5max"
		};
		
		valid.checkEmptyValue(getParams(), "", "name", "input_label", "unit", "relation", "result_code");
		valid.checkEmptyValue(getParams(), 0, "input_type");
		valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
		valid.checkEmptyValue(getParams(), null, saNullableKeys);
		
		doEdit("physics-field-modify");
		
		if (getParams().containsKey("ajax") == true){
			setResponse("1");
			return TEXT_RESPONSE;
		}
		
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {

		return SUCCESS;
	}
	
	

}
