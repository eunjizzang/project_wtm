package com.spring.wtm.model;

/** `` 테이블의 POJO 클래스 (20/10/04 14:00:53) */
public class CovidConfirm {
    /** , IS NULL, MUL */
    private String 날짜;

    /** , IS NULL */
    private String 치료중;

    /** , IS NULL */
    private String 누적확진자;

    /** , IS NULL */
    private String 확진자;

    /** , IS NULL */
    private String 누적사망자;

    /** , IS NULL */
    private String 사망자;

    /** , IS NULL */
    private String 누적격리해제;

    /** , IS NULL */
    private String 격리해제;

    /** , IS NULL, MUL */
    public void set날짜(String 날짜) {
        this.날짜 = 날짜;
    }

    /** , IS NULL, MUL */
    public String get날짜() {
        return this.날짜;
    }

    /** , IS NULL */
    public void set치료중(String 치료중) {
        this.치료중 = 치료중;
    }

    /** , IS NULL */
    public String get치료중() {
        return this.치료중;
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
    public void set확진자(String 확진자) {
        this.확진자 = 확진자;
    }

    /** , IS NULL */
    public String get확진자() {
        return this.확진자;
    }

    /** , IS NULL */
    public void set누적사망자(String 누적사망자) {
        this.누적사망자 = 누적사망자;
    }

    /** , IS NULL */
    public String get누적사망자() {
        return this.누적사망자;
    }

    /** , IS NULL */
    public void set사망자(String 사망자) {
        this.사망자 = 사망자;
    }

    /** , IS NULL */
    public String get사망자() {
        return this.사망자;
    }

    /** , IS NULL */
    public void set누적격리해제(String 누적격리해제) {
        this.누적격리해제 = 누적격리해제;
    }

    /** , IS NULL */
    public String get누적격리해제() {
        return this.누적격리해제;
    }

    /** , IS NULL */
    public void set격리해제(String 격리해제) {
        this.격리해제 = 격리해제;
    }

    /** , IS NULL */
    public String get격리해제() {
        return this.격리해제;
    }

    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;

    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
        CovidConfirm.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
        CovidConfirm.listCount = listCount;
    }

    @Override
    public String toString() {
        String str = "\n[CovidConfirm]\n";
        str += "날짜: " + this.날짜 + " (, IS NULL, MUL)\n";
        str += "치료중: " + this.치료중 + " (, IS NULL)\n";
        str += "누적확진자: " + this.누적확진자 + " (, IS NULL)\n";
        str += "확진자: " + this.확진자 + " (, IS NULL)\n";
        str += "누적사망자: " + this.누적사망자 + " (, IS NULL)\n";
        str += "사망자: " + this.사망자 + " (, IS NULL)\n";
        str += "누적격리해제: " + this.누적격리해제 + " (, IS NULL)\n";
        str += "격리해제: " + this.격리해제 + " (, IS NULL)\n";
        return str;
    }
}
