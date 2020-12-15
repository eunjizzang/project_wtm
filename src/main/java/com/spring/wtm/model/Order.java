package com.spring.wtm.model;

import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import lombok.Data;

@Data
public class Order {
	// 1) 기본 컬럼
	/** id = PK */ 
	private int id;
	/** 총 결제금액 */
	private int totalPrice;
	/** 주문 상태 */
	private String status;
	/** 주문 날짜 */
	private String orderDate;
	/** 변경일시 */
	private String editDate;
	/** 상품 정보(Json) */
	private List<ProdInfo> prodInfo;
	/** 멤버 id */
	private int memberId;
	/** 상품 id */
	private int productId;
	/** 상품 건수 -1 (----외 n건) */
	private int count;
	
	// 2) // 멤버변수로 저장되어 있는 특정 Beans의 데이터를 JSON문자열로 변환 후 리턴
	public String getProdInfoJson() {
		Gson gson = new Gson();
		String json = gson.toJson(this.prodInfo);
		return json;
	}
	
	// Beans구조를 본딴 JSON 문자열을 파라미터로 받아서 Bean 객체로 변환후 멤버변수에 할당
	public void setProdInfoJson(String json) {
		Gson gson = new Gson();
		this.prodInfo = gson.fromJson(json, new TypeToken<List<ProdInfo>>() {}.getType());
	}
	
	// 3) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
    public static int getOffset() {
        return offset;
    }
    
    public static void setOffset(int offset) {
        Order.offset = offset;
    }
    
    public static int getListCount() {
        return listCount;
    }
    
    public static void setListCount(int listCount) {
        Order.listCount = listCount;
    }
}
