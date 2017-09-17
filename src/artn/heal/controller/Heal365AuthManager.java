package artn.heal.controller;
import java.util.Map;

import artn.common.manager.AuthManager;
import artn.common.model.User;

public class Heal365AuthManager extends AuthManager {
	
	public Heal365AuthManager(User user) { super(user); }
	
	public boolean getIsMediMgr(){
		return this.getIsGroupManagerL3();
	}
	
	public boolean getIsDoctor(){
		return this.getIsGroupManagerL2();
	}
	
	public boolean getIsTherap(){
		return this.getIsGroupManagerL1();
	}
	
	public boolean getIsNurse(){
		return this.getIsSemiStaffL4();
	}
	public boolean getIsPatient(){
		return this.getIsGroupUser();
	}
	
	public boolean getIsUser(){
		return this.getIsSiteUser();
	}
	
	public boolean getIsMediStaff(){
		return this.getIsGroupManager();
	}
	
	public boolean getIsApprover(){		
		return ( (this.user().getAuthGroup() & 0x2000) > 0 );
	}
	
	
	
	/*
	 * 통증치료 및 예방운동
	 * 나의 처방 운동
	 * 테마별 운동
	 * Workout
	 * 
	 * 처방전 관리
	 * 영상 등록 및 관리
	 * 조합 등록 및 관리
	 * 365플러스 조합관리
	 * 
	 * 소속 의료기관 정보
	 * 의료기관 목록
	 * 회원 관리
	 * */
	public int makeMenuAuth(){
		int iSample = 0;
		if (getIsAdmin() == true) return 0xFFFFEFF;
		if (getIsUser() == true) iSample |= 0xD;
		if (getIsPatient() == true) iSample |= 0xF;
		if (getIsNurse() == true) iSample |= 0x51F;
		if (getIsTherap() == true) iSample |= 0x51F;
		if (getIsDoctor() == true) iSample |= 0x51F;
		if (getIsMediMgr() == true) iSample |= 0x51F;
		
		return iSample;
	}
}
