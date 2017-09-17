package artn.common.tag;

public class SurveyValueMaker extends AbsInputListTagMaker {

	protected String wrap = "span";
	protected int offset;
	
	public SurveyValueMaker(){}
	public SurveyValueMaker(String id, String cssClass, String style, String name, Integer value) {
		super(id, cssClass, style);
		setName(name).setValue(value);
	}
	
	public StringBuilder makeValuebox(StringBuilder sb){
		int iShift = 1 << this.offset;
		
		addValuebox( (iValue & iShift) > 0, sb);
		
		return sb;
	}

	protected StringBuilder addValuebox(boolean checked, StringBuilder sb){
		if (checked){
			tagStartNonAttr("span", sb, false).tagAttrClose("class", "yes", sb);
			sb.append("예");
			tagEnd("span", sb);
		}
		else{
			tagStart("span", sb, false).tagAttrClose("class", "no", sb);
			sb.append("아니오");
			tagEnd("span", sb);
		}
		return sb;
	}
	
	@Override
	public StringBuilder make(StringBuilder sb) {
		tagStart(wrap, sb, true);

		makeValuebox(sb);
		
		tagEnd(wrap, sb);
		return sb;
	}

	public SurveyValueMaker setValue(Integer value) {
		this.iValue = (value != null)? value : 0;
		return this;
	}
	
	@Override
	public ITagMaker setCssClass(String cssClass) {
		this.cssClass = (cssClass != null)? "survey-value" + ' ' + cssClass : "survey-value";
		return this;
	}
	
	public SurveyValueMaker setWrap(String wrap){
		this.wrap = (wrap != null)? wrap : "span";
		return this;
	}
	
	public SurveyValueMaker setOffset(Integer offset){
		this.offset = (offset == null)? 0 : offset;
		return this;
	}
}
