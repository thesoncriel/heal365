package artn.heal.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayDeque;
import java.util.Queue;
import java.util.concurrent.ArrayBlockingQueue;

public class PlayerAction extends AbsHeal365ActionController {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6172273556345311271L;

	private String redirectPath;

	private FileInputStream mediaStream;

	private String contentType;

	private String fileName;

	private long contentLength;

	@Override
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String show() throws Exception {
		if (user() == null) return LOGIN;
//		Map<String, Object> mUser = (Map<String, Object>)session().get("user");
//		mUser.put("id_cont", getParams().get("id"));
		//FIXME : log남기는 기능 완료 후 수정할 것. 130820_shkang
//		LogManager.getInstance().get("player-start").write(mUser);	
		return successOrJsonShow();
	}

	@Override
	public String edit() throws Exception {return null;}

	@Override
	public String write() throws Exception {return null;}

	@Override
	public String modify() throws Exception {return null;}

	@Override
	public String delete() throws Exception {return null;}
	
	@SuppressWarnings("unchecked")
	public String media() throws Exception {
		//if (user() == null) return LOGIN;
		
		//return "media";

	/*long longNow = Long.parseLong( util.getIdByNowDateTime() );
		String sFileName = getParams().get("fileName").toString();
		int indexDotPosition = sFileName.lastIndexOf(".");
	String sFileExt = sFileName.substring(indexDotPosition);
		Queue<String> qOriName = null;
		
		if (session().containsKey("oriNameQueue") == false){
			qOriName = new ArrayDeque<String>();
			session().put("oriNameQueue", qOriName);
		}
		else{
			qOriName = (Queue<String>)session().get("oriNameQueue");
		}
		
		qOriName.add( (longNow + this.hashCode()) + sFileExt );
		
		setQueueData( "oriNameQueue", (longNow + this.hashCode()) + sFileExt );
		
		return "media";*/
		if (user() == null) return LOGIN;
		
		this.redirectPath = '/' + getParams().get("path").toString() + getParams().get("fileName").toString();
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	protected void setQueueData(String queueKey, String value){
		Queue<String> qOriName = null;
		
		if (session().containsKey( queueKey ) == false){
			qOriName = new ArrayDeque<String>();
			session().put( queueKey, qOriName);
		}
		else{
			qOriName = (Queue<String>)session().get( queueKey );
		}
		
		qOriName.add( value );
	}
	
	public FileInputStream getMediaStream(){
		if (mediaStream == null){
			System.out.println( "PlayerAction.getMediaStream::" + this.hashCode() + ":::" + contentType + ":::" + fileName + "=널이당");
		}
		else{
			System.out.println( "PlayerAction.getMediaStream::" + this.hashCode() + ":::" + contentType + ":::" + fileName + "=통과");
		}
		
		return mediaStream;
	}
	
	public String getContentType(){
		return contentType;
	}
	
	public String getFileName(){
		return fileName;
	}
	
	public String getRedirectPath(){
		return this.redirectPath;
	}
	
	public long getContentLength(){
		return contentLength;
	}
	
//	public InputStream getMediaFile(){
//		return inStrm;
//	}
//	
//	public void setContentType(String contentType){
//		this.contentType = contentType;
//	}
//	public String getContentType(){
//		return this.contentType;
//	}
//
//	public String getContentLength() {
//		return contentLength;
//	}
//
//	public void setContentLength(String contentLength) {
//		this.contentLength = contentLength;
//	}
	
}
