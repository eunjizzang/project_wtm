package com.spring.wtm.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Hospital;
import com.spring.wtm.model.Reserve;
import com.spring.wtm.model.Review;
import com.spring.wtm.service.HospitalService;
import com.spring.wtm.service.ReserveService;
import com.spring.wtm.service.ReviewService;


@Controller
public class HospitalController {
	
	/** WebHelper 주입 */
    @Autowired  WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired  RegexHelper regexHelper;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  ReserveService reserveService;

    /** Service 패턴 구현체 주입 */
    @Autowired  ReviewService reviewService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  HospitalService hospitalService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
	
	/**
	 * 병원 찾기 페이지
	 * @param model
	 * @param si
	 * @param gu
	 * @param dong
	 * @return
	 */
	@RequestMapping(value = "/hospital", method = RequestMethod.GET)
	public ModelAndView hospital(Model model, 
			// 드롭다운 - 진료과목 값
			@RequestParam(value = "sub", required = false) String sub,
			// 드롭다운 - 시/도 값
			@RequestParam(value = "si", required = false) String si,
			// 드롭 다운 - 시/구 값
			@RequestParam(value = "gu", required = false) String gu,
			// 검색창 - 도로명 값
			@RequestParam(value = "dong", required = false) String dong) {
			
		if (si != null) {
			/** 1) 데이터 조회하기 */
			// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
			Hospital input = new Hospital();
			// 진료과목
			input.setSub(sub);
			// 시/도
			input.setAddr(si);
			// 시/구
			input.setAddr2(gu);
			// 구
			input.setAddr3(dong);
			
			System.out.println("input================>" + input);
			
			// 조회 결과를 저장할 객체 선언
			List<Hospital> output = null;
			int count = 0;
			
			// 데이터 조회
			try {
				count = hospitalService.getHospitalCount(input);
				output = hospitalService.getHospitalList(input);		// SELECT * FROM hospital WHERE addr LIKE concat('%', #{addr}, '%') AND  addr LIKE concat('%', #{addr2}, '%') AND  addr LIKE concat('%', #{addr3}, '%') 
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			/** 2) View 처리 */
			model.addAttribute("output", output);
			model.addAttribute("count", count);
			model.addAttribute("sub", sub);
			model.addAttribute("si", si);
			model.addAttribute("gu", gu);
			model.addAttribute("dong", dong);
			}
			return new ModelAndView("hospital/hospital");
		}
	
	/**
	 * 병원 예약페이지 (reserve.jsp)
	 * @param model
	 * @param hospitalId
	 * @return
	 */
	@RequestMapping(value = "/hospital/reserve.do", method = RequestMethod.GET)
	public ModelAndView reserve(Model model, 
			 @RequestParam(value="hospital_id", defaultValue="0") int hospitalId) {
		
		System.out.println("==============controller통과================");
		
		 /** 1) 유효성 검사 */
        // 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 반드시 필수값으로 처리해야 한다.
        if (hospitalId == 0) {
            return webHelper.redirect(null, "병원번호가 없습니다.");
        }
		
        /** 2) 데이터 조회하기 */
		// 데이터 조회에 필요한 조건값을 Beans에 저장하기
		Hospital input1 = new Hospital();
		input1.setHospitalId(hospitalId);
		
		Review input2 = new Review(); 
		input2.setHospitalHospitalId(hospitalId);
		
		// 조회 결과를 저장할 객체 선언
		Hospital output1 = null;
		List<Review> output2 = null;
		
		try {
			output1 = hospitalService.getHospitalItem(input1);		// SELECT hospital_id, name FROM hospital WHERE hospital_id=#{hospitalId}
			output2 = reviewService.getReviewList2(input2);			//SELECT content, reg_date, review_id, member_id, hospital_hospital_id FROM review WHERE hospital=#{hospitalHospitalId} ORDER BY review_id DESC;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("output1", output1);		
		model.addAttribute("output2", output2);
		
		return new ModelAndView("hospital/reserve");
	}
	
	/** 작성 폼 페이지 */
    @RequestMapping(value = "/reserve/add.do", method = RequestMethod.GET)
    public ModelAndView add(Model model) {
        
        /** 학과 목록 조회하기 */
        // 조회결과를 저장할 객체 선언
        List<Reserve> output = null;

        try {
            // 데이터 조회 --> 검색조건 없이 모든 학과 조회
            output = reserveService.getReserveList(null);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        // View에 추가
        model.addAttribute("output", output);
        
        return new ModelAndView("hospital/reserve.do");
    }
	/**
	 * 병원 리뷰 페이지
	 * @return
	 */
	
	@RequestMapping(value = "/reserve/review.do", method = RequestMethod.GET)
	public String review(Model model, HttpServletResponse response) {
		
		List<Review> output = null;
		
		
		try {
			output = reviewService.getReviewList(null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("output",output);
		return "hospital/review";
	}
}
