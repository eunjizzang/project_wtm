package com.spring.wtm.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Member;

import lombok.extern.slf4j.Slf4j;
import uap_clj.java.api.Browser;
import uap_clj.java.api.Device;
import uap_clj.java.api.OS;

@Slf4j
public class AppInterceptor extends HandlerInterceptorAdapter {
	// 전역변수로 두 개의 시간 값을 선언한다
	long startTime = 0, endTime = 0;
	
	/** WebHelper 객체 주입 */
	@Autowired
	WebHelper webHelper;
	
	/**
	 * Controller 실행 요청 전에 수행되는 메서드.
	 * 클라이언트의 요청을 컨트롤러에 전달하기 전에 호출된다.
	 * return 값으로 boolean 값을 전달하는데 false인 경우 controller를 실행시키지 않고 요청을 종료한다.
	 * 보통 이곳에서 각종 체크업과 로그를 기록하는 작업을 진행한다.
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// log.debug("AppInterceptor.preHandle 실행됨");
		
		// WebHelper의 초기화는 모든 컨트롤러마다 개별적으로 호출되어야 한다.
		// Inperceptor에서 이 작업을 수행하면 모든 메서드마다 수행하는 동일 작업을 일괄처리 할 수 있다.
		// webHelper가 초기화 되어야 인코딩등이 안깨짐!
		webHelper.init(request, response);
		
//		log.debug("컨트롤러 실행 전 >> AppInterceptor.preHandle 실행");
		// 컨트롤러 실행 전에 현재 시각을 저장
		startTime = System.currentTimeMillis();
		
		/** 1) 클라이언트의 요청 정보 확인하기 */
		// 현재 URL 획득
		String url = request.getRequestURI().toString();
		
		// GET, POST 방식 조회
		String methodName = request.getMethod();
		
		// URL에서 "?"이후에 전달되는 GET 파라미터 문자열을 모두 가져옴
		String queryString = request.getQueryString();
		
		// 가져온 값이 있다면 URL과 결합하여 완전한 URL 구성
		if (queryString != null) {
			url = url + "?" + queryString;
		}
		
		// 획득 정보 로그로 표시
		log.debug(String.format("[%s방식] URL: %s", methodName, url));
		
		/** 2) 클라이언트가 전달한 모든 파라미터 확인하기 */
		Map<String, String[]> params = request.getParameterMap();
		
		for (String key : params.keySet()) {
			String[] value = params.get(key);
			log.debug(String.format("(파라미터) <-- %s = %s", key, String.join(",", value)));
		}
		
		/** 3) 클라이언트가 머물렀던 이전 페이지와 이전 페이지에 머문 시간 확인하기 */
		// 이전에 머물렀던 페이지
		String referer = request.getHeader("referer");
		
		// 이전 종료 시간이 0보다 크다면 새로운 시작시간과의 차이는 이전 페이지에 머문 시간을 의미한다
		if (referer != null && endTime > 0) {
			log.debug(String.format(" - REFERER : 머문 시간=%d(ms), 머문 페이지=%s", (startTime-endTime), referer));
		}
		
		/** 4) 접속한 클라이언트의 장치 정보를 로그로 기록 */
		// 접근한 클라이언트의 HTTP 헤더 정보 가져오기
		String ua = request.getHeader("User-Agent");
		
		// "uap" 라이브러리의 기능을 통해 UserAgent 정보 파싱
		Map<String, String> browser = Browser.lookup(ua);
		Map<String, String> os = OS.lookup(ua);
		Map<String, String> device = Device.lookup(ua);
		
		// 추출된 정보들을 출력하기 위해 문자열로 묶기
		String browserStr = String.format("- Browser: {family=%s, patch=%s, major=%s, minor=%s}",
				browser.get("family"), browser.get("patch"), browser.get("major"), browser.get("minor"));
		String osStr = String.format("- OS: {family=%s, patch=%s, patch_minor=%s, major=%s, minor=%s}",
				os.get("family"), os.get("patch"), os.get("patch_minor"), os.get("major"), os.get("minor"));
		String deviceStr = String.format("- Device: {family=%s, model=%s, brand=%s}",
				device.get("family"), device.get("model"), device.get("brand"));
		
		// 로그 저장
		log.debug(browserStr);
		log.debug(osStr);
		log.debug(deviceStr);
		
		/** 로그인 체크 - 세션을 식별하기 위한 처리 */
		HttpSession session = request.getSession();
		// (로그인 성공한 member 정보)
		// 세션값 가져오기 - 로그인하는 사용자의 정보를 담고 있는 객체를 가져옴
		Member memInfo = (Member) session.getAttribute("memInfo");
		
		String[] loginUrlList;
		
		if (memInfo == null) {
			// 로그인 되지 않은 상태 
			log.debug(" - Login Member Info: null");
			// 해당 페이지 접속을 우회한다 (비정상 접근)
			// 마이페이지(전부), 관리자페이지(전부)
			// 로그인 해야만 접근할 수 있는 페이지 나열
			loginUrlList = new String[] {
					// 슬래시는 최상단 루트이므로 "/wtm/~~", 슬래시 없으면 wtm/"~~"부터
					/* 관리자 페이지 */
					"admin_main.do", "admin_goods.do", "admin_goodsint.do", "admin_goodsupt.do", "admin_members.do",
					/* 병원 + 예약관련 */
					"hospital/reserve.do", "reserve/add.do", "reserve/review.do", "reserve-2/write-review.do",
					"mypage/my-reserve.do", "my-reserve/reserve-1.do", "my-reserve/reserve-2.do", "review/detail.do", 
					/* 쇼핑 주문 관련 */
					"shop/order-form.do", "shop/order-complete.do", "mypage/order.do", "mypage/order-detail.do",
					/* 회원 관련 */
					"mypage", "mypage/update-pw.do", "mypage/update.do", "calendar"
			};
			for (String loginUrl : loginUrlList) {
				// 현재 url에 loginUrl이 포함되어 있다면?
				// -> 사용자가 접속한 현재 페이지가 내가 배열에 나열한 페이지 중 하나라면?
				if (url.indexOf(loginUrl) > -1) {
					log.debug("###로그아웃 상태 비정상 접근 페이지### [" + request.getContextPath() + "/" + loginUrl + "] 해당 페이지는 로그인이 필요한 페이지 입니다.");
					response.sendRedirect(request.getContextPath() + "/login");
					break;
				}
			}
		} else {
			// 로그인이 되었다면 로그 저장
			log.debug(" - Login Member Info: {id=" + memInfo.getUserId() + ", name=" + memInfo.getUserName() + "}");

			// 해당 페이지 접속을 우회한다
			// 로그인(관련)페이지 전부
			loginUrlList = new String[] {
					/* 회원가입, 아이디-비밀번호 찾기 관련 페이지 */
					"login/join-agree.do", "login/join.do",
					"login/find-id1.do", "login/find-id2.do", "login/find-pw.do"
			};
			for (String loginUrl : loginUrlList) {
				if (url.indexOf(loginUrl) > -1) {
					log.debug("###접속 상태 비정상 접근 페이지### [" + request.getContextPath() + "/" + loginUrl + "] 해당 페이지는 로그인 상태로 열람할 수 없습니다.");
					response.sendRedirect(request.getContextPath());
					break;
				}
			}
			
			// 관리자가 아닌 회원이 관리자 페이지에 접속한다면?
			if (memInfo.getType() > 0) {
				loginUrlList = new String[] {
						/* 관리자 페이지 */
						"admin_main.do", "admin_goods.do", "admin_goodsint.do", "admin_goodsupt.do", "admin_members.do"
				};
				for (String loginUrl : loginUrlList) {
					if (url.indexOf(loginUrl) > -1) {
						log.debug("###일반회원 접속 상태 비정상 접근 페이지### [" + request.getContextPath() + "/" + loginUrl + "] 해당 페이지는 일반 회원이 열람할 수 없습니다.");
						response.sendRedirect(request.getContextPath());
						break;
					}
				}
			}
		}
			
		return super.preHandle(request, response, handler);
	}

	/**
	 * 컨트롤러 실행 직후
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
//		log.debug("컨트롤러 실행 직후 >> AppInterceptor.postHandle 실행");
		// 컨트롤러 종료시의 시각을 가져옴
		endTime = System.currentTimeMillis();
		
		// 시작시간과 종료시간 사이의 차이를 구하면 페이지의 실행 시간을 알 수 있다
		log.debug(String.format("페이지 실행 시간 >> running time: %d(ms)\n", endTime-startTime));
		
		super.postHandle(request, response, handler, modelAndView);
	}

	/**
	 * 컨트롤러 종료 후 (제일 마지막 실행)
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		log.debug("컨트롤러 종료 후 >> AppInterceptor.afterCompletion 실행");
		super.afterCompletion(request, response, handler, ex);
	}

	/**
	 * 잘 사용 안함
	 */
	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("비동기 요청 >> AppInterceptor.afterConcurrentHandlingStarted 실행");
		super.afterConcurrentHandlingStarted(request, response, handler);
	}
	
}
