package com.spring.wtm.controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.spring.wtm.helper.PageData;
import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Member;
import com.spring.wtm.service.MemberService;

import lombok.extern.slf4j.Slf4j;

/**
 * @filename		: UserRestController.java
 * @description	: Restful API
 * @Date			: 2020. 9. 22. 
 * @author			: 오 혜 진 (clia315@gmail.com)
 */
@Slf4j
@RestController
public class UserRestController {
    /** WebHelper 주입 */
    @Autowired  WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired  RegexHelper regexHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired  MemberService memberService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
     
    /** ID 조회 action 페이지 */
    @ResponseBody		// 해당 어노태이션은 print를 그대로 출력할 수 있도록 해준다
    @RequestMapping(value = "/login/id_unique", method = RequestMethod.POST)
    public void idCheck(HttpServletResponse response,
			@RequestParam(value = "userId", required = false) String userId) {
    	String status = null;
    	
		/** 1) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Member input = new Member();
		input.setUserId(userId);
		
		/** 2) 중복검사시 null 값이면 통과이다. */
		Member output = null;
		try {
			output = memberService.idCheck(input);
			// 조회결과가 없으면 exception발생. => 값은 true
		} catch (Exception e) { status = "true"; }
		
		/** 3) 존재하는 ID인 경우 false 출력 */		
		if (output != null) { status = "false"; }
		
		try { response.getWriter().print(status); } 
		catch (IOException e) { log.error(e.getLocalizedMessage()); }
    }
    
    /** EMAIL 조회 action 페이지 */
    @ResponseBody		// 해당 어노태이션은 print를 그대로 출력할 수 있도록 해준다
    @RequestMapping(value = "/login/email_unique", method = RequestMethod.POST)
    public void emailCheck(HttpServletResponse response,
			@RequestParam(value = "email", required = false) String email) {
    	String status = null;
    	
		/** 1) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Member input = new Member();
		input.setEmail(email);
		
		/** 2) 중복검사시 null 값이면 통과이다. */
		Member output = null;
		try {
			output = memberService.emailCheck(input);
			// 조회결과가 없으면 exception발생. => 값은 true
		} catch (Exception e) { status = "true"; }
		
		/** 3) 존재하는 email인 경우 false 출력 */		
		if (output != null) { status = "false"; }
		
		try { response.getWriter().print(status); } 
		catch (IOException e) { log.error(e.getLocalizedMessage()); }
    }
    
    /** TEL 조회 action 페이지 */
    @ResponseBody		// 해당 어노태이션은 print를 그대로 출력할 수 있도록 해준다
    @RequestMapping(value = "/login/tel_unique", method = RequestMethod.POST)
    public void telCheck(HttpServletRequest request ,HttpServletResponse response,
			@RequestParam(value = "tel", required = false) String tel) {
    	// 휴대폰 번호에서 특수문자를 제거한다.
    	tel = tel.replace("-", "");
    	// 로그인 식별
		HttpSession session = request.getSession();
		Member loginInfo = (Member) session.getAttribute("memInfo");
    	
    	String status = null;
    	
		/** 1) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Member input = new Member();
		input.setTel(tel);
		
		/*
		 * 로그인한 경우
		 * 1) 아이디가 같고 전화번호가 같은 경우 -> true
		 * 2) 아이디가 다르고 전화번호가 같은 경우 -> false
		 */
		if (loginInfo != null) {
			// 로그인 정보가 존재하는경우 sql문에 거를 id값을 넣어준다.
			input.setUserId(loginInfo.getUserId());			
		}
		
		/** 2) 중복검사시 null 값이면 통과이다. */
		Member output = null;
		try {
			output = memberService.telCheck(input);
			// 조회결과가 없으면 exception발생. => 값은 true
		} catch (Exception e) { 
			System.out.println("사용중인 휴대폰 번호");
			status = "true"; }
		
		/** 3) 존재하는 tel인 경우 false 출력 */		
		if (output != null) { status = "false"; }
		
		try { response.getWriter().print(status); } 
		catch (IOException e) { log.error(e.getLocalizedMessage()); }
    }
    
	/** [열람 목적] 회원 목록 페이지 */
    @RequestMapping(value = "/member", method = RequestMethod.POST)
    public Map<String, Object> get_list(
			// 검색어 (중복이 되서는 안되는 값: 회원 id, email, tel)
			@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "tel", required = false) String tel,
			// 페이지 구현에서 사용할 현재 페이지 번호
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {	
		/** 1) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0;				// 전체 회원 수
		int listCount = 10;				// 한 페이지당 표시할 목록 수
		int pageCount = 5;				// 한 그룹당 표시할 페이지 번호 수
		
		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Member input = new Member();
		input.setUserId(userId);
		input.setEmail(email);
		input.setTel(tel);
		
		List<Member> output = null;	// 조회결과가 저장될 객체
		PageData pageData = null;
		
		try {
			// 전체 회원 수 조회
			totalCount = memberService.getMemberCount(input);
			// 페이지 번호 계산 --> 계산 결과를 로그로 출력할 것이다
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);
			
			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Member.setOffset(pageData.getOffset());
			Member.setListCount(pageData.getListCount());
			
			// 데이터 조회하기
			output = memberService.getMemberList(input);
		} catch (Exception e) {
			/** 목록 조회 기능 구현하기
			 * 예외 발생시 메시지 처리 방법 수정
			 * --> 웹 페이지 이동을 위한 redirect() 호출 부분을 JSON 형식의 에러 메시지 출력으로 변경 */
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		
		/** View 처리 부분을 JSON 출력 형식으로 수정
		 * Restful은 스스로 UI를 갖는 형식이 아니기 때문에 View를 사용하지 않는다 */
		/** 3) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("userId", userId); 
		data.put("email", email); 
		data.put("tel", tel); 
		data.put("item", output);
		data.put("meta", pageData);
		
		log.debug("");
		return webHelper.getJsonData(data);
    }
}
