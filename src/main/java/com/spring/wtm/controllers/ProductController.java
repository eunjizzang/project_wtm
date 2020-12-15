/**
* @filename : ProductController.java
* @description : --- 쇼핑몰 관련 Controller(shop.jsp & shop-detail.jsp) ---
* @author : 이상희(46wendy@naver.com)
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
import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Product;
import com.spring.wtm.service.ProductService;

@Controller
public class ProductController {
	
	@Autowired
	WebHelper webHelper;

	@Autowired
	RegexHelper regexHelper;
	
	@Autowired
	ProductService productService;
	
	/** "/프로젝트이름"에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;
	
	/**
	 * 쇼핑몰 메인 페이지 (shop.jsp)
	 * @param model
	 * @param category
	 * @param keyword
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/shop", method = RequestMethod.GET)
	public ModelAndView shop(Model model,
			// 카테고리 
			@RequestParam(value="category", required=false) String category,
			// 검색어
			@RequestParam(value="keyword", required=false) String keyword,
			// 페이지 구현에서 사용할 현재 페이지 번호
			@RequestParam(value="page", defaultValue="1") int nowPage)  {
		
		// 페이지 구현에 필요한 변수값 생성 
        int totalCount = 0;              // 전체 게시글 수
        int listCount  = 16;             // 한 페이지당 표시할 목록 수
        int pageCount  = 5;              // 한 그룹당 표시할 페이지 번호 
		
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Product input = new Product();
		input.setName(keyword);
		input.setEng(keyword);
		input.setCategory(category);
		
		// 상품 목록 조회하기 
		List<Product> output = null;
		
		// 페이지 번호를 계산한 결과가 저장될 객체
		PageData pageData = null;        
		
		try {
			// 전체 게시글 수 조회
            totalCount = productService.getProductCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Product.setOffset(pageData.getOffset());
            Product.setListCount(pageData.getListCount());
			
			// 데이터 조회 --> 검색 조건 없이 모든 상품 조회
			output = productService.getProductList(input);
		}	catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		if (output != null) {
            for (Product item : output) {
                item.setImg(webHelper.getUploadUrl(item.getImg()));
            }
        }
		
		// View에 추가
		model.addAttribute("output", output);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageData", pageData);
		model.addAttribute("category", category);
		
		return new ModelAndView("shop/shop");
	}
	
	/**
	 * 쇼핑몰 상세페이지 (shop-detail.jsp)
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "shop/shop-detail.do", method = RequestMethod.GET)
	public ModelAndView shopDetail(Model model, 
			@RequestParam(value="id", defaultValue="0") int id) {
		
		/** 1) 유효성 검사 */
		// 이 값이 존재하지 않는다면 데이터 조회가 불가능하므로 필수값으로 처리해야한다.
		if (id == 0) {
			return webHelper.redirect(null, "상품 번호가 없습니다.");
		}
		
		/** 2) 데이터 조회하기 */
		// 데이터 조회에 필요한 조건값을 Beans에 저장하기
		Product input = new Product();
		input.setId(id);
		
		// 조회결과를 저장할 객체 선언
		Product output = null;
		
		try {
			// 데이터 조회
			output = productService.getProductItem(input);
		}	catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
        output.setImg(webHelper.getUploadUrl(output.getImg()));

		
		/** 3) View 처리 */
		model.addAttribute("output", output);
		
		return new ModelAndView("shop/shop-detail");
	}
	
}
