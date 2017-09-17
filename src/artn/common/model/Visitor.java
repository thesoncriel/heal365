package artn.common.model;

import java.io.IOException;
import java.util.Map;

import artn.common.Util;
import artn.database.DBManager;

public class Visitor {
	private String ip;
	private String ipv6;
	private String dateVisit;
	private String urlInflow;
	private String urlInflowShort;
	private String browserName;
	private String browserVersion;
	private String osName;
	private String osVersion;
	private String osPlatform;
	private String device;
	private String idUser;
	
//	public static Visitor parseVisitor(Map<String, Object> session){
//		Visitor visitor = new Visitor();
//		
//		String s
//	}
	
	public Visitor(String referer, String ip){
		String[] saInflow;
		Util util = Util.getInstance();
		
		
		if (ip.contains(".") == true){
			this.ip = ip;
			this.ipv6 = "";
		}
		else{
			this.ip = "";
			this.ipv6 = ip;
		}
		
		dateVisit = util.getNow();
		if(referer == null){
			urlInflow= "";
			urlInflowShort = "";
		} else{
			urlInflow = referer.toString();
			saInflow = urlInflow.split("/");
			urlInflowShort = saInflow[0] + "//" + saInflow[2];
		}		
	}
	
	public void readEnvironment(Environment env){
		this.browserName = env.getBrowserName();
		this.browserVersion = env.getBrowserVersion();
		this.osName = env.getOsName();
		this.osPlatform = env.getOsPlatform();
		this.osVersion = env.getOsVersion();
		this.device = env.getDevice();
	}

	public void doInsert(DBManager dbm){
		if(device == null){
			this.setDevice("");
		}
		if(browserVersion.equals("SERVER")){
			this.setIdUser("SERVER");
		}
		if(this.getIdUser() == null){
			this.setIdUser("Guest");
		}
		dbm.insert("user-stats", this);
	}
	public void doInsert(Map<String, Object> session){
		try {
			this.doInsert(DBManager.getInstanceFromSession(session));
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getIpv6() {
		return ipv6;
	}
	public void setIpv6(String ipv6) {
		this.ipv6 = ipv6;
	}
	public String getDateVisit() {
		return dateVisit;
	}
	public void setDateVisit(String dateVisit) {
		this.dateVisit = dateVisit;
	}
	public String getUrlInflow() {
		return urlInflow;
	}
	public void setUrlInflow(String urlInflow) {
		this.urlInflow = urlInflow;
	}
	public String getUrlInflowShort() {
		return urlInflowShort;
	}
	public void setUrlInflowShort(String urlInflowShort) {
		this.urlInflowShort = urlInflowShort;
	}
	public String getBrowserName() {
		return browserName;
	}
	public void setBrowserName(String browserName) {
		this.browserName = browserName;
	}
	public String getBrowserVersion() {
		return browserVersion;
	}
	public void setBrowserVersion(String browserVersion) {
		this.browserVersion = browserVersion;
	}
	public String getOsName() {
		return osName;
	}
	public void setOsName(String osName) {
		this.osName = osName;
	}
	public String getOsVersion() {
		return osVersion;
	}
	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}
	public String getOsPlatform() {
		return osPlatform;
	}
	public void setOsPlatform(String osPlatform) {
		this.osPlatform = osPlatform;
	}
	public String getDevice() {
		return device;
	}
	public void setDevice(String device) {
		this.device = device;
	}
	public String getIdUser() {
		return idUser;
	}
	public void setIdUser(String idUser) {
		this.idUser = idUser;
	}
}

