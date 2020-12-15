package com.spring.wtm.model;

import lombok.Data;

@Data
public class Medicine {
	
	/** item_seq = PK (not null) */	
	// 품목일련번호
	private int itemSeq;
	// 품목명
	private String itemName;
	// 식약처분류
	private String classNo;
	// 구분(전문/일반)
	private String etcOtcName;
	// 제조업체명
	private String entpName;
	// 성상
	private String chart;
	// 모양
	private String drugShape;
	// 색상1
	private String color1;
	// 색상2
	private String color2;
	// 분할선1
	private String line1;
	// 분할선2
	private String line2;
	// 제형
	private String formCode;
	//약 유효기간
	private String validTerm;
	// 이미지(null)
	private String drugImg;
	
	// 성분정보
	private String material;
	// 저장정보
	private String storageMethod;
	// 효능효과
	private String effectData;
	// 용법용량
	private String usageData;
	
	
	// -----------------------------------------------------------------------------------------------
	/** 페이지 구현을 위한 static 변수 */
    // LIMIT 절에서 사용할 조회 시작 위치 
    private static int offset;
    
    // LIMIT 절에서 사용할 조회할 데이터 수 
    private static int listCount;
    
    public static int getOffset() {
        return offset;
    }
    
    public static void setOffset(int offset) {
        Medicine.offset = offset;
    }
    
    public static int getListCount() {
        return listCount;
    }
    
    public static void setListCount(int listCount) {
        Medicine.listCount = listCount;
    }

	
	
	

}
