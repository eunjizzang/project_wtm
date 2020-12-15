package com.spring.wtm.service;

import java.util.List;

import com.spring.wtm.model.Review;

/** 리뷰 데이터 관리 기능을 제공하기 위한 Service 계층. */
public interface ReviewService {
    /**
     * 리뷰 데이터 상세 조회
     * @param Review 조회할 리뷰의 일련번호를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    public Review getReviewItem(Review input) throws Exception;
    
    /**
     * 리뷰 데이터 목록 조회
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    public List<Review> getReviewList(Review input) throws Exception;
    
    /**
     * 리뷰 데이터 목록 조회2 (reserve.jsp - 병원별 리뷰 목록)
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    public List<Review> getReviewList2(Review input) throws Exception;
    
    /**
     * 리뷰 데이터가 저장되어 있는 갯수 조회
     * @return int
     * @throws Exception
     */
    public int getReviewCount(Review input) throws Exception;
    
    /**
     * 리뷰 데이터 등록하기
     * @param Review 저장할 정보를 담고 있는 Beans
     * @throws Exception
     */
    public int addReview(Review input) throws Exception;
    
    /**
     * 리뷰 데이터 수정하기
     * @param Review 수정할 정보를 담고 있는 Beans
     * @throws Exception
     */
    public int editReview(Review input) throws Exception;
    
    /**
     * 리뷰 데이터 삭제하기
     * @param Review 삭제할 리뷰의 일련번호를 담고 있는 Beans
     * @throws Exception
     */
    public int deleteReview(Review input) throws Exception;
    
}