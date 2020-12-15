package com.spring.wtm.model;

import lombok.Data;

@Data
public class Product {
	// 1) 기본 컬럼
	/** id = PK */
	private int id;
	/** 이미지 경로 */
	private String img;
	/** 상품이름 */
	private String name;
	/** 영어 이름 */
	private String eng;
	/** 가격 */
	private int price;
	/** 수량 */
	private int qty;
	/** 상세정보 */
	private String desc;
	/** 스펙 */
	private String spec;
	/** 배달안내 */
	private String delivery;
	/** 카테고리 */
	private String category;
	/** 등록날짜 */
	private String regDate;
	/** 수정 날짜 */
	private String editDate;
	
	// 2) 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
    public static int getOffset() {
        return offset;
    }
    
    public static void setOffset(int offset) {
        Product.offset = offset;
    }
    
    public static int getListCount() {
        return listCount;
    }
    
    public static void setListCount(int listCount) {
        Product.listCount = listCount;
    }
}
