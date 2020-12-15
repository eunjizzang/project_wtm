package com.spring.wtm.controllers;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.spring.wtm.helper.RegexHelper;
import com.spring.wtm.helper.WebHelper;
import com.spring.wtm.model.Hospital;
import com.spring.wtm.model.Member;
import com.spring.wtm.model.Reserve;
import com.spring.wtm.model.Review;
import com.spring.wtm.service.HospitalService;
import com.spring.wtm.service.ReserveService;
import com.spring.wtm.service.ReviewService;

@RestController
public class ReserveRestController {
	
	/** WebHelper 주입 */
    @Autowired  WebHelper webHelper;

    /** RegexHelper 주입 */
    @Autowired  RegexHelper regexHelper;

    /** Service 패턴 구현체 주입 */
    @Autowired  ReviewService reviewService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  HospitalService hospitalService;
    
    /** Service 패턴 구현체 주입 */
    @Autowired  ReserveService reserveService;
    
    /** "/프로젝트이름" 에 해당하는 ContextPath 변수 주입 */
    @Value("#{servletContext.contextPath}")
    String contextPath;
    
    /** 병원찾기 페이지 */
    @RequestMapping(value = "/rest/hospital.do", method = RequestMethod.GET)
    public Map<String, Object> get_item (
    		Model model,
    		// 드롭다운 - 진료과목 값
    		@RequestParam(value = "sub", required = false) String sub,
			// 드롭다운 - 시/도 값
			@RequestParam(value = "si", required = false) String si,
			// 드롭 다운 - 시/구 값
			@RequestParam(value = "gu", required = false) String gu,
			// 검색창 - 도로명 값
			@RequestParam(value = "dong", required = false) String dong) {
        
        /** 1) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
        Hospital input = new Hospital();
        // 진료과목
        input.setSub(sub);
        // 시/도
     	input.setAddr(si);
     	// 시/구
    	input.setAddr2(gu);
     	// 구
     	input.setAddr3(dong);
        
     	// Calendar 객체 생성
     	Calendar cal = Calendar.getInstance();
     	// 오늘 요일 구하기(1: 일요일, 2: 월요일 ... 6: 토요일)
     	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
     	
     	System.out.println("dayOfWeek===============>" + dayOfWeek);
     		
     	// 조회 결과를 저장할 객체 선언
     	int count = 0;
     	List<Hospital> output = null;
     		
     	// 데이터 조회
     	if (dayOfWeek == 1) {				// 일요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList1(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	else if (dayOfWeek == 2) {	// 월요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList2(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	else if (dayOfWeek == 3) {	// 화요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList3(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	else if (dayOfWeek == 4) {	// 수요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList4(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	else if (dayOfWeek == 5) {	// 목요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList5(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	else if (dayOfWeek == 6) {	// 금요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList6(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	else if (dayOfWeek == 7) {	// 토요일 데이터 조회
     		try {
     			count = hospitalService.getHospitalCount(input);
     			output = hospitalService.getHospitalList7(input);
     		} catch (Exception e) {
     			return webHelper.getJsonError(e.getLocalizedMessage());
     		}
     	}	
     		
     	/** 3) 결과를 확인하기 위한  JSON 출력 */
     	Map<String, Object> data = new HashMap<String, Object>();
        data.put("item", output);
        data.put("count", count);
        data.put("sub", sub);
        data.put("si", si);
        data.put("gu", gu);
        data.put("dong", dong);
             
        return webHelper.getJsonData(data); 
     }
   
    /** 병원별 상세 예약 페이지 */
    @RequestMapping(value = "/rest/hospital.do/{hospital_id}", method = RequestMethod.GET)
    public Map<String, Object> hospitalReserve(
    		@PathVariable(value = "hospital_id") int hospitalId) {
    	
    	System.out.println("==============rest통과================");
    	
    	/** 1) 데이터 조회하기 */
    	Hospital input1 = new Hospital();
    	input1.setHospitalId(hospitalId);
    	
    	Review input2 = new Review(); 
		input2.setHospitalHospitalId(hospitalId);
    	
    	// 조회결과를 저장할 객체 선언
    	Hospital output1 = null;
    	List<Review> output2 = null;
    	
    	try {
    		// 데이터 조회
    		output1 = hospitalService.getHospitalItem(input1);
    		output2 = reviewService.getReviewList2(input2);	
    	}	catch (Exception e) {
    		return webHelper.getJsonError(e.getLocalizedMessage());
    	}
    	
    	/** 2) 결과 확인을 위한 JSON 출력 */
    	// 확인할 대상이 삭제된 결과값만 OK로 전달
    	Map<String, Object> data = new HashMap<String, Object>();
        data.put("item", output1);
        
    	return webHelper.getJsonData();
    }
    
  
    @RequestMapping(value = "/reserveOk", method = RequestMethod.POST)
    public Map<String, Object> addReserve( 
    		@SessionAttribute(value = "memInfo", required = false) Member member,
    		@RequestParam(value = "hos_id", defaultValue = "0") int hospital,
    		 @RequestParam(value = "re_name", required = false) String reName,
			 @RequestParam(value = "re_tel", required = false) String reTel,
			 @RequestParam(value = "re_time", required = false) String reTime,
			 @RequestParam(value = "re_date", required = false) String reDate) {
    	
    	
    	/** 1) 파라미터 유효성 검사 */
		// 이 값이 존재하지 않으면 데이터 저장이 불가능하므로 반드시 필수값으로 처리해야 한다.
		if (member == null) {
			return webHelper.getJsonWarning("회원 정보가 없습니다.");
		}
		if (hospital < 1) {
			return webHelper.getJsonWarning("병원 정보가 없습니다.");
		}
		if (reName.equals("")) {
			return webHelper.getJsonWarning("예약자명을 입력해주세요.");
		}
		if (reTel.equals("")) {
			return webHelper.getJsonWarning("전화번호를 입력해주세요.");
		}
		if (reTime.equals("")) {
			return webHelper.getJsonWarning("시간을 입력해주세요.");
		}
		if (reDate.equals("")) {
			return webHelper.getJsonWarning("날짜를 입력해주세요.");
		}
    	/** 2) 데이터 저장하기 */
		Reserve input = new Reserve();
		input.setMemberId(member.getId());
		input.setHospitalHospitalId(hospital);
		input.setReName(reName);
		input.setReTel(reTel);
		input.setReTime(reTime);
		input.setReDate(reDate);
		
		try {
			reserveService.addReserve(input);
			
    	}	catch (Exception e) {
    		return webHelper.getJsonError(e.getLocalizedMessage());
    	}
    	
		return webHelper.getJsonData();
    	
    }
    
    /**
	 * 예약내역(reserve-1.jsp)에서 데이터 삭제 action
	 * @param session
	 * @param member
	 * @param reserveId
	 * @return
	 */
    @RequestMapping(value = "/reserve/cancel.do", method = RequestMethod.DELETE)
    public Map<String, Object> deleteCart(HttpSession session, 
            @SessionAttribute(value = "memInfo", required = false) Member member, 
            @RequestParam(value = "id", defaultValue= "0") int reserveId) {
    	
        /** 1) 데이터 삭제하기 */
        // 데이터 삭제에 필요한 조건 값을 Beans에 저장하기 
        Reserve input = new Reserve();
        
		
		if (member != null) { input.setMemberId(member.getId()); }
		

        if (reserveId > 0) {
        	input.setReserveId(reserveId);
        }
        
        System.out.println("빈즈에 저장된 예약 아이디 = " + input.getReserveId());
        
        try {
        	reserveService.deleteReserve(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }
        
        /** 2) 결과를 확인하기 위한 JSON 출력 */
        // 확인할 대상이 삭제된 결과값만 OK로 전달
        return webHelper.getJsonData();
    }
    
    /** 병원찾기 페이지 */
    @RequestMapping(value = "/rest/reserve.do", method = RequestMethod.GET)
    public Map<String, Object> res (
    		 @SessionAttribute(value = "memInfo", required = false) Member member) {
        
        /** 1) 데이터 조회하기 */
        // 조회에 필요한 조건값(검색어)를 Beans에 담는다.
    	Reserve input = new Reserve();
    	input.setMemberId(member.getId());
     	// 조회 결과를 저장할 객체 선언
     	List<Reserve> output = null;
     	
     	try {
        	output = reserveService.getReserveList2(input);
        } catch (Exception e) {
            return webHelper.getJsonError(e.getLocalizedMessage());
        }	
     	
     	/** 3) 결과를 확인하기 위한  JSON 출력 */
     	Map<String, Object> data = new HashMap<String, Object>();
        data.put("re", output);
             
        return webHelper.getJsonData(data); 
     }
}
