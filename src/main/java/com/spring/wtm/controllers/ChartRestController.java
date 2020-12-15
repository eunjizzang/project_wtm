package com.spring.wtm.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.RetrofitHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.CovidConfirm;
import com.spring.wtm.model.CovidRegion;
import com.spring.wtm.service.CovidConfirmService;
import com.spring.wtm.service.CovidRegionService;

import lombok.extern.slf4j.Slf4j;

/**
 * @filename		: ChartRestController.java
 * @description	: Restful API
 * @Date			: 2020. 10. 02. 
 * @author			: 오 혜 진 (clia315@gmail.com)
 */
@Slf4j
@RestController
public class ChartRestController {
	
	/** WebHelper 주입 */ 
    @Autowired WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired RegexHelper regexHelper;
    
    @Autowired RetrofitHelper retrofitHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired CovidConfirmService confirmService;
    @Autowired CovidRegionService regionService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
    
	/** 전국현황 목록 페이지 */
    @RequestMapping(value = "/rest/covid/confirm", method = RequestMethod.POST)
    public Map<String, Object> get_confirm_list() {	
		/** 데이터 조회하기 */
		CovidConfirm input = new CovidConfirm();
		
		List<CovidConfirm> output = null;	// 조회결과가 저장될 객체
		
		try {
			// 데이터 조회하기
			output = confirmService.getCovidConfirmList(input);
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
		data.put("item", output);
		
		log.debug("");
		return webHelper.getJsonData(data);
    }	    
	/** 지역현황 목록 페이지 */
    @RequestMapping(value = "/rest/covid/region", method = RequestMethod.POST)
    public Map<String, Object> get_region_list() {	
		/** 데이터 조회하기 */
		CovidRegion input = new CovidRegion();
		
		List<CovidRegion> output = null;	// 조회결과가 저장될 객체
		
		try {
			// 데이터 조회하기
			output = regionService.getCovidRegionList(input);
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
		data.put("item", output);
		
		log.debug("");
		return webHelper.getJsonData(data);
    }	
}
