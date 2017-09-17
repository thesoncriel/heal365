package artn.database;

import java.util.List;
import java.util.Map;

public interface IDBManager {
	public void open();
	public void close();
	public void commit();
	public List<Map<String, Object>> select(String queryKey, Map<String, Object> searchCondition);
	public List<Map<String, Object>> selectNonOpen(String queryKey, Map<String, Object> searchCondition);
	public List<Map<String, Object>> selectNonOpen(String queryKey, Map<String, Object> searchCondition, boolean fillRowNumbers);
	public List<Integer> selectInteger(String queryKey, Map<String, Object> searchCondition);
	public List<Double> selectDouble(String queryKey, Map<String, Object> searchCondition);
	public List<String> selectString(String queryKey, Map<String, Object> searchCondition);
	
	public Map<String, List<Map<String, Object>> > selectMulti(String[] subNameQueryKeyPair, Map<String, Object> searchCondition);
	public Map<String, List<Map<String, Object>> > selectMulti(String[] subNameQueryKeyPair, Map<String, Object> searchCondition, String[] searchConditionArray, String keyArrayTarget);
	public Map<String, Object> selectOne(String queryKey, Map<String, Object> searchCondition);
	public Map<String, Object> selectOneNonOpen(String queryKey, Map<String, Object> searchCondition);
	public Integer selectOneInteger(String queryKey, Map<String, Object> searchCondition);
	public double selectOneDouble(String queryKey, Map<String, Object> searchCondition);
	public String selectOneString(String queryKey, Map<String, Object> searchCondition);
	public void insert(String queryKey, Map<String, Object> data);
	public void insertNonCommit(String queryKey, Map<String, Object> data);
	public void update(String queryKey, Map<String, Object> data);
	public void updateNonCommit(String queryKey, Map<String, Object> data);
	public void delete(String queryKey, Map<String, Object> data);
	public void deleteNonCommit(String queryKey, Map<String, Object> data);
	
	public void insert(String queryKey, Object data);
	public void insertNonCommit(String queryKey, Object data);
	public void update(String queryKey, Object data);
	public void updateNonCommit(String queryKey, Object data);
}
