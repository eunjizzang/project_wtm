package com.spring.wtm.model;

/** `캘린더(일정) 관리 테이블` 테이블의 POJO 클래스 (20/10/05 03:43:28) */
public class Calendar {
    /** , IS NOT NULL, PRI */
    private int Id;

    /** 일정 제목, IS NULL */
    private String title;

    /** 간결한 요약, IS NULL */
    private String description;

    /** , IS NULL */
    private String start;

    /** , IS NULL */
    private String end;

    /** , IS NULL */
    private String type;

    /** 게시자, IS NULL */
    private String typename;

    /** 일정 색상, IS NULL */
    private String backgroundcolor;

    /** 검정색, IS NULL */
    private String textColor;

    /** 하루종일 여부, IS NULL */
    private Boolean allDay;

    /** 회원일련번호, IS NULL */
    private Integer mid;

    /** , IS NOT NULL, PRI */
    public void setId(int Id) {
        this.Id = Id;
    }

    /** , IS NOT NULL, PRI */
    public int getId() {
        return this.Id;
    }

    /** 일정 제목, IS NULL */
    public void setTitle(String title) {
        this.title = title;
    }

    /** 일정 제목, IS NULL */
    public String getTitle() {
        return this.title;
    }

    /** 간결한 요약, IS NULL */
    public void setDescription(String description) {
        this.description = description;
    }

    /** 간결한 요약, IS NULL */
    public String getDescription() {
        return this.description;
    }

    /** , IS NULL */
    public void setStart(String start) {
        this.start = start;
    }

    /** , IS NULL */
    public String getStart() {
        return this.start;
    }

    /** , IS NULL */
    public void setEnd(String end) {
        this.end = end;
    }

    /** , IS NULL */
    public String getEnd() {
        return this.end;
    }

    /** , IS NULL */
    public void setType(String type) {
        this.type = type;
    }

    /** , IS NULL */
    public String getType() {
        return this.type;
    }

    /** 게시자, IS NULL */
    public void setTypename(String typename) {
        this.typename = typename;
    }

    /** 게시자, IS NULL */
    public String getTypename() {
        return this.typename;
    }

    /** 일정 색상, IS NULL */
    public void setBackgroundcolor(String backgroundcolor) {
        this.backgroundcolor = backgroundcolor;
    }

    /** 일정 색상, IS NULL */
    public String getBackgroundcolor() {
        return this.backgroundcolor;
    }

    /** 검정색, IS NULL */
    public void setTextcolor(String textColor) {
        this.textColor = textColor;
    }

    /** 검정색, IS NULL */
    public String getTextcolor() {
        return this.textColor;
    }

    /** 하루종일 여부, IS NULL */
    public void setAllday(Boolean allDay) {
        this.allDay = allDay;
    }

    /** 하루종일 여부, IS NULL */
    public Boolean getAllday() {
        return this.allDay;
    }

    /** 회원일련번호, IS NULL */
    public void setMid(Integer mid) {
        this.mid = mid;
    }

    /** 회원일련번호, IS NULL */
    public Integer getMid() {
        return this.mid;
    }

    /** LIMIT 절에서 사용할 조회 시작 위치 */
    private static int offset;

    /** LIMIT 절에서 사용할 조회할 데이터 수 */
    private static int listCount;

    public static int getOffset() {
        return offset;
    }

    public static void setOffset(int offset) {
        Calendar.offset = offset;
    }

    public static int getListCount() {
        return listCount;
    }

    public static void setListCount(int listCount) {
        Calendar.listCount = listCount;
    }

    @Override
    public String toString() {
        String str = "\n[Calendar]\n";
        str += "Id: " + this.Id + " / ";
        str += "title: " + this.title + " / ";
        str += "description: " + this.description + " / ";
        str += "start: " + this.start + " / ";
        str += "end: " + this.end + " / ";
        str += "type: " + this.type + " / ";
        str += "typename: " + this.typename + " / ";
        str += "backgroundcolor: " + this.backgroundcolor + " / ";
        str += "textColor: " + this.textColor + " / ";
        str += "allDay: " + this.allDay + " / ";
        str += "mid: " + this.mid;
        return str;
    }
}
