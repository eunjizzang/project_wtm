
<%
	/**
 *@FileName : reserve.jsp
 *@프로그램 설명  :	병원 예약 페이지
 *@작성자 : 정은지 (ejzzang56@gmail.com)
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- jQuery UI CSS파일  -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<!-- jQuery 기본 js파일 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<!-- jQuery UI 라이브러리 js파일 -->
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>  
<!-- ========== 컨텐츠 영역 시작 ========== -->
<style type="text/css">
a {
	color: #000000;
	text-decoration: none;
}

.scriptCalendar {
	text-align: center;
	width: 450px;
}

.scriptCalendar>thead>tr>td {
	width: 50px;
	height: 50px;
}

.scriptCalendar>thead>tr:first-child>td {
	font-weight: bold;
}

.scriptCalendar>thead>tr:last-child>td {
	background-color: #90EE90;
}

.scriptCalendar>tbody>tr>td {
	width: 50px;
	height: 50px;
}

.star {
	margin-top: 10px;
	font-size: 20px;
	text-align: center;
}

.startxt {
	margin-top: 50px;
	margin-bottom: 50px;
	font-size: 15px;
	text-align: center;
}

.hos {
	margin-top: 10px;
	font-size: 30px;
	text-align: center;
}

.content1 {
	float: left;
	margin-top: 100px;
	width: 450px;
	height: 700px;
}

.content2 {
	margin-top: 80px;
	margin-left: 485px;
	padding-bottom: 20px;
	width: 450px;
	height: 350px;
	font-size: 20px;
}

.content3 {
	margin-top: 20px;
	margin-left: 500px;
	width: 450px;
	height: auto;
	font-size: 20px;
	margin-bottom: 20px;
}

.review {
	float: left;
	margin-top: 50px;
	margin-left: 120px;
	margin-right: 10px;
	font-size: 20px;
}

.review-info {
	clear: left;
	margin-top: 50px;
	margin-left: 50px;
}

.input {
	margin-left: 200px;
}



.reserveok {
	margin-left: 100px;
}

.name {
	padding-right: 20px;
}

.all {
	padding-top: 30px;
}

.re1 {
	font-size: 20px;
	padding-left: 20px;
}

.re2 {
	font-size: 20px;
	padding-left: 20px;
}

.re3 {
	font-size: 20px;
	padding-left: 20px;
}

.scriptCalendar>thead>tr:last-child>td {
	background-color: #ece6ff;
}
</style>


<div class="container">
<input type="hidden" id ="userId" name="userId" value="${memInfo.userId}" />
	<div class="content1">
	
		<div class="hos">
			
            <span> ${output1.name} </span>
            
		</div>
		<div class="startxt">
			<br>병원을 이용한 <br>예약자들의 리뷰입니다
		</div>
		
		<span class="input">
			<button type="button" class="btn btn-default btn-xs">
				<a href="<%=request.getContextPath()%>/reserve/review.do">더보기</a>
			</button>
		</span>
		<div class="review-info">
			<table>
        <thead>
            <tr>
                <th width="300" align="center">내용</th>
                <th width="100" align="center">작성자</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <%-- 조회결과가 없는 경우 --%>
                <c:when test="${output2 == null || fn:length(output2) == 0}">
                    <tr>
                        <td colspan="2" align="center">리뷰가 없습니다.</td>
                    </tr>
                </c:when>
                <%-- 조회결과가 있는  경우 --%>
                <c:otherwise>
                    <%-- 조회 결과에 따른 반복 처리 --%>
                    <c:forEach begin="0" end="4" var="item" items="${output2}" varStatus="status">
                        <tr>
                            <td height="30" align="center">${item.content}</td>
                            <td height="30" align="center">${item.memberId}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
    
		</div>


	</div>

	<div class="content2">
		
	<form name="addForm" id="addForm" action="${pageContext.request.contextPath}/reserveOk" method="post">
			<input type="hidden" id="hosId" name="hosId" value="${output1.hospitalId}" />
			<br>
			<strong>날짜</strong> <input id="datepicker" class="reDate" name="reDate" type="text" autocomplete="off">
			<hr />
			<strong>시간</strong> 
			
			<input type="text" name="reTime" id="reTime" autocomplete="off">

			<hr />
			<strong>예약자정보</strong>
			<hr />
			<div class="info">
				<label for="user_name">이름</label>
				<div>
					<input type="text" name="reName" id="reName"
						class="form-control" value="${memInfo.userName}" />
				</div>
				<br /> <label for="tel">전화번호 </label>
				<div>
					<input type="text" name="reTel" id="reTel" class="form-control" value="${memInfo.tel}" />
				</div>
				<br>
				</div>
				<div class="all">
					<input type="checkbox" id="all_check"> &nbsp; <strong><label for="all_check">이용자 약관 전체동의</label></strong>
				</div>
				<br> <a class="btn btn-primary" data-toggle="modal"
					href='#modal-id'>개인정보 수집 동의</a>
				<!-- modal창 구현 부분 (대체로 <body> 끝나기 전에 모아놓는다.) -->
				<div class="modal fade" id="modal-id">
					<!-- 팝업창 영역 지정. .modal-lg, .modal-sm 과 함께 사용하여 크기 지정 가능 -->
					<div class="modal-dialog">
						<div class="modal-content">
							<!-- 이 안의 내용은 자유롭게 구성 가능함 -->
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">개인정보 수집 동의</h4>
							</div>
							<div class="modal-body">
								<개인정보 수집 동의>
								<br />

								1. 기본수집항목: [필수] 이거모약? 아이디, 이름, (휴대)전화번호, [선택] 이메일 주소 <br />
								※ 추가 수집하는 필수항목<br />
								- 배송, 방문 등이 필요한 상품 구매 시 : 주소<br />
								- 해외 여행 관련 상품 구매 시 : 여권상 영문명, 여권번호 끝 4자리, 성별, 생년월일, 이메일주소,
								카카오톡ID, 동행 아동정보(여권상 영문명, 생년월일, 신장)<br />
								- 병원을 이용하는 경우: 생년월일<br />

								2. 수집 및 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 고객상담, 불만처리 등 민원 처리, 분쟁조정
								해결을 위한 기록보존, 이거모약? 예약 이용 후 리뷰작성에 따른 네이버페이 포인트 지급 및 관련 안내<br />

								3. 보관기간<br />
								- 회원탈퇴 등 개인정보 이용목적 달성 시까지 보관<br />
								- 단, 상법 및 ‘전자상거래 등에서의 소비자 보호에 관한 법률’ 등 관련 법령에 의하여 일정 기간 보관이 필요한
								경우에는 해당 기간 동안 보관함<br />

								4. 동의 거부권 등에 대한 고지: 정보주체는 개인정보의 수집 및 이용 동의를 거부할 권리가 있으나, 이 경우 상품
								및 서비스 예약이 제한될 수 있습니다.<br />
							</div>
						</div>
					</div>
				</div>
				<a class="btn btn-primary" data-toggle="modal" href='#modal-id'>개인정보
					제공 동의</a>
				<!-- modal창 구현 부분 (대체로 <body> 끝나기 전에 모아놓는다.) -->
				<div class="modal fade" id="modal-id">
					<!-- 팝업창 영역 지정. .modal-lg, .modal-sm 과 함께 사용하여 크기 지정 가능 -->
					<div class="modal-dialog">
						<div class="modal-content">
							<!-- 이 안의 내용은 자유롭게 구성 가능함 -->
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">개인정보 제공 동의</h4>
							</div>
							<div class="modal-body">
								<개인정보 제공 동의>
								<br />

								1. 개인정보를 제공받는 자 : 이거모약?<br />

								2. 제공하는 기본 개인정보 항목: [필수] 이거모약? 아이디, 이름, (휴대)전화번호, 성별, 연령대, [선택]
								이메일 주소<br />
								※ 추가 제공하는 필수항목<br />
								- 배송, 방문 등이 필요한 상품 구매 시 : 주소<br />
								- 해외 여행 관련 상품 구매 시 : 여권상 영문명, 여권번호 끝 4자리, 생년월일, 이메일주소, 카카오톡ID,
								동행 아동정보(여권상 영문명, 생년월일, 신장)<br />
								- 병원을 이용하는 경우: 생년월일<br />

								3. 개인정보를 제공받는 자의 이용목적 : 사업자회원과 예약이용자의 원활한 거래 진행, 서비스 분석과 통계에 따른
								혜택 및 맞춤 서비스 제공, 민원처리 등 고객상담, 고객관리, 서비스 이용에 따른 설문조사 및 혜택 제공,
								분쟁조정을 위한 기록보존<br />

								4. 개인정보를 제공받는 자의 개인정보 보유 및 이용기간 :이거모약? 회원탈퇴 시 또는 위 개인정보 이용목적 달성
								시 까지 이용합니다.<br />

								5. 동의 거부권 등에 대한 고지 : 정보주체는 개인정보 제공 동의를 거부할 권리가 있으나, 이 경우 상품 및
								서비스 예약이 제한될 수 있습니다.<br />
							</div>
						</div>
					</div>
				</div>
				<br> <span class="reserveok">
					<button type="submit" class="btn btn_reserve">예약 신청하기</button>
				</span>
		</form>

	</div>
</div>

<script src="../assets/js/regex.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script type="text/javascript">
$('#reTime').timepicker({
    timeFormat: 'H:mm',
    interval: 60,
    minTime: '9',
    maxTime: '18',
    defaultTime: '9',
    startTime: '09:00',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});
$("#datepicker").datepicker({
        dateFormat: 'yy-mm-dd',	//날짜 포맷이다. 보통 yy-mm-dd 를 많이 사용하는것 같다.
        prevText: '이전 달',	// 마우스 오버시 이전달 텍스트
        nextText: '다음 달',	// 마우스 오버시 다음달 텍스트
        closeText: '닫기', // 닫기 버튼 텍스트 변경
        currentText: '오늘', // 오늘 텍스트 변경
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더중 월 표시를 위한 부분
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],	//한글 캘린더 중 월 표시를 위한 부분
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],	//한글 캘린더 요일 표시 부분
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],	//한글 요일 표시 부분
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],	// 한글 요일 표시 부분
        showMonthAfterYear: true,	// true : 년 월  false : 월 년 순으로 보여줌
        yearSuffix: '년',	//
        showButtonPanel: true,	// 오늘로 가는 버튼과 달력 닫기 버튼 보기 옵션
        maxDate : "+2w",	//선택할 수 있는 최대 날짜  +1m +1w 은 1달 1주일 뒤 까지 선택가능  [+,-][숫자][y,m,w,d] 
        minDate : "0d"	//선택할 수 있는 최소 날짜

    });
</script>
<!--Google CDN 서버로부터 jQuery 참조 -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- jQuery Ajax Form plugin CDN -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"></script>
    <!-- jQuery Ajax Setup -->
    <script src="${pageContext.request.contextPath}/assets/plugins/ajax/ajax_helper.js"></script>
    <!-- User Code -->
<script>
$(function() {
$(".btn_reserve").click(function(e) {
	e.preventDefault();
	
	console.log($("#userId").val());
	
	if ($("#userId").val() != null) {
    	swal({
		title: "확인",
	    text: "예약하시겠습니까?",
	    type: "question",
	    confirmButtonText: "확인",
	    showCancelButton: true,
	    cancelButtonText: "취소",
	}).then(function(result) {
		if (result.value) {
			
			console.log($("#hosId").val() + $("#reName").val() + $("#reTel").val() + $("#reTime").val() + $(".reDate").val()) 
			
			$.post("${pageContext.request.contextPath}/reserveOk", 
					{"hos_id": $("#hosId").val(),
					"re_name": $("#reName").val(), 
					"re_tel": $("#reTel").val(),
					"re_time": $("#reTime").val(),
					"re_date": $(".reDate").val()},
					function(json) {
						console.log()
						swal({
							title : "예약내역페이지로 이동합니다.", 			
							html : "", 										
							type : "success", 								
							confirmButton : true, 				
							confirmButtonText : "확인", 	
						}).then(function() {
							window.location.href = "${pageContext.request.contextPath}/reserve/my.do";			
						});
					});
				}
			});
		}
    });
});
</script>

<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>
