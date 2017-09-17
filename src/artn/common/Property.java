package artn.common;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.Properties;

import org.apache.ibatis.io.Resources;

public class Property {
	private static final String PROPERTY_PATH = "struts.properties";
	private static Property prop;
	private Properties properties;
	
	public static Property getInstance(){
		if (prop == null){
			prop = new Property();
		}
		return prop;
	}
	
	protected Property(){
		InputStream inStream;
		
		try {
			Charset charset = Charset.forName( "UTF-8" );
			Resources.setCharset( charset );  // 케릭터셋 생성.
			inStream = Resources.getResourceAsStream( PROPERTY_PATH );
			properties = new Properties();
			properties.load(new InputStreamReader(inStream, "UTF-8"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String get(String key){
		try{
			return properties.get( key ).toString();
		}
		catch(NullPointerException ex){
			return null;
		}
	}
	
	public boolean getBoolean(String key){
		try{
			return Boolean.parseBoolean( properties.get( key ).toString() );
		}
		catch(Exception ex){
			return false;
		}
	}
	
	public int getInteger(String key){
		try{
			return Integer.parseInt( properties.get( key ).toString() );
		}
		catch(Exception ex){
			return 0;
		}
	}
	
	public int getIntegerHex(String key){
		try{
			return Integer.decode( properties.get( key ).toString() );
		}
		catch(Exception ex){
			return 0;
		}
	}
	
	public double getDouble(String key){
		try{
			return Double.parseDouble( properties.get( key ).toString() );
		}
		catch(Exception ex){
			return 0.0;
		}
	}
}
