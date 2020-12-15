package com.spring.wtm.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wtm.model.Cart;
import com.spring.wtm.service.CartService;

import lombok.extern.slf4j.Slf4j;

/** 장바구니 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Service
@Slf4j
public class CartServiceImpl implements CartService {
	
	/** MyBatis */
	@Autowired
	SqlSession sqlSession;
	
	/**
     * 장바구니 데이터 상세 조회
     * @param input 조회할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
	@Override
	public Cart getCartItem(Cart input) throws Exception {
		
		Cart result = null;

        try {
            result = sqlSession.selectOne("CartMapper.selectItem", input);

            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("조회된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 장바구니 데이터 목록 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Cart> getCartList(Cart input) throws Exception {
		
		List<Cart> result = null;

        try {
            result = sqlSession.selectList("CartMapper.selectList", input);
            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("조회된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}

	/**
     * 장바구니 데이터 목록 조회2
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Cart> getCartList2(Cart input) throws Exception {
		
		List<Cart> result = null;

        try {
            result = sqlSession.selectList("CartMapper.selectList2", input);
            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("조회된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 장바구니 데이터가 저장되어 있는 개수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int getCartCount(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.selectOne("CartMapper.selectCountAll", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 회원 장바구니 데이터가 저장되어 있는 개수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int getCartCount2(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.selectOne("CartMapper.selectCount2", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 장바구니 데이터에 상품이 동일한 갯수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int getSameCount(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.selectOne("CartMapper.selectCount", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 장바구니 데이터 등록하기
     * @param input 저장할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int addCart(Cart input) throws Exception {
		
		int result = 0;

        try {
            result = sqlSession.insert("CartMapper.insertItem", input);

            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("저장된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 저장에 실패했습니다.");
        }

        return result;
	}

	/**
     * 장바구니 데이터 수정하기1 = 같은 상품 담았을 경우 수량/단가*수량 수정
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int editCart(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.update("CartMapper.updateItem", input);
            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 장바구니 데이터 수정하기2 =  비회원 장바구니 => 회원 장바구니 유지
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int editCart2(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.update("CartMapper.updateItem2", input);
            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
	}
	
	/**
     * 장바구니 데이터 수정하기3 = 장바구니(cart.jsp)에서 결제 페이지로 이동(체크된 cart.id 기준 수량 & 가격 수정)
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int editCart3(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.update("CartMapper.updateItem3", input);
            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("수정된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 수정에 실패했습니다.");
        }

        return result;
	}

	/**
     * 장바구니 데이터 개별/전체 삭제하기
     * @param input 삭제할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int deleteCart(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.delete("CartMapper.deleteItem", input);
            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("삭제된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 삭제에 실패했습니다.");
        }

        return result;
	}

	/**
     * 스케쥴러 - 장바구니 한달된 데이터 삭제하기
     * @param input 삭제할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int deleteCart2(Cart input) throws Exception {

		int result = 0;

        try {
            result = sqlSession.delete("CartMapper.deleteItem2", input);
            if (result == 0) {
                throw new NullPointerException("result=0");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("삭제된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 삭제에 실패했습니다.");
        }

        return result;
	}

}
