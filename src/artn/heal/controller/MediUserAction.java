package artn.heal.controller;

import java.io.IOException;
import java.util.Map;

import artn.common.FileNameChangeMode;

public class MediUserAction extends AbsHeal365ActionController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3815493649947542453L;
	private int userEdit = -1;
	
	@Override
	public String list() throws Exception {
		getParams().put("auth_group", 50331648);
		doList("group-user-all");
		getParams().remove("auth_group");
		return successOrJsonList();
	}

	@Override
	public String show() throws Exception {
		doShow("group-user-single");
		return SUCCESS;
	}

	@Override
	public String edit() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String write() throws Exception {
		if(user() == null) return LOGIN;
		
		if(getAuth().getIsAdmin() == false){
			getParams().put("id_user", user().getId());
		}
		
		if (userEdit < 0){
			userEdit = prop.getIntegerHex("artn.user.join.guest");
		}
		
		getParams().put("rowlimit", 100);
		doShowSub("groupUserList", "group-user-all","groupList", "group-all", "groupAuthList", "user-auth-all");
		return SUCCESS;
	}

	@Override
	public String modify() throws Exception {
		if(user() == null) return LOGIN;
		//회원가입
		Map<String, Object> mParam = getParams();
		Map<String, String[]> msaParam = getArrayParams();
		valid.toPhone(mParam, msaParam, "phone_mobi");
		Map<String, Object> mUser = dbm().selectOne("user-single", mParam);
		boolean isNew = (mUser == null);
		if(getAuth().getIsGroupStaff() && getParams().get("auth_group_id").equals("262144") == false){
			getParams().put("auth_user_id", 3);
		}
		if (isNew == false){
			if ((getAuth().getIsAdmin() == false)){
				if (user().getId().equals(mParam.get("id")) == false) return ERROR_AUTH;
			}
			if(mParam.get("pw").equals("") || mParam.get("pw").toString() == null){
				mParam.put("pw", mUser.get("pw").toString());
			}
		}
		valid.checkEmptyValue(mParam, "", "zipcode_home", "address_home_new", "address_home1", "address_home2", "nick", "introduce");
		valid.checkEmptyValue(mParam, 4, "auth_user_id");
		valid.checkEmptyValue(mParam, 2, "login_limit","status_user");
		valid.checkEmptyValue(mParam, "m", "gender");
		valid.checkEmptyValue(mParam, util.getNow(), "date_join");
		valid.checkEmptyValue(mParam, "1992-01-01", "date_birth");
		valid.replaceCRLFToBRTags(mParam, "introduce");
		valid.mergeIntValuesToMap(mParam, msaParam, "opt");
		valid.mergeIntValuesToMap(mParam, msaParam, "status_user");
		valid.toPhone(mParam, msaParam, "phone_mobi");
		valid.toPhone(mParam, msaParam, "phone_home");
		valid.toEmail(mParam, msaParam, "email");
		
		dbm().open();
		if (mParam.get("introduce").toString().length() > 255){
			getError().put("introduce", "자기 소개 내용이 너무 많습니다. 간단히 적어 주세요.");
			valid.replaceBRTagsToCRLF(mParam, "introduce");
			getShowData().putAll(mParam);
			mParam.put("id_group", 0);
			doShowSub("auth_list", "user-auth-all");
			userEdit = user().getRestrictUserEdit();
			dbm().close();
			return ERROR;
		}

		if (hasFileParams() == true){
			try {
				saveFileToAuto(getDownloadPath() + "/upload/user/", FileNameChangeMode.nowdatetime);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		else{
			valid.checkFileExists(mParam, "file_img");
		}
		dbm().updateNonCommit("user-modify", getParams());
		getParams().put("id_user", getParams().get("id"));
		getParams().remove("id");
		
		//그룹가입
		valid.checkEmptyValue(getParams(), 0, "id_group", "auth_group_id");
		valid.mergeIntValuesToMap(getParams(), getArrayParams(), "opt");
		valid.replaceCRLFToBRTags(getParams(), "comment");
		dbm().updateNonCommit("group-user-modify", getParams());
		dbm().commit();
		dbm().close();
		return SUCCESS;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean userEdit(int place){
		return ((userEdit >> (place - 1)) & 1) > 0;
	}
	
	public String showPatient() throws Exception {
		getParams().put( "id", getParams().get( "id_user" ).toString() );
		doShow("user-single");
		
		return successOrJsonShow("id", "name", "gender_kor", "date_birth", "phone_mobi");
	}
	
	public String showMediStaff() throws Exception {
		getParams().put( "id", getParams().get( "id_user" ).toString() );
		doShow("group-user-single");
		
		return JSONSHOW;
	}
}
