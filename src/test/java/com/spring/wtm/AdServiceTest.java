package com.spring.wtm;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.wtm.model.Ad;
import com.spring.wtm.service.AdService;

import lombok.extern.slf4j.Slf4j;

/** Lombok의 Log4j 객체 */
@Slf4j
/** JUnit에 의한 테스트 클래스로 정의 */
@RunWith(SpringJUnit4ClassRunner.class)
/** Spring의 설정 파일들을 읽어들이도록 설정 (**은 `모든`이라는 의미) */
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*-context.xml" })
/** 웹 어플리케이션임을 명시 */
@WebAppConfiguration
/** 메서드 이름순서로 실행하도록 설정 (설정하지 않을 경우 무작위 순서로 실행됨) */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class AdServiceTest {
	
	@Autowired
	private AdService adService;
	
	/** 광고 데이터 조회 테스트 */
	@Test
	public void testA() {
		Ad ad = new Ad();
		ad.setAdid(1);
		
		Ad output = null;
		
		try {
			output = adService.getAdItem(ad);
			log.debug(output.toString());
		}catch(Exception e) {
			log.error(e.getLocalizedMessage());
			e.printStackTrace();
		}
	}
}
