package artn.common.tag;


public abstract class AbsInputTagMaker extends AbsTagMaker implements IInputTagMaker {
	protected String name;
	protected String value;
	protected int iValue;
	protected boolean required;
	
	public AbsInputTagMaker(){}
	public AbsInputTagMaker(String id, String cssClass, String style){
		super(id, cssClass, style);
	}
	public AbsInputTagMaker(String id, String cssClass, String style, String name, String value){
		super(id, cssClass, style);
		setName(name).setValue(value);
	}
	
	public AbsInputTagMaker setName(String name) {
		this.name = (name != null)? name : this.name;
		return this;
	}

	public AbsInputTagMaker setValue(String value) {
		this.value = (value != null)? value : this.value;
		return this;
	}
	
	public AbsInputTagMaker setValue(Integer value) {
		this.iValue = (value != null)? value : 0;
		return this;
	}
	
	public AbsInputTagMaker setRequired(String required){
		this.required = ((required != null) && (required.equals("required") == true));
		return this;
	}
	
	public AbsInputTagMaker setRequired(boolean required){
		this.required = required;
		return this;
	}
	
//	@Override
//	protected StringBuilder tagStart(String tagName, StringBuilder sb, boolean tagEnd){
//		sb.append('<').append(tagName);
//		
//		if (id != null) 		sb.append(" id=\"").append(id).append("\"");
//		if (cssClass != null) 	sb.append(" class=\"").append(cssClass).append("\"");
//		if (name != null) 		sb.append(" name=\"").append(name).append("\"");
//		if (value != null) 		sb.append(" value=\"").append(value).append("\"");
//		if (style != null) 		sb.append(" style=\"").append(style).append("\"");
//		if (tagEnd == true)		sb.append('>');
//		
//		return sb;
//	}

}
