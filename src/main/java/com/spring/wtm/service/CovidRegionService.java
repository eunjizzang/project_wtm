package com.spring.wtm.service;

import java.util.List;
import com.spring.wtm.model.CovidRegion;

public interface CovidRegionService {

    /**
     *  데이터 상세 조회
     * @param input 조회할 데이터의 일련번호(PK)를 담고 있는 Beans
     * @return 조회된 데이터가 저장된 Beans
     * @throws Exception
     */
    public CovidRegion getCovidRegionItem(CovidRegion input) throws Exception;

    /**
     *  데이터 목록 조회
     * @param input 검색조건과 페이지 구현 정보를 담고 있는 Beans
     * @return 조회 결과에 대한 컬렉션
     * @throws Exception
     */
    public List<CovidRegion> getCovidRegionList(CovidRegion input) throws Exception;

    /**
     *  데이터가 저장되어 있는 갯수 조회
     * @param input 검색조건을 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int getCovidRegionCount(CovidRegion input) throws Exception;

    /**
     *  데이터 등록하기
     * @param input 저장할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int addCovidRegion(CovidRegion input) throws Exception;

    /**
     *  데이터 수정하기
     * @param input 수정할 정보를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int editCovidRegion(CovidRegion input) throws Exception;

    /**
     *  데이터 삭제하기
     * @param input 삭제할 의 일련번호를 담고 있는 Beans
     * @return int
     * @throws Exception
     */
    public int deleteCovidRegion(CovidRegion input) throws Exception;

}
