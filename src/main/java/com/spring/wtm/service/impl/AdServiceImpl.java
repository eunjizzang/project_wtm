package com.spring.wtm.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wtm.model.Ad;
import com.spring.wtm.service.AdService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class AdServiceImpl implements AdService{
	
	/** MyBatis */
	@Autowired
	SqlSession sqlSession;
	
	/**
     * 광고 데이터 상세 조회
     * @param 조회할 광고의 일련번호를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
	@Override
	public Ad getAdItem(Ad input) throws Exception {
		
		Ad result = null;
		
		 try {
	            result = sqlSession.selectOne("AdMapper.selectItem", input);

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
     * 광고 데이터 목록 조회
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
	@Override
	public List<Ad> getAdList(Ad input) throws Exception {
		
		 List<Ad> result = null;

	        try {
	            result = sqlSession.selectList("AdMapper.selectList", input);

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
     * 광고 데이터 저장하기
     * @param 저장할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int addAd(Ad input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("AdMapper.insertItem", input);

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
     * 광고 데이터 수정하기
     * @param 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int editAd(Ad input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("AdMapper.updateItem", input);

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
     * 광고 데이터 삭제하기
     * @param 삭제할 광고의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    @Override
    public int deleteAd(Ad input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.delete("AdMapper.deleteItem", input);

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
