package com.spring.wtm.service;

import java.util.List;

import com.spring.wtm.model.Member;

public interface MemberService {
	/**
	 * 회원 로그인
	 * @param Member (로그인목적의) 조회할 회원의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Member login(Member input) throws Exception;
	
    /**
     * 회원 데이터 상세 조회
     * @param Member 조회할 회원의 일련번호를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    public Member getMemberItem(Member input) throws Exception;
    
    /**
     * 회원 아이디/이메일/전화번호 중복 조회
     * @param input
     * @return
     * @throws Exception
     */
    public Member idCheck(Member input) throws Exception;
    public Member emailCheck(Member input) throws Exception;
    public Member telCheck(Member input) throws Exception;

    /**
     * id 찾기
     * @param input
     * @return
     * @throws Exception
     */
    public Member idFind(Member input) throws Exception;

    /**
     * 비밀번호 재발급
     * @param Member
     */
    public void pwFind(Member input) throws Exception;
    
    /**
     * 재발급 스케쥴링
     * @param Member
     */
    public int pwFind2(Member input) throws Exception;
        
    /**
     * 회원 데이터 목록 조회
     * @param Member 검색조건과 페이지 구현 정보를 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    public List<Member> getMemberList(Member input) throws Exception;
    
    /**
     * 회원 데이터가 저장되어 있는 갯수 조회
     * @param Member 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int getMemberCount(Member input) throws Exception;
    
    /**
     * 회원 데이터 등록하기
     * @param Member 저장할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int addMember(Member input) throws Exception;
    
    /**
     * 회원 데이터 수정하기
     * @param Member 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int editMember(Member input) throws Exception;
    
    /**
     * 회원 데이터 수정하기 (회원 탈퇴)
     * @param Member 삭제할 회원의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int deleteMember(Member input) throws Exception;
    
    /**
     * 회원 데이터 삭제하기
     * @param Member 삭제할 회원의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int dropMember(Member input) throws Exception;
}
