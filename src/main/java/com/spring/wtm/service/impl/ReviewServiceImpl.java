package com.spring.wtm.service.impl;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.wtm.model.Review;
import com.spring.wtm.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

/** 리뷰 데이터 관리 기능을 제공하기 위한 Service 계층에 대한 구현체 */
@Slf4j
@Service  // --> import org.springframework.stereotype.Service;
public class ReviewServiceImpl implements ReviewService {

    /** MyBatis */
    // --> import org.apache.ibatis.session.SqlSession
    @Autowired
    SqlSession sqlSession;

    /**
     * 리뷰 데이터 상세 조회
     * @param Review 조회할 리뷰의 일련번호를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    @Override
    public Review getReviewItem(Review input) throws Exception {
    	Review result = null;

        try {
            result = sqlSession.selectOne("ReviewMapper.selectItem", input);

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
     * 리뷰 데이터 목록 조회
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    @Override
    public List<Review> getReviewList(Review input) throws Exception {
        List<Review> result = null;

        try {
            result = sqlSession.selectList("ReviewMapper.selectList", input);

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
     * 리뷰 데이터 목록 조회2 (reserve.jsp - 병원별 리뷰 목록)
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    @Override
    public List<Review> getReviewList2(Review input) throws Exception {
        List<Review> result = null;

        try {
            result = sqlSession.selectList("ReviewMapper.selectList2", input);

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
     * 리뷰 데이터가 저장되어 있는 갯수 조회
     * @return int
     * @throws Exception
     */
    @Override
    public int getReviewCount(Review input) throws Exception {
        int result = 0;
        
        try {
            result = sqlSession.selectOne("ReviewMapper.selectCountAll", input);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }
        
        return result;
    }

    /**
     * 리뷰 데이터 등록하기
     * @param Review 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int addReview(Review input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.insert("ReviewMapper.insertItem", input);

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
     * 리뷰 데이터 수정하기
     * @param Review 수정할 정보를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int editReview(Review input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.update("ReviewMapper.updateItem", input);

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
     * 리뷰 데이터 삭제하기
     * @param Review 삭제할 학과의 일련번호를 담고 있는 Beans
     * @throws Exception
     */
    @Override
    public int deleteReview(Review input) throws Exception {
        int result = 0;

        try {
            result = sqlSession.delete("ReviewMapper.deleteItem", input);

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