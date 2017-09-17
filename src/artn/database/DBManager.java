package artn.database;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.security.InvalidParameterException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.session.Configuration;

import artn.common.Const;

public class DBManager implements IDBManager{
	private static final String MYBATIS_CONFIG = "artn/database/mybatis-conn-config.xml";

	private SqlSession sqlSession;
	private SqlSessionFactory sqlSessionFactory;
	private Stack<Boolean> stack;
	private static Configuration conf;
	
	public static DBManager getInstanceFromSession(Map<String, Object> session) throws IOException{
		if (session.containsKey("dbm") == true){
			return (DBManager)session.get("dbm");
		}
		
		DBManager dbm = new DBManager();
		
		session.put("dbm", dbm);
		
		return dbm;
	}
	
	public DBManager() throws IOException{
		if (DBManager.conf == null){
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);  // 케릭터셋 생성.
			InputStream inStrm = Resources.getResourceAsStream(DBManager.MYBATIS_CONFIG);
			
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inStrm);
			DBManager.conf = sqlSessionFactory.getConfiguration();
		}
		else{
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(DBManager.conf);
		}
		
		sqlSession = sqlSessionFactory.openSession();
		stack = new Stack<Boolean>();
	}
	
	protected void fillOffset(Map<String, Object> searchCondition){
		if ((searchCondition.containsKey("offset") == false)
				){
			int iPage = 1, iRowLimit = 10;
			
			try{
				iPage = Integer.parseInt(searchCondition.get("page").toString());
			}
			catch(Exception ex){
				searchCondition.put("page", iPage);
			}
			
			try{
				iRowLimit = Integer.parseInt(searchCondition.get("rowlimit").toString());
			}
			catch(Exception ex){}
			searchCondition.put("rowlimit", iRowLimit);
			searchCondition.put("offset", (iPage - 1) * iRowLimit);
		}
	}
	
	public void open(){
		if (stack.size() == 0){
			sqlSession = sqlSessionFactory.openSession();
		}
		stack.push(true);
	}
	
	public void close(){
		stack.pop();
		//System.out.println(">>>DB 닫기 시도 " + stack.size() + ">>>");
		if (stack.size() == 0){
			//sqlSession.clearCache();
			sqlSession.close();
			//System.out.println(">>>DB 닫기 완료>>>");
		}
	}
	
	public void commit(){
		sqlSession.commit();
	}
	
	public void fillRowNumbers(Map<String, Object> searchCondition, List<Map<String, Object>> resultData){
		if ((resultData.size() > 0) &&
				(resultData.get(0).containsKey(Const.KEY_ROW_COUNT) == true) &&
				(searchCondition.containsKey(Const.KEY_PAGE) == true) && 
				(searchCondition.containsKey(Const.KEY_ROW_LIMIT) == true)){
			
			boolean isAscending = (searchCondition.containsKey(Const.KEY_ROW_NUMBER_ASCENDING) == true)? true : false;
			int iRowNumber = 0;
			int iIncValue = 0;
			int iPage = Integer.parseInt(searchCondition.get(Const.KEY_PAGE).toString());
			int iRowlimit = Integer.parseInt(searchCondition.get(Const.KEY_ROW_LIMIT).toString());
			int iRowCount = Integer.parseInt(resultData.get(0).get(Const.KEY_ROW_COUNT).toString());
			
			if (isAscending == true){
				iRowNumber = 1 + ((iPage - 1) * iRowlimit);
				iIncValue = 1;
			}
			else{
				iRowNumber = iRowCount - ((iPage - 1) * iRowlimit);
				iIncValue = -1;
			}
			
			for(Map<String, Object> rowData : resultData){
				rowData.put(Const.KEY_ROW_NUMBER, Integer.valueOf(iRowNumber));
				iRowNumber = iRowNumber + iIncValue;
			}
		}
	}
	
	
	public List<Map<String, Object>> select(String queryKey, Map<String, Object> searchCondition){
		List<Map<String, Object>> data = null;
		
		fillOffset(searchCondition);
		open();
		data = sqlSession.selectList(queryKey, searchCondition);
		close();
		
		fillRowNumbers(searchCondition, data);
		
		return data;
	}
	public List<Map<String, Object>> selectNonOpen(String queryKey, Map<String, Object> searchCondition) {
		fillOffset(searchCondition);
		return sqlSession.selectList(queryKey, searchCondition);
	}
	public List<Map<String, Object>> selectNonOpen(String queryKey, Map<String, Object> searchCondition, boolean fillRowNumbers) {
		List<Map<String, Object>> data = null;
		
		fillOffset(searchCondition);
		data = sqlSession.selectList(queryKey, searchCondition);
		
		if (fillRowNumbers == true){
			fillRowNumbers(searchCondition, data);
		}
		
		return data;
	}
	public List<Integer> selectInteger(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectList(queryKey, searchCondition);
	}
	public List<Double> selectDouble(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectList(queryKey, searchCondition);
	}
	public List<String> selectString(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectList(queryKey, searchCondition);
	}
	
	public Map<String, List<Map<String, Object>> > selectMulti(String[] subNameQueryKeyPair, Map<String, Object> searchCondition){
		int iLen = subNameQueryKeyPair.length;
		
		if ((iLen & 1) == 1) throw new InvalidParameterException("DBManager Message: 파라메터 subNameQueryKeyPair의 배열 길이는 짝수여야 합니다.");
		
		Map<String, List<Map<String, Object>> > mapData = new HashMap<String, List<Map<String, Object>> >();
		List<Map<String, Object>> data = null;
		
		fillOffset(searchCondition);
		open();
		for(int i = 0; i < iLen; i+=2){
			data = sqlSession.selectList(subNameQueryKeyPair[i+1], searchCondition);
			fillRowNumbers(searchCondition, data);
			mapData.put(subNameQueryKeyPair[i], data);
		}
		close();

		return mapData;
	}
	public Map<String, List<Map<String, Object>> > selectMulti(String[] subNameQueryKeyPair, Map<String, Object> searchCondition, String[] searchConditionArray, String keyArrayTarget){
		int iLen = subNameQueryKeyPair.length;
		
		if ((iLen & 1) == 1) throw new InvalidParameterException("DBManager Message: 파라메터 subNameQueryKeyPair의 배열 길이는 짝수여야 합니다.");
		
		Map<String, List<Map<String, Object>> > mapData = new HashMap<String, List<Map<String, Object>> >();
		List<Map<String, Object>> data = null;
		String[] saValues = searchConditionArray;
		int i = 0, indexArr = 0;

		fillOffset(searchCondition);
		open();
		try{
			for(; i < iLen; i+=2){
				searchCondition.put(keyArrayTarget, saValues[ indexArr ]);
				data = sqlSession.selectList(subNameQueryKeyPair[i+1], searchCondition);
				fillRowNumbers(searchCondition, data);
				mapData.put(subNameQueryKeyPair[i], data);
				indexArr++;
			}
		}catch(IndexOutOfBoundsException ex){}
		
		for(; i < iLen; i+=2){
			data = sqlSession.selectList(subNameQueryKeyPair[i+1], searchCondition);
			fillRowNumbers(searchCondition, data);
			mapData.put(subNameQueryKeyPair[i], data);
		}
		close();

		return mapData;
	}
	public Map<String, Object> selectOne(String queryKey, Map<String, Object> searchCondition){
		Map<String, Object> data = null;
		
		open();
		data = sqlSession.selectOne(queryKey, searchCondition);
		close();
		
		return data;
	}
	public Map<String, Object> selectOneNonOpen(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectOne(queryKey, searchCondition);
	}
	public Integer selectOneInteger(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectOne(queryKey, searchCondition);
	}
	public double selectOneDouble(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectOne(queryKey, searchCondition);
	}
	public String selectOneString(String queryKey, Map<String, Object> searchCondition) {
		return sqlSession.selectOne(queryKey, searchCondition);
	}
		
	
	public void insert(String queryKey, Map<String, Object> data){
		open();
		sqlSession.insert(queryKey, data);
		sqlSession.commit();
		close();
	}
	public void insertNonCommit(String queryKey, Map<String, Object> data){
		sqlSession.insert(queryKey, data);
	}
	
	public void update(String queryKey, Map<String, Object> data){
		open();
		sqlSession.update(queryKey, data);
		sqlSession.commit();
		close();
	}
	public void updateNonCommit(String queryKey, Map<String, Object> data){
		sqlSession.update(queryKey, data);
	}
	
	public void delete(String queryKey, Map<String, Object> data){
		open();
		sqlSession.delete(queryKey, data);
		sqlSession.commit();
		close();
	}
	
	public void deleteNonCommit(String queryKey, Map<String, Object> data){
		sqlSession.delete(queryKey, data);
	}

	@Override
	public void insert(String queryKey, Object data) {
		open();
		sqlSession.insert(queryKey, data);
		commit();
		close();
	}

	@Override
	public void insertNonCommit(String queryKey, Object data) {
		sqlSession.insert(queryKey, data);
	}

	@Override
	public void update(String queryKey, Object data) {
		open();
		sqlSession.update(queryKey, data);
		commit();
		close();
	}

	@Override
	public void updateNonCommit(String queryKey, Object data) {
		sqlSession.update(queryKey, data);
	}
}
