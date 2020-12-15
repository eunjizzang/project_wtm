package com.spring.wtm.service.impl;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

import com.spring.wtm.model.Hospital;
import com.spring.wtm.service.HospitalService;

/**  데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Slf4j
@Service
public class HospitalServiceImpl implements HospitalService {

    /** MyBatis */
    // --> import org.apache.ibatis.session.SqlSession
    @Autowired
    SqlSession sqlSession;

    /**
     *  데이터 상세 조회
     * @param input 조회할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    @Override
    public Hospital getHospitalItem(Hospital input) throws Exception {
        Hospital result = null;

        try {
            result = sqlSession.selectOne("HospitalMapper.selectItem", input);

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
     *  데이터 목록 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    @Override
    public List<Hospital> getHospitalList(Hospital input) throws Exception {
        List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList", input);
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
     * 병원 데이터 목록 조회 - 일요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList1(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList1", input);
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
     * 병원 데이터 목록 조회 - 월요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList2(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList2", input);
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
     * 병원 데이터 목록 조회 - 화요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList3(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList3", input);
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
     * 병원 데이터 목록 조회 - 수요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList4(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList4", input);
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
     * 병원 데이터 목록 조회 - 목요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList5(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList5", input);
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
     * 병원 데이터 목록 조회 - 금요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList6(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList6", input);
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
     * 병원 데이터 목록 조회 - 토요일
     * @param input 검색조건을 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Hospital> getHospitalList7(Hospital input) throws Exception {

		List<Hospital> result = null;

        try {
            result = sqlSession.selectList("HospitalMapper.selectList7", input);
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
     *  데이터가 저장되어 있는 갯수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int getHospitalCount(Hospital input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.selectOne("HospitalMapper.selectCountAll", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
    }

    /**
     *  데이터 등록하기
     * @param input 저장할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int addHospital(Hospital input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("HospitalMapper.insertItem", input);

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
     *  데이터 수정하기
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int editHospital(Hospital input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("HospitalMapper.updateItem", input);
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
     *  데이터 삭제하기
     * @param input 삭제할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int deleteHospital(Hospital input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.delete("HospitalMapper.deleteItem", input);
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
