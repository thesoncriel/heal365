package artn.common.tag;

public interface IInputTagMaker extends ITagMaker {
	public IInputTagMaker setName(String name);
	public IInputTagMaker setValue(String value);
	public IInputTagMaker setValue(Integer value);
	public IInputTagMaker setRequired(String required);
	public IInputTagMaker setRequired(boolean required);
}