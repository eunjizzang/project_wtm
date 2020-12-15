package com.spring.wtm.model;

import lombok.Data;

@Data
public class Reserve {
    /** , IS NULL, MUL */
    private Integer hospitalHospitalId;

    /** , IS NULL, MUL */
    private Integer memberId;

    /** , IS NOT NULL */
    private String reDate;

    /** , IS NOT NULL */
    private String reName;

    /** , IS NOT NULL */
    private String reTel;

    /** , IS NOT NULL */
    private String reTime;

    /** , IS NOT NULL, PRI */
    private int reserveId;
    
    private String name;
    
    /** 위도(y축), IS NULL */
    private String lat;

    /** 경도(x축), IS NULL */
    private String lon;
    
    /** 전화번호, IS NULL */
    private String phone;

    /** 주소, IS NULL */
    private String addr;
    
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    
    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;
    
    public static int getOffset() {
        return offset;
    }
    
    public static void setOffset(int offset) {
        Reserve.offset = offset;
    }
    
    public static int getListCount() {
        return listCount;
    }
    
    public static void setListCount(int listCount) {
    	Reserve.listCount = listCount;
    }
}
