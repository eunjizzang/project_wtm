package com.spring.wtm.service;

import java.util.List;

import com.spring.wtm.model.Cart;

/** 장바구니 데이터 관리 기능을 제공하기 위한 Service 계층 */
public interface CartService {
	
	/**
     *  장바구니 데이터 상세 조회
     * @param input 조회할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    public Cart getCartItem(Cart input) throws Exception;

    /**
     * 장바구니 데이터 목록 조회
     * @param input 검색조건과 페이지 구현 정보를 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    public List<Cart> getCartList(Cart input) throws Exception;

    /**
     *  장바구니 데이터 목록 조회2
     * @param input 조회할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    public List<Cart> getCartList2(Cart input) throws Exception;
    
    /**
     * 장바구니 데이터가 저장되어 있는 갯수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int getCartCount(Cart input) throws Exception;
    
    /**
     * 회원 장바구니 데이터가 저장되어 있는 갯수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int getCartCount2(Cart input) throws Exception;
    
    /**
     * 장바구니 데이터에 동일한 갯수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int getSameCount(Cart input) throws Exception;

    /**
     * 장바구니 데이터 등록하기
     * @param input 저장할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int addCart(Cart input) throws Exception;

    /**
     * 장바구니 데이터 수정하기1 = 같은 상품 담았을 경우 수량/단가*수량 수정
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int editCart(Cart input) throws Exception;
    
    /**
     * 장바구니 데이터 수정하기2 =  비회원 장바구니 => 회원 장바구니 유지
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int editCart2(Cart input) throws Exception;
    
    /**
     * 장바구니 데이터 수정하기3 = 장바구니(cart.jsp)에서 결제 페이지로 이동(체크된 cart.id 기준 수량 & 가격 수정)
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int editCart3(Cart input) throws Exception;

    /**
     * 장바구니 데이터 개별/전체 삭제하기
     * @param input 삭제할 의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int deleteCart(Cart input) throws Exception;
    
    /**
     * 스케쥴러 - 장바구니 한달된 데이터 삭제하기
     * @param input 삭제할 의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int deleteCart2(Cart input) throws Exception;

}
