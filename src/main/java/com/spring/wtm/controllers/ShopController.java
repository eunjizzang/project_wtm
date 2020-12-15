/**
* @filename : ShopController.java
* @description : --- 쇼핑몰 관련 Controller ---
* @author : 이상희(46wendy@naver.com)
*/

package com.spring.wtm.controllers;

import java.util.List;

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
import com.spring.wtm.model.Cart;
import com.spring.wtm.model.Delivery;
import com.spring.wtm.model.Member;
import com.spring.wtm.model.Order;
import com.spring.wtm.service.CartService;
import com.spring.wtm.service.DeliveryService;
import com.spring.wtm.service.OrderService;
import com.spring.wtm.service.ProductService;

@Controller
public class ShopController {
	
	@Autowired
	WebHelper webHelper;
	
	@Autowired
	RegexHelper regexHelper;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	CartService cartService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	DeliveryService deliveryService;
	
	/** "/프로젝트이름"에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;
	
	/** 
	 * 쇼핑몰 장바구니 (cart.jsp)
	 * @param model
	 * @param session
	 * @param member
	 * @return
	 */
	@RequestMapping(value = "/shop/cart.do", method = RequestMethod.GET)
	public ModelAndView cart(Model model, 
			HttpSession session, 
			@SessionAttribute(value = "memInfo", required = false) Member member) {
		
		/** 1) 데이터 조회 */
		Cart input = new Cart();
        // 비회원인 경우 클라이언트를 식별하기 위한 JSESSION-ID -> 모든 브라우저마다 고유한 값으로 할당된다.
        input.setSessionId(session.getId());
        
        // 세션 값 기준으로 장바구니 값 있는지 확인
        int count = 0;
        
        // 로그인했다면
        if (member != null) {
            input.setMemberId(member.getId());
            try {
				count = cartService.getCartCount2(input); // SELECT COUNT(*) FROM cart WHERE session_id = #{sessionId}
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
        
        System.out.println("member ====================>" + member);
        System.out.println("count =====================>" + count);
        /** 비회원 장바구니 --> 회원 장바구니 유지 처리 */
        if (member != null && count != 0) {   //로그인 & 세션기준 장바구니 데이터O  
        	try {
				cartService.editCart2(input);	//  UPDATE cart SET member_id = #{memberId},edit_date = now() WHERE session_id = #{sessionId}
			} catch (Exception e) {
				return webHelper.redirect(null, e.getLocalizedMessage());
			}
        }
        
        List<Cart> output = null;
        
        // 데이터 조회
        try {
            output = cartService.getCartList(input);
        } catch (Exception e) {
            return webHelper.redirect(null, e.getLocalizedMessage());
        }
        
        // 이미지 업로드
        if (output != null) {
            for (Cart item : output) {
                item.setImg(webHelper.getUploadUrl(item.getImg()));
            }
        }
        
        /** 2) View 처리 */
        model.addAttribute("output", output);
		
		return new ModelAndView("shop/cart");
	}
	
	/**
	 * 쇼핑몰 주문서 작성 페이지 (order-form.jsp)
	 * @param model
	 * @param session
	 * @param member
	 * @return
	 */
	 @RequestMapping(value = "/shop/order-form.do", method = RequestMethod.GET)
	 public ModelAndView form(Model model, HttpSession session,
		 @SessionAttribute(value = "memInfo", required = false) Member member) {
		 
		 /** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		 if (member == null) { 
			 return webHelper.redirect(null,"로그인해주세요."); 
		 }
		 
		 /** 2) 데이터 조회 */
		 Cart input = new Cart();
	        
	     input.setMemberId(member.getId());
		 
	     // 결제할 상품들 정보
		 List<Cart> output = null;
		 // 회원 정보
		 List<Cart> output2 = null;
		 
		 try {
			 	// 결제할 상품들 조회
	            output = cartService.getCartList(input);
	            // 주문하는 회원 정보 조회
	            output2 = cartService.getCartList2(input);
	        } catch (Exception e) {
	            return webHelper.redirect(null, e.getLocalizedMessage());
	        }
	     
		 // 이미지 업로드
		 if (output != null) {
			 for (Cart item : output) {
				 item.setImg(webHelper.getUploadUrl(item.getImg()));
			 }
		 }
		 
		 /** 3) View 처리 */
	     model.addAttribute("output", output);
	     model.addAttribute("output2", output2);
		 
		 return new ModelAndView("shop/order-form"); 
	 }
	
	 /**
      * 쇼핑몰 주문완료 페이지 (order-complete.jsp)
	  * @param model
	  * @param session
	  * @param member
	  * @return
	 */	
		@RequestMapping(value = "/shop/order-complete.do", method = RequestMethod.GET)
		 public ModelAndView order(Model model, HttpSession session,
			 @SessionAttribute(value = "memInfo", required = false) Member member) { 
			
			/** 1) 파라미터 유효성 검사 */
			// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
			 if (member == null) { 
				 return webHelper.redirect(null,"로그인해주세요."); 
			 }
			
			/** 2) 데이터 조회 */
			Order input = new Order();
			input.setMemberId(member.getId());
			
			// 조회 결과를 저장할 객체 선언
			Order output = null;
			
			try {
	            // 주문 데이터 조회
	            output = orderService.getOrderItem(input);
	        } catch (Exception e) {
	            return webHelper.redirect(null, e.getLocalizedMessage());
	        }
			
			/** 3) View 처리 */
			model.addAttribute("output", output);
			
			return new ModelAndView("shop/order-complete"); 
		 
		}
		 
	/**
	 * 쇼핑몰 마이페이지 내 주문 페이지 (order.jsp)
	 * @param model
	 * @param session
	 * @param member
	 * @param period - 드롭다운 기간별 조회 
	 * @param nowPage
	 * @return
	 */
	@RequestMapping(value = "/mypage/order.do", method = RequestMethod.GET)
	public ModelAndView myOrder(Model model, HttpSession session,
			 @SessionAttribute(value = "memInfo", required = false) Member member,
			 // 드롭 다운 값(기간별 조회)
			 @RequestParam(value = "period", required = false) String period,
			 // 페이지 구현에서 사용할 현재 페이지 번호
			 @RequestParam(value = "page", defaultValue = "1") int nowPage) {
		
		/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		 if (member == null) { 
			 return webHelper.redirect(null,"로그인해주세요."); 
		 }
		
		/** 2) 페이지 구현에 필요한 변수값 생성 */
        int totalCount = 0;              	// 전체 게시글 수
        int listCount  = 3;             		// 한 페이지당 표시할 목록 수
        int pageCount  = 5;               // 한 그룹당 표시할 페이지 번호 
		
        /** 3) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Order input = new Order();
		input.setOrderDate(period);
		
		if (member != null) {
            input.setMemberId(member.getId());
        }
		
		// 조회 결과를 저장할 객체 선언
		List<Order> output = null;
					
		// 페이지 번호를 계산한 결과가 저장될 객체
		PageData pageData = null;        
		
		try {
			// 전체 게시글 수 조회
            totalCount = orderService.getOrderCount(input);
            // 페이지 번호 계산 --> 계산결과를 로그로 출력될 것이다.
            pageData = new PageData(nowPage, totalCount, listCount, pageCount);

            // SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
            Order.setOffset(pageData.getOffset());
            Order.setListCount(pageData.getListCount());
			
           // 주문 데이터 조회
			output = orderService.getOrderList(input);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
		
		/** 4) View 처리 */
		model.addAttribute("output", output);		
		model.addAttribute("period", period);
		model.addAttribute("pageData", pageData);
		
		return new ModelAndView("shop/order");
	}
	
	/** 
	 * 쇼핑몰 마이페이지 내 주문 페이지에서 각 주문별 상세 페이지 (order-detail.jsp)
	 * @param model
	 * @param response
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/mypage/order-detail.do", method = RequestMethod.GET)
	public ModelAndView myOrderDetail(Model model, HttpSession session,
			 @SessionAttribute(value = "memInfo", required = false) Member member,
			 @RequestParam(value="id", defaultValue="0") int id) {
		
		/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		 if (member == null) { 
			 return webHelper.redirect(null,"로그인해주세요."); 
		 }
		
		/** 2) 데이터 조회하기 */
		// 조회에 필요한 조건값(검색어)를 Beans에 담는다.
		Order input1 = new Order();
		Delivery input2	 = new Delivery();	
		
		if (member != null) {
			input1.setMemberId(member.getId());
			input2.setMemberId(member.getId());
		}
		
		input1.setId(id);
		// 배송 테이블 주문번호(fk)에 주문번호 대입
		input2.setOrderId(id);
		
		// 조회 결과를 저장할 객체 선언
		Order output1 = null;
		Delivery output2 = null;
		
		try {
            // 주문 데이터 조회
			output1 = orderService.getOrderItem2(input1);
			// 배송 데이터 조회 
			output2 = deliveryService.getDeliveryItem(input2);
		} catch (Exception e) {
			return webHelper.redirect(null, e.getLocalizedMessage());
		}
					
		/** 3) View 처리 */
		model.addAttribute("output1", output1);		
		model.addAttribute("output2", output2);		
		
		return new ModelAndView("shop/order-detail");
	}
	
}
