package com.spring.wtm.model;

/** `` 테이블의 POJO 클래스 (20/10/04 14:00:53) */
public class CovidRegion {
    /** , IS NULL */
    private String 지역;

    /** , IS NULL */
    private String 누적확진자;

    /** , IS NULL */
    private String 누적격리해제;

    /** , IS NULL */
    public void set지역(String 지역) {
        this.지역 = 지역;
    }

    /** , IS NULL */
    public String get지역() {
        return this.지역;
    }

    /** , IS NULL */
    public void set누적확진자(String 누적확진자) {
        this.누적확진자 = 누적확진자;
    }

    /** , IS NULL */
    public String get누적확진자() {
        return this.누적확진자;
    }

    /** , IS NULL */
    public void set누적격리해제(String 누적격리해제) {
        this.누적격리해제 = 누적격리해제;
    }

    /** , IS NULL */
    public String get누적격리해제() {
        return this.누적격리해제;
    }

    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;

    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
        CovidRegion.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
        CovidRegion.listCount = listCount;
    }

    @Override
    public String toString() {
        String str = "\n[CovidRegion]\n";
        str += "지역: " + this.지역 + " (, IS NULL)\n";
        str += "누적확진자: " + this.누적확진자 + " (, IS NULL)\n";
        str += "누적격리해제: " + this.누적격리해제 + " (, IS NULL)\n";
        return str;
    }
}
