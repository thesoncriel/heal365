package artn.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.Const;

public abstract class AbsSubDataActionController extends AbsUtilitySupportActionController {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5461558561872975236L;
	protected Map< String, List<Map<String, Object>> > subResult;
	protected Map<String, Integer> subRowCount;
	protected Map<String, Boolean> subIsNull;
	
	public Map<String, List<Map<String, Object>> > getSubData(){
		if ((subResult == null) || (subIsNull == null)){
			subResult = new HashMap<String, List<Map<String, Object>> >();
			subRowCount = new HashMap<String, Integer>();
			subIsNull = new HashMap<String, Boolean>();
		}
		return subResult;
	}
	
	public Map<String, Integer> getSubRowCount(){
		return subRowCount;
	}
	public Map<String, Boolean> getSubIsNull(){
		return subIsNull;
	}
	
	public void doShowSub(String subName, String queryKey){
		doShowSub(subName, queryKey, true);
	}
	public void doShowSub(String subName, String queryKey, boolean doOpen){
		int iRowCount = 0;
		List<Map<String, Object>> lmResult;
		
		if (doOpen) dbm().open();
		
		lmResult = dbm().selectNonOpen(queryKey, getParams());
		getSubData().put(subName, lmResult);
		
		try{
			iRowCount = Integer.parseInt( lmResult.get(0).get(Const.KEY_ROW_COUNT).toString() );
			subRowCount.put(subName, iRowCount);
		}
		catch(Exception ex){
			err = ex.toString();
			subRowCount.put(subName, 0);
		}
		
		if (doOpen) dbm().close();
		
		subIsNull.put(subName, (lmResult == null) || (lmResult.size() == 0) );
	}
	public void doShowSub(String... subNameQueryKeyPairs){
		int iRowCount = 0;
		int iLen = subNameQueryKeyPairs.length;
		String subName = "";
		
		getSubData().putAll( dbm().selectMulti(subNameQueryKeyPairs, getParams()) );
		
		for(int i = 0; i < iLen; i+=2){
			try{
				subName = subNameQueryKeyPairs[i];
				iRowCount = Integer.parseInt(subResult.get(subName).get(0).get(Const.KEY_ROW_COUNT).toString());
				subRowCount.put(subName, iRowCount);
			}
//			catch(NullPointerException ex){}
//			catch(IndexOutOfBoundsException ex){}
			catch(Exception ex){
				err = ex.toString();
				subRowCount.put(subName, 0);
			}
			subIsNull.put(subName, (subResult == null) || (subResult.get(subName).size() == 0) );
		}
	}
	public void doShowSub(String subName, String queryKey, boolean doOpen, String... usingKeys){
		int iRowCount = 0;
		int iLen = getArrayParams().get( usingKeys[0] ).length;
		String sCurrSubName = "";
		List<Map<String, Object>> lmResult = null;
		
		if (doOpen) dbm().open();
		
		for(int i = 0; i < iLen; i++){
			sCurrSubName = subName + i;
			try{
				for(String key : usingKeys){
					getParams().put(key, getArrayParams().get(key)[i]);
				}
				
				lmResult = dbm().selectNonOpen(queryKey, getParams());
				getSubData().put(sCurrSubName, lmResult);
				iRowCount = Integer.parseInt(lmResult.get(0).get(Const.KEY_ROW_COUNT).toString());
				subRowCount.put(sCurrSubName, iRowCount);
			}
//			catch(NullPointerException ex){}
//			catch(IndexOutOfBoundsException ex){}
			catch(Exception ex){
				err = ex.toString();
				subRowCount.put(sCurrSubName, 0);
			}
			subIsNull.put(sCurrSubName, (lmResult == null) || (lmResult.size() == 0) );
		}
		
		if (doOpen) dbm().close();
	}
	public void doEditSub(String queryKey_SubData){
		doEditSub(queryKey_SubData, "", "", "", true);
	}
	public void doEditSub(String queryKey_SubData, boolean doCommit){
		doEditSub(queryKey_SubData, "", "", "", doCommit);
	}
	public void doEditSub(String queryKey_SubData, String lengthCriteriaKey){
		doEditSub(queryKey_SubData, "", lengthCriteriaKey, "", true);
	}
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey){
		doEditSub(queryKey_SubData, queryKey_DeleteDuplicate, lengthCriteriaKey, "", true);
	}
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey, boolean doCommit){
		doEditSub(queryKey_SubData, queryKey_DeleteDuplicate, lengthCriteriaKey, "", doCommit);
	}
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey, String emptyToNullKey, boolean doCommit){
		doEditSub(queryKey_SubData, queryKey_DeleteDuplicate, lengthCriteriaKey, emptyToNullKey, getParams(), doCommit);
	}
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey, Map<String, Object> mParams, boolean doCommit){
		doEditSub(queryKey_SubData, queryKey_DeleteDuplicate, lengthCriteriaKey, "", mParams, doCommit);
	}
	/**
	 * 
	 * @param queryKey_SubData			반복할 쿼리키
	 * @param queryKey_DeleteDuplicate	삭제 기능을 수행할 쿼리키. 수행전 삭제가 필요하다면 사용한다.
	 * @param lengthCriteriaKey			배열 파라매터 중 그 배열 길이의 기준이 되는 파라메터키
	 * @param doCommit					수행 후 곧바로 커밋을 할지의 여부
	 */
	public void doEditSub(String queryKey_SubData, String queryKey_DeleteDuplicate, String lengthCriteriaKey, String emptyToNullKey, Map<String, Object> mParams, boolean doCommit){
		try{
			Map<String, String[]> mArrParams = getArrayParams();
			String[] keys = mArrParams.keySet().toArray(new String[0]);
			String key = "";
			String[] saValues;
			int iLen = 0;
			
			if (lengthCriteriaKey.equals("") == true){
				iLen = getMultiParamArrayLength();
			}
			else if (mArrParams.containsKey(lengthCriteriaKey) == true){
				iLen = mArrParams.get(lengthCriteriaKey).length;
			}
			
			if (doCommit == true) dbm().open();
			
			if (queryKey_DeleteDuplicate.equals("") == false){
				dbm().deleteNonCommit(queryKey_DeleteDuplicate, mParams);
			}
			
			if (iLen == 0){
				if ("".equals(emptyToNullKey) == false){
					if ("".equals(mParams.get(emptyToNullKey)) == true){
						mParams.remove(emptyToNullKey);
					}
				}
				if (mParams.containsKey(lengthCriteriaKey) == true){
					dbm().updateNonCommit(queryKey_SubData, mParams);
				}
			}
			else{
				if ("".equals(emptyToNullKey) == false){
					for(int iDataIdx = 0; iDataIdx < iLen; ++iDataIdx){
						for(int iKeyIdx = 0; iKeyIdx < keys.length; ++iKeyIdx){
							key = keys[iKeyIdx];
							saValues = mArrParams.get(key);

							if (saValues.length < iLen) continue;
							
							if ((key.equals(emptyToNullKey)) && ("".equals(saValues[iDataIdx]) == true)){
								mParams.remove(emptyToNullKey);
							}
							else{
								mParams.put(key, saValues[iDataIdx]);
							}
						}
						dbm().updateNonCommit(queryKey_SubData, mParams);
					}
				}
				else{
					for(int iDataIdx = 0; iDataIdx < iLen; ++iDataIdx){
						for(int iKeyIdx = 0; iKeyIdx < keys.length; ++iKeyIdx){
							key = keys[iKeyIdx];
							saValues = mArrParams.get(key);

							if (saValues.length < iLen) continue;

							mParams.put(key, saValues[iDataIdx]);
						}
						dbm().updateNonCommit(queryKey_SubData, mParams);
					}
				}
				
			}
			
			
			if (doCommit == true){
				dbm().commit();
				dbm().close();
			}
		}
		//catch(NullPointerException ex){}
		catch(Exception ex){
			System.out.println(ex);
			dbm().close();
		}
	}
}
