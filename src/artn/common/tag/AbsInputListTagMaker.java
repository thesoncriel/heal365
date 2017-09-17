package artn.common.tag;

import java.util.List;
import java.util.Map;

public abstract class AbsInputListTagMaker extends AbsInputTagMaker implements
		IListTagMaker {

	protected List<Map<String, Object>> mapList;
	protected String[] sArray;
	protected String listKey = "key";
	
	public AbsInputListTagMaker(){}
	public AbsInputListTagMaker(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
	public AbsInputListTagMaker(String id, String cssClass, String style, String name, String value){
		super(id, cssClass, style, name, value);
	}
	
	@SuppressWarnings("unchecked")
	public IListTagMaker setList(Object list){
		if (list != null){
			if (list instanceof java.lang.String){
				this.sArray = list.toString().split(",");
				this.mapList = null;
			}
			else if (list instanceof java.util.List){
				this.sArray = null;
				this.mapList = (List<Map<String, Object>>)list;
			}
		}
		else{
			this.mapList = null;
			this.sArray = null;
		}
		
		return this;
	}

	public IListTagMaker setList(List<Map<String, Object>> list) {
		this.sArray = null;
		this.mapList = list;
		return this;
	}

	public IListTagMaker setList(String... list){
		this.sArray = list;
		this.mapList = null;
		return this;
	}
	
	public IListTagMaker setListKey(String listKey){
		this.listKey = listKey;
		return this;
	}
}
