package artn.common.tag;


public interface IPageNavigator extends ITagMaker{
	public IPageNavigator setUri(String uri);
	public IPageNavigator setPage(Integer page);
	public IPageNavigator setRowLimit(Integer rowLimit);
	public IPageNavigator setNavCount(Integer navCount);
	public IPageNavigator setRowCount(Integer rowCount);
	public IPageNavigator setFont(String font);
	public IPageNavigator setParams(Object params);
}
