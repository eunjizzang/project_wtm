/**
* @filename : ShopScheduler.java
* @description : --- 쇼핑몰 관련 스케쥴러 ---
* @author : 이상희(46wendy@naver.com)
*/

package com.spring.wtm.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.wtm.service.CartService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ShopScheduler {
	
	@Autowired
	CartService cartService;
	
	/**
	 * 장바구니(cart) 테이블 데이터 한달만 저장 구현 
	 */
	public void everyMidnight() {
		try {
			log.debug("매일 자정에 실행되는 작업 >> " + cartService.deleteCart2(null));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
