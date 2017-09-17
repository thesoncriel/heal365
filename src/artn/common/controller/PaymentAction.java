package artn.common.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import artn.common.model.Delivery;
import artn.common.tag.CalendarMaker;

public class PaymentAction extends DefaultAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4809587515405467483L;
	private CalendarMaker clm = new CalendarMaker();
	
	private Map<Integer, Delivery> deliveryInfo;
	
	@SuppressWarnings("unchecked")
	public Map<Integer, Delivery> getDeliveryInfo(){
		if(deliveryInfo == null){
			if(session().containsKey("deliveryInfo")){
				deliveryInfo = (Map<Integer, Delivery>)session().get("deliveryInfo");
			} else{
				List<Map<String, Object>> deliveryResult = null;
							
				deliveryResult = dbm().select("delivery_select", new HashMap<String, Object>());				
				
				deliveryInfo = new HashMap<Integer, Delivery>();
				
				for(Map<String, Object> map : deliveryResult ){
					deliveryInfo.put( (Integer) map.get("id_group"), new Delivery(map));
				}
				
				session().put("deliveryInfo", deliveryInfo);
			}
		}
		
		return deliveryInfo;
	}
	
	public String payment() throws Exception {
		valid.toEmail(getParams(), getArrayParams(), "pay_mail");
		valid.toPhone(getParams(), getArrayParams(), "pay_phone");
		System.out.println("payment====" + getParams().toString());
		if(getArrayParams().containsKey("subject") == true){
			getParams().put("subject", getArrayParams().get("subject")[0].toString() + " 외 " + (getArrayParams().get("subject").length - 1) + "개");
		}
		return SUCCESS;
	}
	
	public String cancel() throws Exception {
		if( user() == null ) return LOGIN;		
		return SUCCESS;
	}
	
	public String list(){
		if(user() == null){
			/*getParams().put("Guest", "Guest");*/
			getParams().put("Guest", "Guest");
			/*if( (getParams().containsKey("pay_user_name") == false) && (getParams().containsKey("id_user") == false)){*/
			if( (getParams().containsKey("pay_user_name") == false) && (session().containsKey("pay_user_name") == false)){
				return LOGIN;
			}
			getParams().put("id_user", "Guest");
			if(getArrayParams().containsKey("pay_phone") == true){
				valid.appendAndPutToMap(getParams(), getArrayParams(), "pay_phone", "-");
				session().put("pay_user_name", getParams().get("pay_user_name"));
				session().put("pay_phone", getParams().get("pay_phone"));
			}
			
			if(session().containsKey("pay_user_name") == true){
				getParams().put("pay_user_name", session().get("pay_user_name"));
				getParams().put("pay_phone", session().get("pay_phone"));
			}
			
			
		}else{
			if(getAuth().getIsAdmin() == false){
				getParams().put("id_user", user().getId());
			}
		}	
		
		if(getParams().get("status") == ""){
			getParams().remove("status");
		}
		if(getParams().get("id_group") == ""){
			getParams().remove("id_group");			
		}
		if(getParams().containsKey("date") && ( (getParams().get("date").equals("today") == true) || (getParams().get("date").equals("1week") == true)
				|| (getParams().get("date").equals("1month") == true) || (getParams().get("date").equals("3month") == true) || (getParams().get("date").equals("6month") == true)
				|| (getParams().get("date").equals("1year") == true)) ){
			getParams().put("date",clm.dateDiff(getParams(),getParams().get("date")));
		}
		if( (getParams().containsKey("search_div") == true) && (getParams().get("search_div").equals("") == true) ){
			getParams().put("search_text", "");
		}
		
		doList("payment-all");
		doShowSub("purchaseAll", "purchase-all");
		InsertQueryKey("payment-all","purchase-all");
		return successOrJsonList();
	}
	
	public String show(){
		if(user() == null){
			getParams().put("id_user", "Guest");
		}
		doShow("payment-single");
		return successOrJsonShow();
	}
	
	public String edit(){
		show();
		return SUCCESS;
	}
	public String modify(){
		Map<String, Object> mUpdateParam;
		Map<String, Object> mParam = getParams();
		Map<String, String[]> msaParam = getArrayParams();
		
		valid.appendAndPutToMap(mParam, msaParam, "to_phone_home", "-");
		valid.appendAndPutToMap(mParam, msaParam, "to_phone_mobi", "-");
		if(msaParam.containsKey("pay_phone") == true){
			valid.appendAndPutToMap(mParam, msaParam, "pay_phone", "-");
			valid.appendAndPutToMap(mParam, msaParam, "pay_mail", "@");	
		}
		getParams().putAll(mParam);
		System.out.println("modify====" + getParams().toString());
		if(user() == null){
			session().remove("guestCart");
			session().put("pay_user_name", mParam.get("pay_user_name"));
			session().put("pay_phone", mParam.get("pay_phone"));
		}else{
			getParams().put("id_user", user().getId());
			if(getAuth().getIsAdmin() == true){
				getParams().put("isAdmin", "isAdmin");
			}
			if(getArrayParams().containsKey("id_cart") == true){
				String[] id_cart = getArrayParams().get("id_cart");
				for(int i=0 ; i < id_cart.length ; i++){
					getParams().put("id_cart", id_cart[i]);
				doEdit("user-cart-delete");
				}
			}else{
				doEdit("user-cart-delete");
			}
		}
		if(getParams().containsKey("prodmodify") == true){
			valid.checkEmptyValue(getParams(), "Guest", "id_user");
			valid.checkEmptyValue(getParams(), "", "comment", "comment_admin", "delivery_num", "pay_type_name", "to_name"
					, "pay_bank_account", "to_phone_mobi", "to_phone_home", "to_zipcode","to_address"
					, "pay_bank_name", "pay_phone", "pay_mail", "file_img", "transaction_num");
			valid.checkEmptyValue(getParams(), util.getNow(), "date_upload");
			valid.checkEmptyValue(getParams(), 0, "amount", "amount_adjust");
			valid.checkEmptyValue(getParams(), 1, "pay_type");
			if(getArrayParams().containsKey("transaction_num") == true ){
				getParams().put("transaction_num", getArrayParams().get("transaction_num")[0]);
			}
		}
		dbm().open();
		if(getParams().containsKey("payment_update") == true){
			mUpdateParam = dbm().selectOneNonOpen("payment-single", mParam);
			mUpdateParam.putAll(mParam);
			getParams().putAll(mUpdateParam);
		}
		dbm().updateNonCommit("payment-modify", getParams());
		getParams().put("id_payment", dbm().selectOneNonOpen("common-inserted-id", getParams()).get("id"));
		dbm().commit();
		dbm().close();
		if(getParams().containsKey("prodmodify") == true){
			return "prodmodify";
		}
		return SUCCESS;
	}
	
	public String write(){
		return SUCCESS;
	}
	
	public String delete(){
		return SUCCESS;
	}
	
}
