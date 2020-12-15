package com.spring.wtm.service;

import java.util.List;

import com.spring.wtm.model.Medicine;


/** 약검색 비지니스 로직을 정의한 인터페이스 */
public interface MedicineService {
	
	/**
	 * 약 데이터 상세조회
	 * @param Medicine 조회할 약의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Benas
	 * @throws Exception
	 */
	public Medicine getMedicineItem(Medicine input) throws Exception;
	
	/**
	 * 약 데이터 목록 조회
	 * @param input
	 * @return
	 * @throws Exception
	 */
	public List<Medicine> getMedicineList(Medicine input) throws Exception;
	
	/**
	 * 약 데이터가 저장되어 있는 개수 조회
	 * @param 검색 조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getMedicineCount(Medicine input) throws Exception;

	
}
