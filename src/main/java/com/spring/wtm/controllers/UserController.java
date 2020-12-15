package com.spring.wtm.controllers;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.spring.wtm.helper.MailHelper;
import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Member;
import com.spring.wtm.service.MemberService;

import lombok.extern.slf4j.Slf4j;

/**
 * @filename		: UserController.java
 * @description	: view/user 파일 밑에 바로 속해 있는 jsp 파일 컨트롤러
 * @Date			: 2020. 9. 11. 
 * @author			: 오 혜 진 (clia315@gmail.com)
 */
@Slf4j
@Controller
public class UserController {
    /** WebHelper 주입 */
    @Autowired  WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired  RegexHelper regexHelper;
    
    /** MailHelper 주입 */
	@Autowired MailHelper mailHelper;
	
	@Autowired KakaoLogin kakaologin;

    /** Service 패턴 구현체 주입 */
    @Autowired  MemberService memberService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
    
	/** 로그인 페이지 (login.jsp) */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpSession session, HttpServletRequest request) {
		ModelAndView login = new ModelAndView();
		
		// 카카오톡 로그인을 위해 full url을 전달한다 (request.getRequestURL().toString())
		String kakaoUrl = kakaologin.getAuthorizationUrl(session, request.getRequestURL().toString());

		login.setViewName("user/login");
		// jsp에서 작성된 url 값을 활용하기 위해 추가
		login.addObject("kakao_url", kakaoUrl);
		
		return login; 
	}
	
	/** 카카오 로그인 (action) */
	@RequestMapping(value = "/login/kakao.do" , produces = "application/json", method = {RequestMethod.GET, RequestMethod.POST})
	public String kakao(@RequestParam("code") String code, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		/* 1) 사용자 토큰값 가져오기 */
		JsonNode token = kakaologin.getAccessToken(code);
		
		/* 2) 토큰값을 통해 사용자 정보 가져오기 */
		JsonNode profile = kakaologin.getKakaoUserInfo(token.path("access_token").toString());
		System.out.println(profile);
		
		/* 3) 사용자 정보를 회원 정보를 갖고 있는 Beans에 담기 */
		Member kakaoMemeber = kakaologin.changeData(profile);
		kakaoMemeber.setUserId("k"+kakaoMemeber.getUserId());
		System.out.println(kakaoMemeber);
		
		/* 4) 로그인 정보를 session값으로 저장 */
		System.out.println(session);
		session.setAttribute("login", kakaoMemeber);
		System.out.println(kakaoMemeber.toString());
		
		/* 5) 로그인 */
		//kakaoMemeber = memberService.kakaoLogin(kakaoMemeber);  
		return "user/kakao";
	}

    /** 로그인 페이지에 대한 action 페이지 */
    @RequestMapping(value = "/login/login_ok.do", method = RequestMethod.POST)
    public ModelAndView login_ok(Model model, HttpServletRequest request, HttpServletResponse response,
    		@RequestParam(value="user_id", required=false) String userId,
            @RequestParam(value="user_pw", required=false) String userPw,
            @RequestParam(value="save_uid", required=false) String saveId) {
        System.out.println("체크박스 체크 여부 "+ saveId);
    	/* (쿠키) 아이디저장 체크박스가 선택되었다면 value 속성을 받아온다
   		   아이디, 비밀번호 일치 전 실행되는 함수이므로 로그인에 실패가 되어도 상태는 저장된다 */
    	if (saveId != null) {
            System.out.println("체크박스값: "+ saveId);

    		// 아이디 값 저장하는 쿠키 생성
    		Cookie cookie = new Cookie("save_uid", userId);
    		// 쿠키 설정 세팅 및 저장
    		cookie.setMaxAge(60*60*24*7);		// 1주일 유효
    		cookie.setPath("/");				// 모든 경로 유효
    		// 1) (테스트) 윈도우 쿠키 생성 위치
    		cookie.setDomain("localhost");		
    		// 2) (배포용) 리눅스 쿠키 생성 위치
//    		cookie.setDomain("itproject.ezenac.co.kr");		
//    		cookie.setDomain("192.168.59.128");		
    		response.addCookie(cookie);
    	} else {
    		Cookie cookie = new Cookie("save_uid", null);
    		cookie.setMaxAge(-1);				// 즉시 만료
    		cookie.setPath("/");
    		// 1) (테스트) 윈도우 쿠키 생성 위치
    		cookie.setDomain("localhost");
    		// 2) (배포용) 리눅스 쿠키 생성 위치
//    		cookie.setDomain("itproject.ezenac.co.kr");
//    		cookie.setDomain("192.168.59.128");		
    		response.addCookie(cookie);
    	}
    	
        /** 1) 사용자가 입력한 파라미터에 대한 유효성 검사 */
        // 이전페이지(가입작성 페이지)로 강제 리턴
        if (userId.equals(""))              { return webHelper.redirect(null, "아이디를 입력하세요."); }
        if (userPw.equals(""))              { return webHelper.redirect(null, "비밀번호를 입력하세요."); }

        /** 2) 로그인 처리하기 */
        // 조회할 값들을 Beans에 담는다.
        Member input = new Member();
        input.setUserId(userId);
        input.setUserPw(userPw);

        Member output = null;
        
        try {
            // 로그인 처리 (데이터 조회)
            output = memberService.login(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
	    /** 3) 세션 저장하기 */
        
		// request 객체를 사용해서 세션 객체 만들기
		HttpSession session = request.getSession();
		
		// 세션 유효시간 설정 (한시간)
		session.setMaxInactiveInterval(60*60);
		
		// 조회된 데이터가 존재한다면 로그인 정보를 세션값에 저장한다
		if(output != null) {
			session.setAttribute("memInfo", output);
        }
        
        /** 4) 로그인 성공적으로 이루어지면 메인페이지 (혹은 이전페이지로) 돌아간다. */
        return webHelper.redirect(contextPath, null);
    }
    
    /** 로그아웃 페이지에 대한 action 페이지 */
    @RequestMapping(value = "/login/logout.do", method = RequestMethod.GET)
    public String logout(HttpSession session, HttpServletRequest request) {
    	/** 1) 세션 삭제하기 */
    	// 로그인 정보 삭제
    	session.setAttribute("memInfo", null);
    	session.setMaxInactiveInterval(0);
		session.invalidate();
		
		/** 2) */
	    //TODO 로그인상태유지(가 되어있다면) 해제하고 DB(세션, 타임스탬프) update

		/** 3) 로그아웃이 성공적으로 이루어지면 이전페이지로 돌아간다. Spring방식의 페이지 이동 */
		return "redirect:/";
	}
	
	/** 아이디 찾기 페이지 (find-id1.jsp) */
	@RequestMapping(value = "/login/find-id1.do", method = RequestMethod.GET)
	public ModelAndView findId1() {
		
		return new ModelAndView("user/find-id1"); 
	}
	
	/** 아이디 찾기 action 페이지 (find-id2.jsp) */
	@RequestMapping(value = "/login/find-id2.do", method = RequestMethod.POST)
	public ModelAndView findId2(Model model, 
            @RequestParam(value="name", required=false) String userName,
            @RequestParam(value="email", required=false) String email) {
		
		/** 1) 사용자가 입력한 파라미터에 빈값 검사 */
        if (userName.equals(""))            { return webHelper.redirect(null, "이름을 입력하세요."); }
        if (email.equals(""))               { return webHelper.redirect(null, "이메일을 입력하세요."); }

		/** 2) 데이터 조회 */
        Member input = new Member();
        input.setUserName(userName);
        input.setEmail(email);
        
        // 조회 완료된 값을 저장하기 위한 객체
        Member output = null;
        
        try {
        	// 회원 데이터 조회 성공시 output에 id값+가입일시가 저장된다.
			output = memberService.idFind(input);
		} catch (Exception e) {
            return webHelper.redirect(null, "일치하는 회원 정보가 존재하지 않습니다.");
		}
        
        /** 3) View 처리 */
		model.addAttribute("output", output);
		model.addAttribute("input", input);
		
		return new ModelAndView("user/find-id2"); 
	}
	
	/** 비밀번호 찾기 페이지 (find-pw.jsp) */
	@RequestMapping(value = "/login/find-pw.do", method = RequestMethod.GET)
	public ModelAndView findPw(Model model, @RequestParam(value = "name", required = false) String name) {
		
		if (name == null || name.equals("")) { }
		else {	// url parameter가 존재할 경우에는 (한글)디코딩 작업이 필요하다
			try { name = URLDecoder.decode(name, "utf-8"); }
			catch (UnsupportedEncodingException e) { e.printStackTrace(); }
			model.addAttribute("name", name);
		}
		
		return new ModelAndView("user/find-pw"); 
	}
	
	/** action 페이지 */
	@RequestMapping(value = "/login/mail.do", method = RequestMethod.POST)
	public ModelAndView send(@RequestParam(defaultValue = "") String name,
			@RequestParam(value="user_id" ,defaultValue = "") String id,
			@RequestParam(defaultValue = "") String email) {	
		/** 1) 입력여부 검사 후, 입력되지 않은 경우 이전 페이지로 보내기 */
		// 받는 메일주소 입력여부 확인
		if (!regexHelper.isValue(email)) { return webHelper.redirect(null, "이메일을 입력해주세요."); }
		// 받는 메일 주소 형식검사
		if (!regexHelper.isEmail(email)) { return webHelper.redirect(null, "이메일 주소가 아닙니다."); }
		
		/** 2) 데이터 조회 및 수정하기 */
		// 1 - 메일 중복검사를 통해 등록된 회원인지 확인
		// 2 - 입력값을 검사하여 일치하는 회원이면 새로운 비밀번호로 업데이트후 메일발송
		Member input = new Member();
		input.setEmail(email);
		input.setUserId(id);
		input.setUserName(name);
		String newPw = webHelper.getTempPassword(6);
		input.setUserPw(newPw);
		try {
			memberService.pwFind(input);
		} catch (Exception e) {
			return webHelper.redirect(null, "임시 비밀번호 발급에 실패했습니다. 회원정보를 확인해 주세요.");
		}

		// 메일 제목과 내용
		String subject = "[이거모약] 임시비밀번호 발급 안내";
		String content = "<h1 style='text-align: center;'>"
				+ "<img style='display: block; margin-left: auto; margin-right: auto;' "
				+ "src='https://postfiles.pstatic.net/MjAyMDEwMDVfMTYy/MDAxNjAxODMzMjg0MjY2.vhmhP4f0aVw4Ba6Vw1mu_9hvQOwISYnz3t2Ox9Ax0s0g.CGvrm3q34FLO4HpXO_3CL8kFLflErJwb9afBqNjBxtcg.PNG.sky_a1/logo.png?type=w773' alt=' width='174' height='106' />"
				+ "임시 비밀번호 발급 안내</h1>"+
				"<p style='text-align: center;'><strong><span style='font-size: 20px;'>" + 
				"<strong><span style='color: rgb(41, 105, 176);'>" + 
				name +" 회원님의 임시 비밀번호 안내 메일입니다." + 
				"</span></strong></span></strong></p>\n" + 
				"<p style='text-align: center;'><br></p>\n" + 
				"<h2 style='text-align: center;'>비밀번호 ["+ newPw +"]</h2>\n" + 
				"<h2 style='text-align: center;'>" + 
				"보안을 위해 접속후 비밀번호를 즉시 변경하여 주시기 바랍니다.</h2>\n" + 
				"<p style='text-align: center;'><br></p>\n" + 
				"<p style='text-align: center;'><br></p>\n" + 
				"<hr style='width: 70%; text-align: center;'>\n" + 
				"<p style='text-align: center;'><span style='font-size: 15px;'>" + 
				"본 메일은 발신 전용 메일입니다.</span></p>\n" +
				"<p style='text-align: center;'><span style='font-size: 15px;'>" + 
				"재발급된 비밀번호의 유효시간은 30분 입니다. 유효시간이 지나면 다시 비밀번호를 발급받아 로그인해 주시기 바랍니다.</span></p>";
		
		/** 3) 메일 발송 처리 */
		try {
			mailHelper.sendMail(email, subject, content);
		} catch (Exception e) {
			log.error("메일 발송 실패: " + e.getLocalizedMessage());
			return webHelper.redirect(null, "메일 발송에 실패했습니다.");
		}
		
		/** 4) 재발급 테이블에 회원PK 및 reg_date추가 */
		// --> 스케줄러에서 삭제시 회원타입을 변경한다(임시회원-로그인블럭상태로)
		
		/** 결과 처리 */
		return webHelper.redirect(null, "임시 비밀번호를 보냈습니다.");
	}

	/** 회원가입(전) 동의 페이지 (join-agree.jsp) */
	@RequestMapping(value = "/login/join-agree.do", method = RequestMethod.GET)
	public ModelAndView joinAgree() {
		
		return new ModelAndView("user/join-agree"); 
	}
	
	/** 회원가입 페이지 (join.jsp) */
	@RequestMapping(value = "/login/join.do", method = RequestMethod.POST)
	public ModelAndView join() {
		// 동의페이지를 통해서만 접근이 가능한 페이지
		return new ModelAndView("user/join"); 
	}
	
    /** 회원가입 양식에 대한 action 페이지 */
	// TODO 중복 검사하기 ( ajax: uid, email, tel )
    @RequestMapping(value = "/login/join_ok.do", method = RequestMethod.POST)
    public ModelAndView add_ok(Model model,
    		@RequestParam(value="user_id", required=false) String userId,
            @RequestParam(value="user_pw", required=false) String userPw,
            @RequestParam(value="user_name", required=false) String userName,
            @RequestParam(value="email", required=false) String email,
            @RequestParam(value="tel", required=false) String tel,
            @RequestParam(value="postcode", required=false) String postcode,
            @RequestParam(value="address", required=false) String address,
            @RequestParam(value="detailAddress", required=false) String detailAddress,
            @RequestParam(value="extraAddress", required=false) String extraAddress) {
    	
    	// 휴대폰 번호에서 특수문자를 제거한다.
    	tel = tel.replace("-", "");
        
        /** 1) 사용자가 입력한 파라미터에 대한 유효성 검사 */
        // 이전페이지(가입작성 페이지)로 강제 리턴
        if (userId.equals(""))              { return webHelper.redirect(null, "아이디를 입력하세요."); }
        if (!regexHelper.isEngNum(userId))  { return webHelper.redirect(null, "아이디는 영어와 숫자로만 가능합니다."); }
        if (userPw.equals(""))              { return webHelper.redirect(null, "비밀번호를 입력하세요."); }
        if (userName.equals(""))            { return webHelper.redirect(null, "이름을 입력하세요."); }
        if (!regexHelper.isKor(userName))   { return webHelper.redirect(null, "이름은 한글만 가능합니다."); }
        if (email.equals(""))               { return webHelper.redirect(null, "이메일을 입력하세요."); }
        if (!regexHelper.isEmail(email))    { return webHelper.redirect(null, "잘못된 이메일 형식입니다."); }
        if (tel.equals(""))                 { return webHelper.redirect(null, "휴대폰번호를 입력하세요."); }
        if (!regexHelper.isPhone(tel)) 		{ return webHelper.redirect(null, "잘못된 휴대폰번호 형식입니다."); }
        if (postcode.equals(""))            { return webHelper.redirect(null, "우편번호를 입력하세요."); }
        if (address.equals(""))             { return webHelper.redirect(null, "주소를 입력하세요."); }
        if (detailAddress.equals(""))       { return webHelper.redirect(null, "상세주소를 입력하세요."); }

        /** 2) 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Member input = new Member();
        input.setUserId(userId);
        input.setUserPw(userPw);
        input.setUserName(userName);
        input.setEmail(email);
        input.setTel(tel);
        input.setPostcode(postcode);
        input.setAddress(address);
        input.setDetailAddress(detailAddress);
        input.setExtraAddress(extraAddress);
        input.setType(1);						// 일반회원 = 1

        try {
            // 데이터 저장
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            memberService.addMember(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }

        /** 3) 회원가입이 성공적으로 이루어지면 로그인페이지로 돌아간다. */
        String redirectUrl = contextPath + "/login";
        return webHelper.redirect(redirectUrl, "이거모약 회원가입 완료.");
    }
	
	/** 마이페이지 - 회원정보 수정(전) 비밀번호 기입 페이지 (update-pw.jsp) */
	@RequestMapping(value = "/mypage/update-pw.do", method = RequestMethod.GET)
	public ModelAndView updatePw() {

		return new ModelAndView("user/update-pw"); 
	}
	
	/**
	 * 비밀번호 입력 페이지에 대한 action 페이지
	 * 로그인된 상태로만 접근 가능하므로 로그인처리 로직을 통해 회원정보 일치 여부를 조회한다.
	 */
	@RequestMapping(value = "/mypage/update-pw_ok.do", method = RequestMethod.POST)
	public String pw_ok(Model model, HttpServletRequest request, RedirectAttributes redirect,
            @RequestParam(value="user_pw", required=false) String userPw) {
		
		// 로그인 정보를 판별하기 위한 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 로그인 정보를 담은 세션값 가져오기
		Member memInfo = (Member) session.getAttribute("memInfo");
		
		// 사용자가 입력한 비밀번호가 맞는지 조회하기 위해 로그인 처리 로직을 이용
		Member input = new Member();
		input.setUserId(memInfo.getUserId());		// 세션값을 통해 id 값을 가져온다.
		input.setUserPw(userPw);					// 입력값을 가져온다. (password)
        
        try {
            // 로그인 처리 (세션 정보를 통해 비밀번호 일치 여부 조회)
        	memberService.login(input);
        } catch (Exception e) {
        	// 비밀번호가 틀릴 경우 이전에 머물렀던 페이지(사용자 입장에선 새로고침 효과)
    		String referer = request.getHeader("referer");
    		return "redirect:" + referer;
        }
        
        //알맞은 비밀번호를 입력했을 경우 마이페이지로 이 값을 넘긴다.
        redirect.addFlashAttribute("originPw", userPw);
        System.out.println("[TEST]origin pw(not md5) : " + userPw);

        /** 회원정보 수정으로 이동. */
		return "redirect:/mypage/update.do";
    }
	
	/** 마이페이지 - 회원정보 페이지 (update.jsp) */
	@RequestMapping(value = "/mypage/update.do", method = RequestMethod.GET)
	public ModelAndView update() {
		
		return new ModelAndView("user/update"); 
	}	
	
    /** 회원수정 양식에 대한 action 페이지 */
	// 비밀번호 update 로직 개선 --> 해결!
    @RequestMapping(value = "/mypage/update_ok.do", method = RequestMethod.POST)
    public ModelAndView edit_ok(Model model, HttpServletRequest request,
            @RequestParam(value="user_pw", required=false) String userPw,
            @RequestParam(value="user_name", required=false) String userName,
            @RequestParam(value="tel", required=false) String tel,
            @RequestParam(value="postcode", required=false) String postcode,
            @RequestParam(value="address", required=false) String address,
            @RequestParam(value="detailAddress", required=false) String detailAddress,
            @RequestParam(value="extraAddress", required=false) String extraAddress) {

		// 로그인 정보를 판별하기 위한 세션 객체 생성
		HttpSession session = request.getSession();
		
		// 로그인 정보를 담은 세션값 가져오기
		Member memInfo = (Member) session.getAttribute("memInfo");
		
    	// 휴대폰 번호에서 특수문자를 제거한다.
    	tel = tel.replace("-", "");
        
        /** 1) 사용자가 입력한 파라미터에 대한 유효성 검사 */
        // 이전페이지(가입작성 페이지)로 강제 리턴
        if (userName.equals(""))            { return webHelper.redirect(null, "이름을 입력하세요."); }
        if (!regexHelper.isKor(userName))   { return webHelper.redirect(null, "이름은 한글만 가능합니다."); }
        if (tel.equals(""))                 { return webHelper.redirect(null, "휴대폰번호를 입력하세요."); }
        if (!regexHelper.isPhone(tel)) 		{ return webHelper.redirect(null, "잘못된 휴대폰번호 형식입니다."); }
        if (postcode.equals(""))            { return webHelper.redirect(null, "우편번호를 입력하세요."); }
        if (address.equals(""))             { return webHelper.redirect(null, "주소를 입력하세요."); }
        if (detailAddress.equals(""))       { return webHelper.redirect(null, "상세주소를 입력하세요."); }

        // 만약 비밀번호를 입력하지 않았다면? -> 기존의 비밀번호를 유지한다.
        // (암호화된 상태이므로 .. update-pw에서 부터 상태 유지를 통해 값을 가져와야함?)
        if (userPw.equals(""))              { 
        	userPw = memInfo.getUserPw();
        } else {
        	
        }
        
        /** 2) 데이터 수정하기 */
		
        // 저장할 값들을 Beans에 담는다.
        Member input = new Member();
        input.setId(memInfo.getId());				// 세션값을 통해 PK 값을 가져온다.
		input.setUserId(memInfo.getUserId());		// 세션값을 통해 user_id 값을 가져온다.
        input.setType(memInfo.getType());			// 세션값을 통애 회원 유형 값을 가져온다.
        input.setUserPw(userPw);
        input.setUserName(userName);
        input.setTel(tel);
        input.setPostcode(postcode);
        input.setAddress(address);
        input.setDetailAddress(detailAddress);
        input.setExtraAddress(extraAddress);

        // 세션갱신을 위해 결과를 담을 객체를 빈값으로 생성한다.
        Member output = null;
        
        try {
            // 데이터 수정
            memberService.editMember(input);
            
            // 데이터 갱신을 위해 수정이 완료된 값으로 조회
            output = memberService.getMemberItem(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        // 수정 완료 후 세션 갱신 --> ㅠㅠ 비효율적인거같은데
		// 세션 유효시간 설정 (한시간)
		session.setMaxInactiveInterval(60*60);
		// 조회된 데이터가 존재한다면 로그인 정보를 세션값에 저장한다.
		if(output != null) { session.setAttribute("memInfo", output); }

        /** 3) 회원수정이 성공적으로 이루어지면 마이페이지로 돌아간다. */
        String redirectUrl = contextPath + "/mypage";
        return webHelper.redirect(redirectUrl, null);
    }
	
}
