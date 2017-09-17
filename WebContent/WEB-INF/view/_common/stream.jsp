<%@page import="java.util.Queue"%>
<%@page import="artn.common.Property"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" trimDirectiveWhitespaces="true" contentType=""%>
<%!
protected String extractContentType(String fileName){
	String contentType = "";
	
	if (fileName.endsWith(".ogg") == true){
		contentType = "audio/ogg";
	}
	else if (fileName.endsWith(".webm") == true){
		contentType = "video/webm";
	}
	else if (fileName.endsWith(".mp4") == true){
		contentType = "video/mp4";
	}
	else if (fileName.endsWith(".MP4") == true){
		contentType = "video/mp4";
	}
	else if (fileName.endsWith(".mp3") == true){
		contentType = "audio/mp3";
	}
	else if (fileName.endsWith(".jpg") == true){
		contentType = "image/jpeg";
	}
	else if (fileName.endsWith(".png") == true){
		contentType = "image/png";
	}
	
	return contentType;
}

protected String pushOriName(Object oOriName, String fileName){
	try{
		Queue<String> qOriName = (Queue<String>)oOriName;
		return qOriName.poll();
	}
	catch(Exception ex){
		return fileName;
	}
}
%><%
FileInputStream fis = null;
OutputStream os = null;
String sFileName = "";
String sOriName = "";
String sPath = "";
String sDownloadPath = "";
File file = null;
String sContentType = "";

byte[] byaData;
int iNum;
long longFileLength;

response.reset();

//String sNextUri = "/" + sFileName;
//pageContext.forward( sNextUri );

try{
	sFileName = request.getParameter("fileName").toString();
	sOriName = pushOriName( session.getAttribute("oriNameQueue"), sFileName );
	sPath = request.getParameter("path").toString();
	sDownloadPath = Property.getInstance().get("artn.common.downloadPath");
	file = new File( sDownloadPath + "/" + sPath + sFileName );
	sContentType = extractContentType(sFileName);
	fis = new FileInputStream(file);
	os = response.getOutputStream();

	byaData = new byte[1024];
	iNum = 0;
	longFileLength = file.length();

	System.out.println( sOriName + "-------"+sContentType+"-----====" +sFileName);
	
	//response.setContentType( "movie/mp4" );
	response.setHeader("Content-Type", sContentType );                          
	response.setHeader("Content-Length", longFileLength + "");
	response.setHeader("Accept-Ranges", "bytes");
	response.setHeader("Content-Range", "bytes 0-" + (longFileLength - 1) + "/" + longFileLength );
	response.setHeader("Content-Disposition", "filename=" + sFileName + "");

	
	System.out.println( sOriName + "------------===="+sFileName );

	while((iNum = fis.read(byaData)) > -1){
		//os.write(byaData, 0, iNum);
		os.write(byaData);
	}
	
	os.flush();
	os.close();
}catch(Exception ex){}

fis.close();


//RequestDispatcher dispatcher = request.getRequestDispatcher(sNextUri);
//dispatcher.forward(request,response);
return;
%>