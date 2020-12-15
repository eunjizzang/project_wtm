package com.spring.wtm.model;

import lombok.Data;

@Data
public class Cart {
	// 1) 기본 컬럼
	/** id = PK */ 
	private int id;
	/** 상품 이미지 */
	private String img;
	/** 상품 이름 */
	private String name;
	/** 상품 수량 */
	private int qty;
	/** 상품 가격 */
	private int price2;
	/** JSESSIONID */
	private String sessionId;
	/** 등록일시 */
	private String regDate;
	/** 변경일시 */
	private String editDate;
	/** 멤버 id */
	private int memberId;
	/** 상품 id */
	private int productId;
	/** 대량 삭제를 위한 일련번호 배열 */
    private int[] idArr;
	
	// 2) JOIN절에 따른 추가 컬럼
	/** Product 테이블과 join */
	private int price1;
	
	/** Member 테이블과 join */
	private String name2;
	private String tel;
	private String email;
	private String postcode;
	private String address;
	private String detail_address;
}
