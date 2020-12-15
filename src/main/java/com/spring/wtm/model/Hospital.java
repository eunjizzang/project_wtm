package com.spring.wtm.model;

import lombok.Data;

@Data
public class Hospital {

    /** , IS NULL */
    private String friClose;

    /** , IS NULL */
    private String friOpen;

    /** , IS NOT NULL, PRI */
    private int hospitalId;

    /** 위도(y축), IS NULL */
    private String lat;

    /** 경도(x축), IS NULL */
    private String lon;

    /** , IS NULL */
    private String monClose;

    /** , IS NULL */
    private String monOpen;

    /** , IS NULL */
    private String name;

    /** , IS NULL */
    private String phone;

    /** , IS NULL */
    private String satClose;

    /** , IS NULL */
    private String satOpen;

    /** , IS NULL */
    private String site;

    /** , IS NULL */
    private String sub;

    /** , IS NULL */
    private String sunClose;

    /** , IS NULL */
    private String sunOpen;

    /** , IS NULL */
    private String thurClose;

    /** , IS NULL */
    private String thurOpen;

    /** , IS NULL */
    private String tueClose;

    /** , IS NULL */
    private String tueOpen;

    /** , IS NULL */
    private String wenClose;

    /** , IS NULL */
    private String wenOpen;
    
    /** 주소1(시/도) */
	private String addr;
	/** 주소2(시/구) */
	private String addr2;
	/** 주소3(동) */
	private String addr3;
    
    /** 오픈시간 */
	private String openTime;
	/** 닫는시간 */
	private String closeTime;

}
