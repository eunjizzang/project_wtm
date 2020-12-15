package com.spring.wtm.model;

import lombok.Data;

@Data
public class Delivery {
	// 1) 기본 컬럼
	/** id = PK */ 
	private int id;
	/** 수령자 */
	private String receiver;
	/** 전화번호 */
	private String tel;
	/** 우편번호 */
	private String postcode;
	/** 주소 */
	private String address;
	/** 상세주소 */
	private String detailAddress;
	/** 추가주소 */
	private String extraAddress;
	/** 배송메모 */
	private String memo;
	/** 결제방식 */
	private String orderPay;
	/** 등록일시 */
	private String regDate;
	/** 변경일시 */
	private String editDate;
	/** 멤버 id(FK) */
	private int memberId;
	/** 주문 일련번호(FK)*/
	private int orderId;
	
	// 2) JOIN절에 따른 추가 컬럼
	/** member 조인 - 주문자명 */
	private String userName;
	/** order 조인 - 주문상테 */
	private String status;
	/** order 조인 - 결제금액 */
	private int totalPrice;

}
