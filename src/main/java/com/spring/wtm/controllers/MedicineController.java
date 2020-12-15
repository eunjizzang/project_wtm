/**
 * @filename		: MedicineController.java
 * @description	: 약검색 페이지 컨트롤러
 * 									medicine_search -  약검색페이지
 * 									medicine_detail - 약 검색결과 상세페이지
 * @Date			: 2020. 9. 13. 
 * @author			: 박 수 인
 */

package com.spring.wtm.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.wtm.helper.PageData;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Medicine;
import com.spring.wtm.service.MedicineService;

@Controller
public class MedicineController {

	/** Service 패턴 구현체 주입 */
	// import com.spring.wtm.service.MedicineService;
	@Autowired
	MedicineService medicineService;

	@Autowired
	WebHelper webHelper;

	/** "/프로젝트이름"에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;

	/**
	 * 약검색 페이지(medicine_search.jsp)
	 * 
	 * @param model
	 * @param itemName
	 * @param page
	 * @return
	 *
	 */
	@RequestMapping(value = "/medicine", method = RequestMethod.GET)
	public ModelAndView medicine_serach(Model model,
			// 약이름 검색
			@RequestParam(value = "itemName", required = false) String itemName,
			// 페이지 구현에서 사용할 현재 페이지 번호
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {

		// 페이지 구현에 필요한 변수값 생성
		int totalCount = 0; // 전체 게시글 수
		int listCount = 10; // 한 페이지당 표시할 목록 수
		int pageCount = 5; // 한 그룹당 표시할 페이지 번호

		// 데이터 조회에 필요한 조건값(검색어/약이름)을 Beans에 저장
		Medicine input = new Medicine();
		input.setItemName(itemName);

		// 약정보 리스트 조회(/조회결과가 저장될 객체)
		List<Medicine> output = null;

		// 페이지 번호를 계산한 결과가 저장될 객체
		PageData pageData = null;

		try {
			// 전체 게시글 수 조회
			totalCount = medicineService.getMedicineCount(input);
			// 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Medicine.setOffset(pageData.getOffset());
			Medicine.setListCount(pageData.getListCount());

			// 데이터 조회 --> 검색 조건 없이 모든 약정보 조회
			output = medicineService.getMedicineList(input);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// View 처리
		model.addAttribute("output", output);
		model.addAttribute("itemName", itemName);
		model.addAttribute("pageData", pageData);

		return new ModelAndView("medicine/medicine_search");

	}

	/**
	 * 약검색 상세페이지 약상세 페이지로 이동(medicine_detail.jsp)
	 * 
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/medicine/medicine_detail.do", method = RequestMethod.GET)
	public ModelAndView medicine_detail(Model model, 
			@RequestParam(value = "itemSeq", defaultValue = "0") int itemSeq) {
		/** 데이터 조회하기 */
		//데이터 조회에 필요한 조건값을 Beans에 저장하기
		Medicine input = new Medicine();
		input.setItemSeq(itemSeq);
		
		//System.out.println("itemseq========>" + input.getItemSeq());
		
		// 조회결과를 저장할 객체 선언
		Medicine output = null;
		
		try {
			output = medicineService.getMedicineItem(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		/** view 처리 */
		model.addAttribute("output", output);
		
		return new ModelAndView("medicine/medicine_detail");

	}

}
