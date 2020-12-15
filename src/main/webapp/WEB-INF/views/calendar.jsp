<%
/**
* @filename    : calendar.html
* @description : --- 달력 페이지 ---

				구현중

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="./_inc/header.jsp"%>
    
<!-- 캘린더 관련 CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/calendar/vendor/css/fullcalendar.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/calendar/vendor/css/select2.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/calendar/vendor/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/calendar/css/main.css">

<!-- 달력 페이지에 적용될 CSS 속성 -->
<style>
    /* 캘린더 페이지에서 반드시 적용될 css */
    body { margin: 0; padding: 0; }
    
    /* 주말버튼 숨기기 */
    .fc-viewWeekends-button { display: none; }
    
	#eventModal > div > div > div.modal-body {
		padding-top: 0; 
	}
	#eventModal > div > div {
		margin: 100px 100px 0 100px;
	}
	
	/* 일정 입력, 수정 팝업 모달의 label */
	#eventModal > div > div > div.modal-body label {
		width: auto;
		border: 0;
		padding: 0;
		margin: 10px 0 0 0;
		color: #2E9AFE;
		background: none;
	}
	
	/* 주말 날짜 색상 */
	#calendar .fc-sun > span { color: red; }
	#calendar .fc-sun > a { color: red; }
	#calendar .fc-sat > span { color: #0082ea; }
	#calendar .fc-sat > a { color: #0082ea; }
	/* 주중 날짜 색상 */
	#calendar .fc-day-number { color: #505363; }
	
	/* 각 일정 시간 숨기기 */
	.fc-day-grid-event .fc-time { display: none; }
</style>
<!--// 달력 페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
    <!-- 캘린더 시작 -->
    <div class="container" style="width: 1100px; padding-top: 30px;">
        <!-- 일자 클릭시 메뉴오픈 -->
        <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">기타 일정</a></li>
                <li><a tabindex="-1" href="#">병원 예약</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div>

        <div id="wrapper">
            <div id="loading"></div>
            <div id="calendar"></div>
        </div>

        <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal form-control" type="text" name="edit-title" id="edit-title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start" style="display: contents;">시작 / 종료</label>
                                <div class="" style="display: flex;">
                                <input class="form-control" type="text" name="edit-start" id="edit-start"/>~
                                <input class="form-control" type="text" name="edit-end" id="edit-end"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-type">구분</label>
                                <select class="form-control" name="edit-type" id="edit-type">
                                    <option value="기타 일정">기타 일정</option>
                                    <option value="병원 예약">병원 예약</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="form-control" name="color" id="edit-color">
                                    <option value="lightcoral" style="color:lightcoral;">Coral</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">Orange</option>
                                    <option value="mediumaquamarine" style="color:mediumaquamarine;">Aquamarine</option>
                                    <option value="yellowgreen" style="color:yellowgreen;">Green</option>
                                    <option value="deepskyblue" style="color:deepskyblue;">Skyblue</option>
                                    <option value="mediumpurple" style="color:mediumpurple;">Purple</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">설명</label>
                                <textarea rows="4" cols="50" class="inputModal form-control" name="edit-desc"
                                    id="edit-desc"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">FILTER</h3>
            </div>
            <div class="panel-body">
                <label for="calendar_view">일정별</label>
                <div class="input-group">
                        <label class="checkbox-inline"><input class="filter" type="checkbox" value="0" checked>추가한 일정만 확인하기</label>
                        <label class="checkbox-inline"><input class="filter" type="checkbox" value="1" checked>병원 예약만 확인하기</label>
                </div>
            </div>
        </div>
        <br />
        <!-- /.filter panel -->
    </div>
    <!-- /.container 캘린더 끝 -->

<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="./_inc/footer.jsp"%>

<!-- 캘린더 관련 js -->
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/fullcalendar.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/ko.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/vendor/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/js/addEvent.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/js/editEvent.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/js/etcSetting.js"></script>
<script src="<%=request.getContextPath()%>/assets/calendar/js/main.js"></script>
