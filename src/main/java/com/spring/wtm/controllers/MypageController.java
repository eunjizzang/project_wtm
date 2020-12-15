package com.spring.wtm.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wtm.helper.PageData;
import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Calendar;
import com.spring.wtm.model.Member;
import com.spring.wtm.model.Order;
import com.spring.wtm.model.Reserve;
import com.spring.wtm.model.Review;
import com.spring.wtm.service.CalendarService;
import com.spring.wtm.service.HospitalService;
import com.spring.wtm.service.OrderService;
import com.spring.wtm.service.ReserveService;
import com.spring.wtm.service.ReviewService;

@Controller
public class MypageController {
	
	 /** WebHelper 주입 */
    @Autowired  WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired  RegexHelper regexHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired  ReviewService reviewService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  ReserveService reserveService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  CalendarService calendarService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  HospitalService hospitalService;
    
    @Autowired OrderService orderService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
	
	/**
	 * 마이페이지 
	 * @return
	 */
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public ModelAndView mypage(Model model, HttpSession session,
		 @SessionAttribute(value = "memInfo", required = false) Member member) {
		
		/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		
		if (member == null) { 
			return webHelper.redirect(null,"로그인해주세요."); 
		}
		
		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		
		// 주문내역
		Order input = new Order();
		// 예약내역
		Reserve input2 = new Reserve();
		// 일정
		Calendar input3 = new Calendar();
		
		if (member != null) {
		    input.setMemberId(member.getId());
		    input2.setMemberId(member.getId());
		    input3.setMid(member.getId());
		}

		// 조회 결과를 저장할 객체 선언
		// 주문내역
		List < Order > output = null;
		List < Reserve > output2 = null;
		List < Calendar > output3 = null;
		
		try {
		    // 주문 데이터 조회
		    output = orderService.getOrderList(input);
		    // 예약 데이터 조회
		    output2 = reserveService.getReserveList2(input2);
		    // 일정 데이터 조회
		    output3 = calendarService.getCalendarList(input3);
		} catch (Exception e) {
		    return webHelper.redirect(null, e.getLocalizedMessage());
		}

		/** 3) View 처리 */
		model.addAttribute("output", output);
		model.addAttribute("output2", output2);
		model.addAttribute("output3", output3);
		return new ModelAndView("mypage/mypage");				
	}
	
	/**
	 * 예약내역 페이지
	 * @return
	 */
	
	@RequestMapping(value = "/mypage/my-reserve.do", method = RequestMethod.GET)
	public ModelAndView myReserve(Model model,
			@SessionAttribute(value = "memInfo", required = false) Member member,
			@RequestParam(value="page", defaultValue="1") int nowPage)  {
		
		// 페이지 구현에 필요한 변수값 생성 
        int totalCount = 0;              // 전체 게시글 수
        int listCount  = 4;             // 한 페이지당 표시할 목록 수
        int pageCount  = 5;              // 한 그룹당 표시할 페이지 번호 
		
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Reserve input = new Reserve();
        
        if (member != null) {
		    input.setMemberId(member.getId());
		}
        
		// 상품 목록 조회하기 
		List<Reserve> output = null;
		
		// 페이지 번호를 계산한 결과가 저장될 객체
		PageData pageData = null;        
		
		try {
			// 전체 게시글 수 조회
            totalCount = reserveService.getReserveCount(input);
            
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Reserve.setOffset(pageData.getOffset());
            Reserve.setListCount(pageData.getListCount());
			
			// 데이터 조회 --> 검색 조건 없이 모든 상품 조회
			output = reserveService.getReserveList2(input);
		}	catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		
		
		// View에 추가
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData);
		
		return new ModelAndView("mypage/my-reserve");
	}
	
	/**
	 * 예약상세내역 페이지 (예정)
	 * @return
	 */
	
	@RequestMapping(value = "/reserve/my.do", method = RequestMethod.GET)
	public ModelAndView reserve(Model model, HttpSession session,
			 @SessionAttribute(value = "memInfo", required = false) Member member) {
		
		if (member == null) { 
			return webHelper.redirect(null,"로그인해주세요."); 
		}
		Reserve input = new Reserve();
		if (member != null) {
		    input.setMemberId(member.getId());
		}
		
		Reserve output = null;
		
		try {
		    output = reserveService.getReserveItem3(input);
		} catch (Exception e) {
		    return webHelper.redirect(null, e.getLocalizedMessage());
		}

		/** 3) View 처리 */
		model.addAttribute("output", output);
		return new ModelAndView ("mypage/reserve-1");
		
	}
	/**
	 * 예약상세내역 페이지 (예정)
	 * @return
	 */
	
	@RequestMapping(value = "/my-reserve/reserve-1.do", method = RequestMethod.GET)
	public ModelAndView reserve1(Model model, HttpSession session,
			 @SessionAttribute(value = "memInfo", required = false) Member member,
			 @RequestParam(value="reserve_id", defaultValue="0") int reserveId) {
		
		if (member == null) { 
			return webHelper.redirect(null,"로그인해주세요."); 
		}
		Reserve input = new Reserve();
		if (member != null) {
		    input.setMemberId(member.getId());
		}
		input.setReserveId(reserveId);
		
		Reserve output = null;
		
		try {
		    output = reserveService.getReserveItem2(input);
		} catch (Exception e) {
		    return webHelper.redirect(null, e.getLocalizedMessage());
		}

		/** 3) View 처리 */
		model.addAttribute("output", output);
		return new ModelAndView ("mypage/reserve-1");
		
	}
	
	/**
	 * 예약상세내역 페이지 (완료)
	 * @return
	 */
	
	@RequestMapping(value = "/my-reserve/reserve-2.do", method = RequestMethod.GET)
	public ModelAndView reserve2() {
		
		return new ModelAndView("mypage/reserve-2"); 
		
	}
	
	/**
	 * 리뷰 작성 페이지
	 * @return
	 */
	
	@RequestMapping(value = "/reserve-2/write-review.do", method = RequestMethod.GET)
	public ModelAndView writeReview() {
		
		return new ModelAndView("mypage/write-review"); 
		
	}
	
	
	
    /** 리뷰 action 페이지 */
    @RequestMapping(value = "/write-review/review_ok.do", method = RequestMethod.POST)
    public void add_ok(Model model, HttpServletResponse response,
    		@RequestParam(value="content") String content) {
    	
        /** 데이터 저장하기 */
        // 저장할 값들을 Beans에 담는다.
        Review input = new Review();
        input.setContent(content);
        
        try {
            // 데이터 저장
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
        	reviewService.addReview(input);
        } catch (Exception e) {
            e.printStackTrace();
        }

        /**  */
        String redirectUrl = contextPath + "/review/detail.do?review_id=" + input.getReviewId();
        
        try {
            response.sendRedirect(redirectUrl);
        } catch (IOException e) {
            e.printStackTrace();
        }
        
    }
    
	/**
	 * 리뷰 작성 페이지
	 * 
	 * @return
	 */

	@RequestMapping(value = "/review/detail.do", method = RequestMethod.GET)
	public String reviewDetail(Model model, HttpServletResponse response,
			@RequestParam(value = "review_id") int reviewId) {

		Review input = new Review();
		input.setReviewId(reviewId);

		Review output = null;

		try {
			output = reviewService.getReviewItem(input);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("output", output);
		return "mypage/reviewdetail";
	}
}
