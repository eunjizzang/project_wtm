package com.spring.wtm.service;

import java.util.List;

import com.spring.wtm.model.Drug;

/** 상품 데이터 관리 기능을 제공하기 위한 Service 계층 */
public interface DrugService {
	
	/**
	 * 약국 데이터 상세 조회
	 * @param Drug 조회할 상품의 일련번호를 담고 있는 Beans
	 * @return	조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	public Drug getDrugItem(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 일요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList1(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 월요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList2(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 화요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList3(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 수요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList4(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 목요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList5(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 금요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList6(Drug input) throws Exception;
	
	/**
	 * 약국 데이터 목록 조회 - 토요일
	 * @param Drug 검색 조건과 페이지 구현 정보를 담고 있는 Beans
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	public List<Drug> getDrugList7(Drug input) throws Exception;
	
	/**
	 * 약국 데이터가 저장되어 있는 개수 조회
	 * @param 검색조건을 담고 있는 Beans
	 * @return int
	 * @throws Exception
	 */
	public int getDrugCount(Drug input) throws Exception;
}
