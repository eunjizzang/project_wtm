package com.spring.wtm.controllers;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.RetrofitHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Member;
import com.spring.wtm.service.CovidConfirmService;
import com.spring.wtm.service.CovidRegionService;
import com.spring.wtm.service.MemberService;

import lombok.extern.slf4j.Slf4j;

/**
 * @filename		: HomeController.java
 * @description	: view 파일 밑에 바로 속해 있는 jsp 파일 컨트롤러
 * @Date			: 2020. 9. 11. 
 * @author			: 오 혜 진 (clia315@gmail.com)
 */
@Slf4j
@Controller
public class HomeController {
	
	/** WebHelper 주입 */ 
    @Autowired WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    @Autowired RetrofitHelper retrofitHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired CovidConfirmService confirmService;
    @Autowired CovidRegionService regionService;
    @Autowired  MemberService memberService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
	
	/**
	 * 메인 페이지 (index.jsp)
	 * @param locale
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response) {
		log.debug("Local : " + locale.getLanguage());			// 언어코드
		log.debug("Local : " + locale.getCountry());			// 국가코드
		log.debug("Local : " + locale.getDisplayLanguage());	// 언어이름
		log.debug("Local : " + locale.getDisplayCountry());		// 국가이름
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	/**
	 * 탈퇴 완료 페이지 (thanks.jsp)
	 * @return
	 */
	@RequestMapping(value = "/thanks", method = RequestMethod.POST)
	public String thanks(HttpServletRequest request) {
		
		// request 객체를 사용해서 세션 객체 만들기
		HttpSession session = request.getSession();
		// 로그인 정보 확인하여 회원 탈퇴 진행
		Member memInfo = (Member) session.getAttribute("memInfo");
		
		Member input = new Member();
		input.setId(memInfo.getId());
		
		try {
			// 회원 탈퇴
			memberService.deleteMember(input);
		} catch (Exception e) {
			// 탈퇴가 성공적으로 이뤄지지 않을 경우 이전(수정)페이지로 돌아간다
			log.error(e.getLocalizedMessage());
			String referer = request.getHeader("referer");
    		return "redirect:" + referer;
		}
		
		// 로그인 정보 삭제 -> 로그아웃 상태
		// 탈퇴가 이루어진다면 모든 세션값을 삭제하고 돌아가기
		session.invalidate();
		
		/** View 이름 리턴 */
		// 프로그램 제어가 View에게로 넘어간다
		return "thanks";
	}

	/**
	 * 캘린더 페이지 (calendar.jsp)
	 * @return
	 */
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendar() {
		
		return "calendar";
	}
	
}
