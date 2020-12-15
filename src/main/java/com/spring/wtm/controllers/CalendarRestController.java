package com.spring.wtm.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.spring.wtm.helper.PageData;
import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Calendar;
import com.spring.wtm.model.Member;
import com.spring.wtm.service.CalendarService;

import lombok.extern.slf4j.Slf4j;

/**
 * @filename		: CalendarRestController.java
 * @description	: Restful API
 * @Date			: 2020. 10. 04. 
 * @author			: 오 혜 진 (clia315@gmail.com)
 */
@Slf4j
@RestController
public class CalendarRestController {
    /** WebHelper 주입 */
    @Autowired  WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired  RegexHelper regexHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired  CalendarService calendarService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
    
    @RequestMapping(value = "/rest/user/calendar", method = RequestMethod.GET)
    public Map<String, Object> get_list(
    		@SessionAttribute(value = "memInfo", required = false) Member member,
    		// 페이지 구현에서 사용할 현재 페이지 번호
			@RequestParam(value = "page", defaultValue = "1") int nowPage) {
    	
    	/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (member == null) {
			return webHelper.getJsonWarning("로그인해주세요.");
		}
		
		/** 2) 페이지 구현에 필요한 변수값 생성 */
		int totalCount = 0;				// 전체 회원 수
		int listCount = 10;				// 한 페이지당 표시할 목록 수
		int pageCount = 5;				// 한 그룹당 표시할 페이지 번호 수
		
		/** 3) 데이터 조회하기 */
		Calendar input = new Calendar();
		input.setMid(member.getId());
		
		List<Calendar> output = null;	// 조회결과가 저장될 객체
		PageData pageData = null;
		
		try {
			// 로그인한 회원의 일정 데이터 개수 조회
			totalCount = calendarService.getCalendarCount(input);
			// 페이지 번호 계산 --> 계산 결과를 로그로 출력할 것이다
			pageData = new PageData(nowPage, totalCount, listCount, pageCount);
			
			// SQL의 LIMIT절에서 사용될 값을 Beans의 static 변수에 저장
			Member.setOffset(pageData.getOffset());
			Member.setListCount(pageData.getListCount());
			
			// 데이터 조회하기
			output = calendarService.getCalendarList(input);
		} catch (Exception e) {
			/** 목록 조회 기능 구현하기
			 * 예외 발생시 메시지 처리 방법 수정
			 * --> 웹 페이지 이동을 위한 redirect() 호출 부분을 JSON 형식의 에러 메시지 출력으로 변경 */
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		
		/** View 처리 부분을 JSON 출력 형식으로 수정
		 * Restful은 스스로 UI를 갖는 형식이 아니기 때문에 View를 사용하지 않는다 */
		
		/** 4) JSON 출력하기 */
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("item", output);
		data.put("meta", pageData);
		
		log.debug("");
		return webHelper.getJsonData(data);
    }

	/** 작성 폼에 대한 action 페이지
	 * title, description, start, end, type, backgroundcolor, allDay, mid */
	@RequestMapping(value = "/rest/user/calendar", method = RequestMethod.POST)
	public Map<String, Object> post(
    		@SessionAttribute(value = "memInfo", required = false) Member member,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "description", required = false) String description,
			@RequestParam(value = "start", required = false) String start,
			@RequestParam(value = "end", required = false) String end,
			@RequestParam(value = "type", required = false) String type,
			@RequestParam(value = "backgroundcolor", required = false) String backgroundcolor) { 
		/** 1) 사용자가 입력한 파라미터에 대한 유효성 검사 */
		if (title.equals("")) 				{ return webHelper.getJsonWarning("제목을 입력하세요."); }
		if (start.equals("")) 				{ return webHelper.getJsonWarning("시작일을 선택하세요."); }
		if (end.equals("")) 				{ return webHelper.getJsonWarning("종료일을 선택하세요."); }
		if (backgroundcolor.equals("")) 	{ return webHelper.getJsonWarning("입사일을 입력하세요."); }
		
				
		/** 2) 데이터 저장하기 */
		// 저장할 값들을 Beans에 담는다.
		Calendar input = new Calendar();
		input.setTitle(title);
		input.setDescription(description);
		input.setStart(start);
		input.setEnd(end);
		input.setType(type);
		input.setBackgroundcolor(backgroundcolor);
		input.setMid(member.getId());
		
		
		// 저장된 결과를 조회하기 위한 객체
		Calendar output = null;
		
		try {
			// 데이터 저장 --> 성공시 파라미터로 전달하는 input 값에 PK값이 저장된다.
			calendarService.addCalendar(input);
			// 데이터 조회
			output = calendarService.getCalendarItem(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		
		/** 3) 결과를 확인하기 위한 JSON 출력하기 */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("item", output);
		return webHelper.getJsonData(map);
	}
	
	
	/** 삭제 처리 (페이지) */
	@RequestMapping(value = "/rest/user/calendar", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@RequestParam(value = "id", defaultValue = "0") int id) {
		/** 1) 사용자가 입력한 파라미터 유효성 검사 */
		if (id == 0)					 { return webHelper.getJsonWarning("일정을 선택하세요."); }
		
		/** 2) 데이터 삭제하기 */
		// 데이터 삭제에 필요한 조건값을 Beans에 저장하기
		Calendar input = new Calendar();
		input.setId(id);
		
		try {
			calendarService.deleteCalendar(input);
		} catch (Exception e) {
			return webHelper.getJsonError(e.getLocalizedMessage());
		}
		
		/** 3) 결과를 확인하기 위한 JSON 출력하기 */
		// 확인할 대상이 삭제된 결과값만 OK로 전달
		return webHelper.getJsonData(); 
	}
	
}
