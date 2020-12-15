package com.spring.wtm.model;

import lombok.Data;

/**
 * 장바구니에서 담긴 상품 정보
 */
@Data
public class ProdInfo {
	/** 상품 아이디 */
	private int productId;
	/** 상품 이름 */
	private String name;
	/** 상품 이미지 경로 */
	private String img;
	/** 단가 */
	private int price;
	/** 수량 */
	private int qty;
	/** 합계 */
	private int c_price;
}
