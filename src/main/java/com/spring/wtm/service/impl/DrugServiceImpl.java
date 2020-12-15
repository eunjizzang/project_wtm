package com.spring.wtm.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wtm.model.Drug;
import com.spring.wtm.service.DrugService;

import lombok.extern.slf4j.Slf4j;

/** 약국 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Service
@Slf4j
public class DrugServiceImpl implements DrugService {
	
	/** MyBatis */
	@Autowired
	SqlSession sqlSession;
	
	/**
     * 약국 데이터 상세 조회
     * @param input 조회할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
	@Override
	public Drug getDrugItem(Drug input) throws Exception {
		
		Drug result = null;
		
		try {
            result = sqlSession.selectOne("DrugMapper.selectItem", input);

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
     * 약국 데이터 목록 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList", input);
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
     * 약국 데이터 목록 조회 - 일요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList1(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList1", input);
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
     * 약국 데이터 목록 조회 - 월요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList2(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList2", input);
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
     * 약국 데이터 목록 조회 - 화요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList3(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList3", input);
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
     * 약국 데이터 목록 조회 - 수요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList4(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList4", input);
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
     * 약국 데이터 목록 조회 - 목요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList5(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList5", input);
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
     * 약국 데이터 목록 조회 - 금요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList6(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList6", input);
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
     * 약국 데이터 목록 조회 - 토요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Drug> getDrugList7(Drug input) throws Exception {

		List<Drug> result = null;

        try {
            result = sqlSession.selectList("DrugMapper.selectList7", input);
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
     * 약국 데이터가 저장되어 있는 개수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
	@Override
	public int getDrugCount(Drug input) throws Exception {
		int result = 0;
		
		try {
            result = sqlSession.selectOne("DrugMapper.selectCountAll", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }
		
		return result;
	}

}
