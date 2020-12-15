/**
* @filename : ShopRestController.java
* @description : --- 쇼핑몰 관련 Controller(cart.jsp) ---
* 							shop-detail에서 장바구니 이동
* @author : 이상희(46wendy@naver.com)
*/

package com.spring.wtm.controllers;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Cart;
import com.spring.wtm.model.Delivery;
import com.spring.wtm.model.Member;
import com.spring.wtm.model.Order;
import com.spring.wtm.service.CartService;
import com.spring.wtm.service.DeliveryService;
import com.spring.wtm.service.OrderService;

@RestController
public class ShopRestController {
	
	@Autowired
	/** WebHelper 주입 */
	WebHelper webHelper;
	
	@Autowired
	/** RegexHelper 주입 */
	RegexHelper regexHelper;
	
	/** Service 패턴 구현체 주입 */
	@Autowired
	CartService cartService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	DeliveryService deliveryService;
	
	/**
	 * 쇼핑몰 상세페이지(shop-detail.jsp)에서 장바구니 버튼 --> cart테이블에 데이터 저장
	 * @param session
	 * @param member
	 * @param productId
	 * @param name
	 * @param img
	 * @param qty 
	 * @param price (단가 * 수량)
	 * @return
	 */
	@RequestMapping(value="/shop/rest/cart.do", method=RequestMethod.POST)
	public Map<String, Object> addCart(HttpSession session, 
			@SessionAttribute(value = "memInfo", required = false) Member member,
			@RequestParam(value = "product_id", defaultValue = "0") int productId, 
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "img", required = false) String img,
			@RequestParam(value = "qty", defaultValue = "0") int qty,
			@RequestParam(value = "c_price", defaultValue= "0") int price) {
		
		/** 1) 사용자가 입력한 파라미터에 대한 유효성 검사 */
		System.out.println("ajax로 보낸 상품 아이디 = " + productId + "상품 이름 = " + name);
		
		if (productId <1) { 
			return webHelper.getJsonWarning("상품을 선택해주세요.");
		}
		 
        /** 2) 데이터 저장하기 */
        Cart input = new Cart();
        // 비회원인 경우 클라이언트를 식별하기 위한 JSESSION-ID -> 모든 브라우저마다 고유한 값으로 할당된다.
        input.setSessionId(session.getId());
        
        // 로그인 했을 경우, 회원일련번호 저장
        if (member != null) { 
        	input.setMemberId(member.getId()); 
        }

        input.setProductId(productId);
        input.setName(name);
        input.setImg(img);
        input.setQty(qty);
        input.setPrice2(price);
        
        // 상품 일련번호와 일치하는 수
        int same = 0;
        
        System.out.println("상품 일련번호=========================>" + input.getProductId());
        
        // 지금 장바구니에 담는 상품이 현재 장바구니에 존재하는 지 검사 --> 0이면 존재X / 1이상이면 존재O
        try {
        	same = cartService.getSameCount(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }
        
        // 존재하지 않는다면 --> INSERT
        if (same == 0) {
        	try {
                cartService.addCart(input);
            } catch (Exception e) {
                return webHelper.getJsonError(e.getLocalizedMessage());
            }
        }	// 존재한다면 --> UPDATE
        	else {
        	try {
        		cartService.editCart(input);
        	}	catch (Exception e) {
                return webHelper.getJsonError(e.getLocalizedMessage());
            }
        }
        
        System.out.println("장바구니 아이디 = " + input.getId());

        /** 3) 결과를 확인하기 위한  JSON 출력 */
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("id", input.getId());
        
        return webHelper.getJsonData(data); 
    }

	/**
	 * 장바구니(cart.jsp)에서 개별/전체 데이터 삭제 action & 상품 상세페이지(shop-detail.jsp)에서 주문하기 클릭시 장바구니 비움
	 * @param session
	 * @param member
	 * @param cartId
	 * @return
	 */
    @RequestMapping(value = "/shop/rest/cart.do", method = RequestMethod.DELETE)
    public Map<String, Object> deleteCart(HttpSession session, 
            @SessionAttribute(value = "memInfo", required = false) Member member, 
            @RequestParam(value = "id", defaultValue= "0") int cartId) {
    	
    	// 파라미터 유효성검사 불필요!
    	
    	// 장바구니 개별삭제 버튼을 누를 경우, 장바구니 아이디 보냄
    	System.out.println("ajax로 보낸 장바구니 아이디 = " + cartId);
        // --> DELETE FROM cart WHERE id = #{id};
    	
    	// 장바구니 전체 삭제 버튼을 누를 경우, 장바구니 아이디 안보냄!
    	// --> DELETE FROM cart만 실행
    	
        /** 1) 데이터 삭제하기 */
        // 데이터 삭제에 필요한 조건 값을 Beans에 저장하기 
        Cart input = new Cart();
        
        // 비회원인 경우 클라이언트를 식별하기 위한 JSESSION-ID -> 모든 브라우저마다 고유한 값으로 할당된다.
        input.setSessionId(session.getId());

		
		if (member != null) { input.setMemberId(member.getId()); }
		

        if (cartId > 0) {
        	input.setId(cartId);
        }
        
        System.out.println("빈즈에 저장된 장바구니 아이디 = " + input.getId());
        
        try {
            cartService.deleteCart(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }
        
        /** 2) 결과를 확인하기 위한 JSON 출력 */
        // 확인할 대상이 삭제된 결과값만 OK로 전달
        return webHelper.getJsonData();
    }

    /**
     * 장바구니(cart.jsp)에서 결제 페이지로 이동(체크된 cart.id 기준 수량 & 가격 수정)
     * @param member
     * @param id
     * @param qty
     * @param cPrice (단가 * 수량)
     * @return
     */
    @RequestMapping(value = "/shop/rest/order-ok.do", method = RequestMethod.POST)
    public Map<String, Object> goPay(
    		@SessionAttribute(value = "memInfo", required = false) Member member,
			@RequestParam(value = "id", defaultValue = "0") int id, 
			@RequestParam(value = "qty", defaultValue = "0") int qty,
			@RequestParam(value = "c_price", defaultValue= "0") int cPrice) {
    	
    	/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (member == null) {
			return webHelper.getJsonWarning("로그인해주세요");
		}

    	/** 2) 데이터 담기 */
    	Cart input = new Cart();
    	
    	input.setMemberId(member.getId());
    	input.setId(id);
    	input.setQty(qty);
    	input.setPrice2(cPrice);
    	
    	try {
    		cartService.editCart3(input);			// UPDATE cart SET qty= #{qty}, c_price= #{price2}, edit_date=now() WHERE id = #{id} 
    	}	catch (Exception e) {
    		return webHelper.getJsonError(e.getLocalizedMessage());
    	}
    	
    	/** 3) 결과 확인을 위한 JSON 출력 */
    	// 확인할 대상이 삭제된 결과값만 OK로 전달
    	Map<String, Object> data = new HashMap<String, Object>();
        data.put("id", input.getId());
        
    	return webHelper.getJsonData();
    }
    
    /**
     * 쇼핑몰 주문서(order-form.jsp)에서 주문하기 버튼 --> order테이블에 저장
     * @param member
     * @param name
     * @param tel
     * @param postcode
     * @param address
     * @param detailAddress
     * @param extraAddress
     * @param memo
     * @param orderPay 결제 방법
     * @param prodInfo JSON으로 담은 상품 정보들
     * @param totalPrice 총 결제금액
     * @param count 한 주문당 상품 종류 수
     * @return
     */
    @RequestMapping(value = "/shop/rest/order-complete.do", method = RequestMethod.POST)
    public Map<String, Object> orderOk( 
    		@SessionAttribute(value = "memInfo", required = false) Member member,
			 @RequestParam(value = "user_name", required = false) String name,
			 @RequestParam(value = "tel", required = false) String tel,
			 @RequestParam(value = "postcode", required = false) String postcode,
			 @RequestParam(value = "address", required = false) String address,
			 @RequestParam(value = "detail_address", required = false) String detailAddress,
		  	 @RequestParam(value = "extra_adress", required = false) String extraAddress,
			 @RequestParam(value = "memo", required = false) String memo,
			 @RequestParam(value = "paymethod", required = false) String orderPay,
			 @RequestParam(value = "prod_info", required = false) String prodInfo,
			 @RequestParam(value = "total_price", required = false) int totalPrice,
			 @RequestParam(value = "count", required = false) int count) {
    	
    	System.out.println("-------------------컨트롤러 시작-------------------");
    	
    	/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (member == null) {
			return webHelper.getJsonWarning("로그인해주세요.");
		}
		if (name.equals("")) {
			return webHelper.getJsonWarning("수취인명을 입력해주세요.");
		}
		if (tel.equals("")) {
			return webHelper.getJsonWarning("전화번호를 입력해주세요.");
		}
		if (postcode.equals("")) {
			return webHelper.getJsonWarning("우편번호를 입력해주세요.");
		}
		if (address.equals("")) {
			return webHelper.getJsonWarning("주소를 입력해주세요.");
		}
		if (prodInfo == null) {
			return webHelper.getJsonWarning("선택된 상품 정보가 없습니다.");
		}
		if (totalPrice < 1) {
			return webHelper.getJsonWarning("선택된 상품 정보가 없습니다.");
		}
		
    	/** 2) 데이터 저장하기 */
		Cart input1 = new Cart();
		input1.setMemberId(member.getId());
		
    	Order input2 = new Order();
		input2.setMemberId(member.getId());
		input2.setTotalPrice(totalPrice);
		input2.setCount(count);
		input2.setProdInfoJson(prodInfo);
		
		Delivery input3 = new Delivery();
		
		input3.setMemberId(member.getId());
		input3.setReceiver(name);
		input3.setTel(tel);
		input3.setPostcode(postcode);
		input3.setAddress(address);
		input3.setDetailAddress(detailAddress);
		input3.setExtraAddress(extraAddress);
		input3.setMemo(memo);
		input3.setOrderPay(orderPay);
		
		try {
			// 장바구니 삭제
			cartService.deleteCart(input1);
			
            // 주문테이블 - 데이터 저장
            // --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
			orderService.addOrder(input2);
			
			// order_id(FK)값 저장
			input3.setOrderId(input2.getId());
			// 배송테이블 - 데이터 저장
			// --> 데이터 저장에 성공하면 파라미터로 전달하는 input 객체에 PK값이 저장된다.
            deliveryService.addDelivery(input3);
    	}	catch (Exception e) {
    		return webHelper.getJsonError(e.getLocalizedMessage());
    	}
    	
    	/** 3) 결과 확인을 위한 JSON 출력 */
    	// 확인할 대상이 삭제된 결과값만 OK로 전달
    	Map<String, Object> data = new HashMap<String, Object>();
        data.put("id", input1.getId());
        
    	return webHelper.getJsonData();
    }
    
    /**
     * 쇼핑몰 마이페이지내 주문상세(order-detail.do)에서 주문 삭제 action
     * @param model
     * @param session
     * @param member
     * @param id
     * @return
     */
	@RequestMapping(value = "/mypage/order-detail.do", method = RequestMethod.DELETE)
	public Map<String, Object> orderDelete(Model model, HttpSession session,
			 @SessionAttribute(value = "memInfo", required = false) Member member,
			 @RequestParam(value="id", defaultValue="0") int id) {
		
		System.out.println("-------------------컨트롤러 시작-------------------");
		
		/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 삭제가 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (member == null) {
			return webHelper.getJsonWarning("로그인해주세요.");
		}
		if (id < 1) {
			return webHelper.getJsonWarning("주문번호가 존재하지 않습니다.");
		}
		
		/** 2) 데이터 삭제하기 */
		// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
		Order input1 = new Order();
		Delivery input2	 = new Delivery();	
		
		if (member != null) {
			input1.setMemberId(member.getId());
			input2.setMemberId(member.getId());
		}
		
		input1.setId(id);
		// 배송 테이블 주문번호(FK)에 주문번호 저장
		input2.setOrderId(id);

		try {
			// 배송 데이터 삭제(참조키 떄문에 배송테이블에 있는 데이터가 먼저 삭제되야함!!)
			deliveryService.deleteDelivery(input2);
            // 주문 데이터 삭제
			orderService.deleteOrder(input1);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
					
		/** 3) 결과를 확인하기 위한 JSON 출력 */
		// 확인할 대상이 삭제된 상태이므로 페이지로 이동
		return webHelper.getJsonData();
	}
    
}
