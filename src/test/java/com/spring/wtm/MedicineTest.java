package com.spring.wtm;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.wtm.model.Medicine;
import com.spring.wtm.service.MedicineService;

import lombok.extern.slf4j.Slf4j;

/** Lombok의 Log4j 객체 */
//import lombok.extern.slf4j.Slf4j;
@Slf4j
/** JUnit에 의한 테스트 클래스로 정의 */
//import org.junit.runner.RunWith;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class)
/** Spring의 설정 파일들을 읽어들이도록 설정 (**은 `모든` 이라는 의미) */
//import org.springframework.test.context.ContextConfiguration;
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*-context.xml" })
/** 웹 어플리케이션임을 명시 */
//import org.springframework.test.context.web.WebAppConfiguration;
@WebAppConfiguration
/** 메서드 이름순서로 실행하도록 설정 (설정하지 않을 경우 무작위 순서로 실행됨) */
//import org.junit.FixMethodOrder;
@FixMethodOrder(MethodSorters.NAME_ASCENDING)

public class MedicineTest {
	/** Service 객체 주입 설정 */
	@Autowired
	private MedicineService medicineService;

	/** MyBatis */
	// --> import org.apache.ibatis.session.SqlSession
	@Autowired
	SqlSession sqlSession;

	/** 약정보 단일행 조회 테스트 */
	//@Test
	/*
	 * public void testA() { // 검색조건으로 사용될 POJO클래스 객체 Medicine input = new
	 * Medicine(); input.setItemName("리단정(탄산리튬)");
	 * 
	 * Medicine output = null;
	 * 
	 * try { output = medicineService.getMedicineItem(input);
	 * log.debug(output.toString()); } catch (Exception e) {
	 * log.error(e.getLocalizedMessage()); e.printStackTrace(); }
	 * 
	 * System.out.println(output.toString()); }
	 */

	/** 약검색 리스트 (다중행)조회 테스트 */
	//@Test
	/*
	 * public void testB() { Medicine input = new Medicine();
	 * input.setItemName("타이레놀");
	 * 
	 * List<Medicine> output = null;
	 * 
	 * try { output = medicineService.getMedicineList(input);
	 * 
	 * for (Medicine item : output) { log.debug(item.toString()); } } catch
	 * (Exception e) { log.error(e.getLocalizedMessage()); e.printStackTrace(); }
	 * System.out.println(output.toString()); }
	 */

//	/** 다중행조회 테스트 */
//	@Test
//	public void testC() {
//		Medicine input = new Medicine();
//		input.setItemName("타이레놀");
//		sqlSession.selectList("MedicineMapper.selectList", input);
//	}

	/** 데이터수 조회 테스트 */
	//@Test
	/*
	 * public void testC() { int count = 0;
	 * 
	 * try { count = medicineService.getMedicineCount(null);
	 * log.debug("전체 데이터 수: "+count); } catch (Exception e) {
	 * log.error(e.getLocalizedMessage()); e.printStackTrace(); } }
	 */
}
