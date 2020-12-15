package com.spring.wtm.model;

import lombok.Data;

@Data
public class Drug {
	// 1) 기본 컬럼
	/** id = PK */ 
	private int id;
	/** 약국 이름 */
	private String name;
	/** 전화번호 */
	private String phone;
	/** 주소1(시/도) */
	private String addr;
	/** 주소2(시/구) */
	private String addr2;
	/** 주소3(도로명) */
	private String addr3;
	/** 월요일 오픈시간 */
	private String monOpen;
	/** 월요일 닫는시간 */
	private String monClose;
	/** 화요일 오픈시간 */
	private String tueOpen;
	/** 화요일 닫는시간 */
	private String tueClose;
	/** 수요일 오픈시간 */
	private String wenOpen;
	/** 수요일 닫는시간 */
	private String wenClose;
	/** 목요일 오픈시간 */
	private String thurOpen;
	/** 목요일 닫는시간 */
	private String thurClose;
	/** 금요일 오픈시간 */
	private String friOpen;
	/** 금요일 닫는시간 */
	private String friClose;
	/** 토요일 오픈시간 */
	private String satOpen;
	/** 토요일 닫는시간 */
	private String satClose;
	/** 일요일 오픈시간 */
	private String sunOpen;
	/** 일요일 닫는시간 */
	private String sunClose;
	/** 공휴일 오픈시간 */
	private String holiOpen;
	/** 공휴일 닫는시간 */
	private String holiClose;
	/** 경도(x축) */
	private String lon;
	/** 위도(y축) */
	private String lat;
	/** 오픈시간 */
	private String openTime;
	/** 닫는시간 */
	private String closeTime;
}
