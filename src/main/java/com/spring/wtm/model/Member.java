package com.spring.wtm.model;

import lombok.Data;

@Data
public class Member {
	// 회원 일련번호 (PK) Not Null
	private int id;   
	// 회원 아이디 (고정값, 중복검사) Not Null
	private String userId;
	// 회원 비밀번호 (암호화)
	private String userPw;  
	// 회원 이름 Not Null
	// 한글만 입력 가능하게 해놓았는데, 카카오 가입자의 닉네임을 사용할 것이므로 영어, 특문 가능(?) 아니면 비워놓기? 아니면 랜덤값?
	private String userName;     
	// 회원 이메일 (고정값, 중복검사)
	private String email;         
	// 회원 휴대폰 번호 (중복검사)
	private String tel;           
	// 회원 주소
	private String postcode;      
	private String address;       
	private String detailAddress;
	private String extraAddress; 
	// 회원 유형 (0관리자, 1일반, 9탈퇴, 2카카오)
	private int type;          
	// 비밀번호 재발급 여부 Not Null default='Y'
	private String reissue;
	// 최종 로그인 일시 (최초 로그인 이전값만 Null)
	private String loginDate;    
	// 가입 일시 (고정값, 회원찾기시 보여줄 값) Not Null
	private String regDate;      
	// 최종 수정 일시 Not Null
	private String editDate;     
	// 로그인 세션 값 (자동로그인 선택시 저장할 JSESSIONID)
	private String sessionKey;  
	// 로그인 세션 유효기간 (자동로그인 해제: 세션만료, 타임스탬프)
	private String sessionLimit;
	
    // 페이지 구현을 위한 static 변수
    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;
    /** LIMIT 절에서 사용할 조죄할 데이터 수 */
    private static int listCount;
    
    public static int getOffset() { return offset; }
    public static void setOffset(int offset) { Member.offset = offset; }
    public static int getListCount() { return listCount; }
    public static void setListCount(int listCount) { Member.listCount = listCount; }
}

