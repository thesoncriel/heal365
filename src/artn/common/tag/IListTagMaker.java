package artn.common.tag;

import java.util.List;
import java.util.Map;

public interface IListTagMaker extends ITagMaker{
	public IListTagMaker setList(Object list);
	public IListTagMaker setList(List<Map<String, Object>> list);
	public IListTagMaker setList(String... list);
	public IListTagMaker setListKey(String listKey);
}
