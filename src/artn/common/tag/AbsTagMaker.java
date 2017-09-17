package artn.common.tag;


public abstract class AbsTagMaker implements ITagMaker {
	
	protected String cssClass;
	protected String id;
	protected String style;
	protected String title;
	
	public AbsTagMaker(){}
	public AbsTagMaker(String id, String cssClass, String style){
		setId(id).setCssClass(cssClass).setStyle(style);
	}
	
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? cssClass : this.cssClass;
		return this;
	}

	public ITagMaker setId(String id) {
		this.id = (id != null)? id : this.id;
		return this;
	}

	public ITagMaker setStyle(String style) {
		this.style = (style != null)? style : this.style;
		return this;
	}
	
	public ITagMaker setTitle(String title) {
		this.title = (title != null)? title : this.title;
		return this;
	}
	
	public ITagMaker tagStart(String tagName, StringBuilder sb, boolean tagEnd){
		return tagStartCustom(tagName, sb, id, cssClass, style, tagEnd);
	}
	public ITagMaker tagStartCustom(String tagName, StringBuilder sb, String id, String cssClass, String style, boolean tagEnd){
		sb.append('<').append(tagName);
		
		if (id != null) 		sb.append(" id=\"").append(id).append("\"");
		if (cssClass != null) 	sb.append(" class=\"").append(cssClass).append("\"");
		if (title != null) 		sb.append(" title=\"").append(title).append("\"");
		if (style != null) 		sb.append(" style=\"").append(style).append("\"");
		if (tagEnd == true)		sb.append('>');
		
		return this;
	}
	public ITagMaker tagStartNonAttr(String tagName, StringBuilder sb, boolean tagEnd){
		sb.append('<').append(tagName);

		if (tagEnd == true)		sb.append('>');
		
		return this;
	}
	public ITagMaker tagEnd(String tagName, StringBuilder sb){
		sb.append("</").append(tagName).append('>');
		return this;
	}
	public ITagMaker tagAttr(String attrName, String value, StringBuilder sb){
		if (value == null) return this;
		sb.append(' ').append(attrName).append("=\"").append(value).append("\"");
		return this;
	}
	public ITagMaker tagAttr(String attrName, int value, StringBuilder sb){
		return tagAttr(attrName, Integer.toString(value), sb);
	}
	public ITagMaker tagAttrClose(String attrName, String value, StringBuilder sb){
		tagAttr(attrName, value, sb);
		sb.append('>');
		return this;
	}
	public ITagMaker tagAttrEnd(String attrName, String value, StringBuilder sb){
		tagAttr(attrName, value, sb);
		sb.append(" />");
		return this;
	}
	
	protected int checkZero(Integer value, int defValue){
		if (value == null) return defValue;
		if (value == 0) return defValue;
		
		return value;
	}
	
	public StringBuilder make(){
		return make(new StringBuilder());
	}
	public abstract StringBuilder make(StringBuilder sb);
}
