package com.spring.wtm.model;

import lombok.Data;

@Data
public class Review {
    /** 리뷰 내용, IS NOT NULL */
    private String content;

    /** 변경일시, IS NOT NULL */
    private String editDate;

    /** 등록일시, IS NOT NULL */
    private String regDate;

    /** 일정 일련번호, IS NULL, MUL */
    private Integer reserveReserveId;

    /** 리뷰 아이디, IS NOT NULL, PRI */
    private int reviewId;

    /** 병원 아이디 (FK) */
    private int hospitalHospitalId;
    
    /** 회원 아이디 (FK) */
    private int memberId;
    
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;

    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;

    public static int getOffset() {
        return offset;
    }
    
    public static void setOffset(int offset) {
        Review.offset = offset;
    }
    
    public static int getListCount() {
        return listCount;
    }
    
    public static void setListCount(int listCount) {
        Review.listCount = listCount;
    }
    
}
