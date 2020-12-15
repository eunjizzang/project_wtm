package com.spring.wtm.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.spring.wtm.model.Medicine;
import com.spring.wtm.service.MedicineService;

import lombok.extern.slf4j.Slf4j;

/** 약정보 조회 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Slf4j
@Service // --> import org.springframework.stereotype.Service;
public class MedicineServiceImpl implements MedicineService {

	/** MyBatis */
	// --> import org.apache.ibatis.session.SqlSession
	@Autowired
	SqlSession sqlSession;

	/**
	 * 약 정보 조회
	 * 
	 * @param Medicine 조회할 약정보의 일련번호를 담고 있는 Beans
	 * @return 조회된 데이터가 저장된 Beans
	 * @throws Exception
	 */
	@Override
	public Medicine getMedicineItem(Medicine input) throws Exception {
		Medicine result = null;

		try {
			result = sqlSession.selectOne("MedicineMapper.selectItem", input);

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
	 * 약정보검색 목록 조회
	 * 
	 * @return 조회 결과에 대한 컬렉션
	 * @throws Exception
	 */
	@Override
	public List<Medicine> getMedicineList(Medicine input) throws Exception {
		List<Medicine> result = null;

		try {
			result = sqlSession.selectList("MedicineMapper.selectList", input);

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
	 * 약정보 데이터가 저장되어 있는 갯수 조회
	 * 
	 * @return int 
	 * @throws Exception
	 */
	@Override
	public int getMedicineCount(Medicine input) throws Exception {
		int result = 0;

		try {
			result = sqlSession.selectOne("MedicineMapper.selectCountAll", input);
		} catch (Exception e) {
			log.error(e.getLocalizedMessage());
			throw new Exception(" 데이터 조회에 실패했습니다");
		}
		return result;
	}

}