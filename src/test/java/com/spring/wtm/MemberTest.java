package com.spring.wtm;

import org.apache.ibatis.session.SqlSession;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Member;

import lombok.extern.slf4j.Slf4j;

/** Lombok의 Log4j 객체 */
@Slf4j
/** JUnit에 의한 테스트 클래스로 정의 */
@RunWith(SpringJUnit4ClassRunner.class)
/** Spring의 설정 파일들을 읽어들이도록 설정 (**은 `모든`이라는 의미) */
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*-context.xml" })
/** 웹 어플리케이션임을 명시 */
@WebAppConfiguration
/** 메서드 이름순서로 실행하도록 설정 (설정하지 않을 경우 무작위 순서로 실행됨) */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class MemberTest {
	
	@Autowired
	SqlSession sqlSession;
	@Autowired
	WebHelper webHelper;
	
	/** 회원 가입 테스트 */
//	@Test
//	public void testA() {
//		/*
//		 *  #{user_id}, md5(#{user_pw}), #{user_name}, #{email}, #{tel}, 
//		 *	#{postcode}, #{address}, #{detail_address}, #{extra_address}, #{type}, 
//		 *	now(), now(), now(), #{session_key}, #{session_limit}
//		 */
//		Member m = new Member();
//		m.setUserId("admin");
//		m.setUserPw("1234");
//		m.setUserName("관리자");
//		m.setEmail("minhee@admin.co.kr");
//		m.setTel("01012341234");
//		m.setPostcode("06100");
//		m.setAddress("서울시");
//		m.setDetailAddress("논현동");
//		m.setType(0);
//		
//		// 기재된 정보를 가지고 회원가입을 진행한다
//		sqlSession.insert("MemberMapper.insertItem", m);
//		// 생성된 PrimaryKey 조회
//		System.out.println("%%% P K %%%" + m.getId());
//		// PK값을 이용해 생성된 회원의 정보를 조회
//		Member output = sqlSession.selectOne("MemberMapper.selectItem", m);
//		// 회원 조회 결과를 문자열로 보여준다
//		System.out.println(output.toString());
//	}
	
	/** 회원 조회 테스트 */
//	@Test
//	public void testB() {
//		Member m = new Member();
//		m.setId(1);
//		
//		// PK값을 이용해 회원의 정보를 조회
//		Member output = sqlSession.selectOne("MemberMapper.selectItem", m);
//		System.out.println(output.toString());
//	}
	
	/** 회원 탈퇴 테스트 */
//	@Test
//	public void testC() {
//		Member m = new Member();
//		m.setId(3);
//		
//		// PK값을 이용해 회원 탈퇴를 진행
//		sqlSession.delete("MemberMapper.deleteItem", m);
//		
//		sqlSession.selectOne("MemberMapper.selectItem", m);
//	}
	
	/** 회원 정보 수정 테스트 */
//	@Test
//	public void testD() {
//		Member m = new Member();
//		m.setId(2);
//		m.setUserId("updatetest");			// 수정 불가
//		m.setUserPw("9876");
//		m.setUserName("안녕하세요");
//		m.setEmail("test@test.co.kr");		// 수정 불가
//		m.setTel("01098769876");
//		m.setPostcode("12345");
//		m.setAddress("개발시");
//		m.setDetailAddress("테스트동");
//		m.setType(7);
//		
//		// 회원 수정을 진행
//		sqlSession.update("MemberMapper.updateItem", m);
//		// 조회
//		sqlSession.selectOne("MemberMapper.selectItem", m);
//	}

	/** 로그인 테스트 */
//	@Test
//	public void testE() {
//		Member m = new Member();
//		m.setUserId("user1");
//		m.setUserPw("1234");
//
//		// 로그인 진행
//		Member output = sqlSession.selectOne("MemberMapper.login", m);
//		
//		if (output == null) {
//			// 정보가 틀리거나 없는 회원인 경우
//			System.out.println("로그인 실패");
//			// 강제 종료
//			return;
//		}
//		
//		// 아웃풋이 있다면 로그인 시각 갱신
//		sqlSession.update("MemberMapper.updateLoginDate", output);
//		
//		if (output.getType() == 0) {
//			System.out.println("환영합니다 관리자님");
//		} else if (output.getType() == 9) {
//			System.out.println("탈퇴한 회원입니다");
//		} else {
//			System.out.println("환영합니다 " + output.getUserName() + "님");
//		}
//	}
	
	/** 비밀번호 재발급 테스트 */
	@Test
	public void testF() {
		
		System.out.println(webHelper.getTempPassword(6));
		
//		String newPw = webHelper.getTempPassword(6);
//		System.out.println("재발급된 비밀번호: " + newPw);
//		
//		Member m = new Member();
//		m.setUserId("parkpie");
//		m.setUserName("박파이");
//		m.setEmail("pie@love.forever");
//		m.setUserPw(newPw);
//		
//		sqlSession.update("MemberMapper.pwFind", m);
	}
	
}
