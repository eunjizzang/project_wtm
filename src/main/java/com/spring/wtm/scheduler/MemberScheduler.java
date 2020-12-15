/**
* @filename : ShopScheduler.java
* @description : --- 쇼핑몰 관련 스케쥴러 ---
* @author : 이상희(46wendy@naver.com)
*/

package com.spring.wtm.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.wtm.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberScheduler {
	
	@Autowired
	MemberService memberService;
	
	/* 탈퇴후 3개월이 지난 회원의 데이터를 삭제 */
	public void dropMember() {
		try { log.debug("[everyMidnight] >> 탈퇴후 3개월이 지난 회원 삭제(개수): " + memberService.dropMember(null)); } 
		catch (Exception e) { e.printStackTrace(); }
	}	
	/* 비밀번호 재발급 후 30분이 지난 회원의 로그인 차단 */
	public void pwFind2() {
		try { log.debug("[everyMinute] >> 비밀번호 재발급 후 30분이 지난 회원 수정(개수): " + memberService.pwFind2(null)); } 
		catch (Exception e) { e.printStackTrace(); }
	}
}
