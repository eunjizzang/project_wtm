/**
* @filename : DrugController.java
* @description : --- 약국 찾기 Controller ---
* @author : 이상희(46wendy@naver.com)
*/

package com.spring.wtm.controllers;

import java.util.Calendar;
import java.util.List;

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
import com.spring.wtm.model.Drug;
import com.spring.wtm.service.DrugService;

@Controller
public class DrugController {
	
	@Autowired
	WebHelper webHelper;
	
	@Autowired
	RegexHelper regexHelper;
	
	@Autowired
	DrugService drugService;
	
	/** "/프로젝트이름"에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;
	

	/**
	 * 약국 찾기 페이지
	 * @param model
	 * @param si
	 * @param gu
	 * @param dong
	 * @return
	 */
	@RequestMapping(value = "/drug", method = RequestMethod.GET)
	public ModelAndView drug(Model model,
			// 드롭다운 - 시/도 값
			@RequestParam(value = "si", required = false) String si,
			// 드롭 다운 - 시/구 값
			@RequestParam(value = "gu", required = false) String gu,
			// 검색창 - 도로명 값
			@RequestParam(value = "dong", required = false) String dong) {
		
		if (si != null) {
			/** 1) 데이터 조회하기 */
			// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
			Drug input = new Drug();
			// 시/도
			input.setAddr(si);
			// 시/구
			input.setAddr2(gu);
			// 구
			input.setAddr3(dong);

			System.out.println("input================>" + input);
			
			// Calendar 객체 생성
			Calendar cal = Calendar.getInstance();
			// 오늘 요일 구하기(1: 일요일, 2: 월요일 ... 6: 토요일)
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			
			System.out.println("dayOfWeek===============>" + dayOfWeek);
			
			// 조회 결과를 저장할 객체 선언
			List<Drug> output = null;
			int count = 0;
			
			// 데이터 조회
			if (dayOfWeek == 1) {				// 일요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList1(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}	else if (dayOfWeek == 2) {	// 월요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList2(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}	else if (dayOfWeek == 3) {	// 화요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList3(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}	else if (dayOfWeek == 4) {	// 수요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList4(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}	else if (dayOfWeek == 5) {	// 목요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList5(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}	else if (dayOfWeek == 6) {	// 금요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList6(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}	else if (dayOfWeek == 7) {	// 토요일 데이터 조회
				try {
					count = drugService.getDrugCount(input);
					output = drugService.getDrugList7(input);
				} catch (Exception e) {
					return webHelper.redirect(null, e.getLocalizedMessage());
				}
			}
		
			/** 2) View 처리 */
			model.addAttribute("output", output);
			model.addAttribute("count", count);
			}
			return new ModelAndView("drug/drug");
		}
}
