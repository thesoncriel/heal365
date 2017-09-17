package artn.common.controller;

import java.io.File;

import artn.common.Const;

public class DefaultAction extends AbsUploadActionController {
	/**
	 * 
	 */
	private static final long serialVersionUID = 9052582141472461151L;


	@Override
	public String list() throws Exception { return SUCCESS; }
	@Override
	public String show() throws Exception { return SUCCESS; }
	@Override
	public String edit() throws Exception { return SUCCESS; }
	@Override
	public String write() throws Exception { return SUCCESS; }
	@Override
	public String modify() throws Exception { return SUCCESS; }
	@Override
	public String delete() throws Exception { return SUCCESS; }
	
	public boolean hasContents(String contentsCode){
		File file = new File( Const.getRootPath() + "/WEB-INF/include/contents/" + contentsCode + ".htmlpart" );

		return file.exists();
	}
}
