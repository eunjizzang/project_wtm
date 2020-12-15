package com.spring.wtm.controllers;

import java.io.IOException;
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

import com.spring.wtm.helper.PageData;
import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Ad;
import com.spring.wtm.model.Member;
import com.spring.wtm.model.Product;
import com.spring.wtm.service.AdService;
import com.spring.wtm.service.MemberService;
import com.spring.wtm.service.ProductService;

@Controller
public class AdminController {

	@Autowired
	WebHelper webHelper;

	@Autowired
	RegexHelper regexHelper;

	@Autowired
	ProductService productService;

	@Autowired
	MemberService memberService;

	@Autowired
	AdService adService;

	/** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;

	/** ============ 대시보드 ============ */

	/**
	 * @description
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin_main.do", method = RequestMethod.GET)
	public ModelAndView adminMain(Model model, HttpServletResponse response) {
		return new ModelAndView("admin/admin_main");
	}

	/** ============ 팝업창 ============ */

	/**
	 * @description
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/popup.do", method = RequestMethod.GET)
	public ModelAndView adminPopup(Model model, HttpServletResponse response) {
		Ad input = new Ad();

		List<Ad> output = null;

		try {
			output = adService.getAdList(input);
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("output", output);
		return new ModelAndView("admin/popup");
	}

	/** ============ 쇼핑몰 관련 페이지 ============ */

	/**
	 * @description 상품 목록 페이지
	 * @param model
	 * @param category
	 * @param keyword
	 * @param nowPage
	 * @return
	 */
	@RequestMapping(value = "/admin_goods.do", method = RequestMethod.GET)
	public ModelAndView adminPdt(Model model,
			// 카테고리
			@RequestParam(value = "category", required = false) String category,
			// 검색어
			@RequestParam(value = "keyword", required = false) String keyword,
			// 페이지 구현에서 사용할 현재 페이지 번호
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {

		// 페이지 구현에 필요한 변수값 생성
		int totalCount = 0;
		int listCount = 10;
		int pageCount = 5;

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
		} catch (Exception e) {
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
		model.addAttribute("totalCount", totalCount);

		return new ModelAndView("admin/admin_goods");
	}

	/**
	 * @description 상품 등록 페이지 (상품 데이터 삽입)
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin_goodsint.do", method = RequestMethod.GET)
	public ModelAndView adminPdtInt(Model model, HttpServletResponse response) {
		return new ModelAndView("admin/admin_goodsint");
	}

	/**
	 * @description 상품 등록 action 페이지
	 * @param model
	 * @param response
	 */
	@RequestMapping(value = "/goodsint.do", method = RequestMethod.POST)
	public void addOk(Model model, HttpServletResponse response, @RequestParam(value = "id") int id,
			@RequestParam(value = "name") String name, @RequestParam(value = "img") String img,
			@RequestParam(value = "eng") String eng, @RequestParam(value = "price") int price,
			@RequestParam(value = "qty") int qty, @RequestParam(value = "desc") String desc,
			@RequestParam(value = "spec") String spec, @RequestParam(value = "delivery") String delivery,
			@RequestParam(value = "category") String category) {
		
		Product input = new Product();
		input.setId(id);
		input.setName(name);
		input.setImg(img);
		input.setEng(eng);
		input.setPrice(price);
		input.setQty(qty);
		input.setDesc(desc);
		input.setSpec(spec);
		input.setDelivery(delivery);
		input.setCategory(category);
		
		try {
			productService.addProduct(input);
		} catch(Exception e) { e.printStackTrace(); }
		
		String redirectUrl = contextPath + "/shop/shop-detail.do?id=" + input.getId();
		
		try {
			response.sendRedirect(redirectUrl);
		}catch(IOException e ) {e.printStackTrace();}
	}


	/** ============ 회원 관련 페이지 ============ */

	/**
	 * @description 회원 목록 페이지
	 * @param model
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/admin_members.do", method = RequestMethod.GET)
	public ModelAndView adminMem(Model model, HttpServletResponse response,
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {

		int totalCount = 0;
		int listCount = 5;
		int pageCount = 5;

		Member input = new Member();

		List<Member> output = null;
		PageData pageData = null;

		try {
			totalCount = memberService.getMemberCount(input);
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);

			Member.setOffset(pageData.getOffset());
			Member.setListCount(pageData.getListCount());

			output = memberService.getMemberList(input);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// View 처리
		model.addAttribute("output", output);
		model.addAttribute("pageData", pageData);

		return new ModelAndView("admin/admin_members");
	}

}
