<%
/**
* @filename    : find-pw.jsp
* @description : --- 비번 재발급 페이지 ---

				사용자가 입력한 정보와 
				가입시 저장된 정보가 일치하면
				랜덤 비밀번호를 생성한 후
				DB 수정 & 이메일로 발송을 한다

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>

<!-- sweetalert 플러그인 참조 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/plugins/sweetalert/sweetalert2.min.css" />
    
<!-- AjaxHelper -->
<script src="<%=request.getContextPath()%>/assets/plugins/ajax/ajax_helper.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/plugins/ajax/ajax_helper.css"/>

<!-- Handlebars plugin -->
<script src="<%=request.getContextPath()%>/assets/plugins/handlebars/handlebars-v4.0.11.js"></script>

<!-- 비번찾기 페이지에 적용될 CSS 속성 -->
<style>
	/** 비밀번호 재발급 컨텐츠 영역*/
	.find-pw-contents {
		width: 300px;
		min-height: 600px;
		padding-top: 100px;
	}
	
	/** 정보 입력란 스타일 */
	.find-pw-box {
		margin-top: 20px;
	}
	
	/** 입력폼과 버튼 사이의 간격 */
	.find-pw-box > .find-pw-form > input,button {
		margin-top: 10px;
		margin-bottom: 10px;
	}
</style>
<!--// 비번찾기 페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="find-pw-contents container text-center">
    <h1>비밀번호 재발급</h1>
    가입시 저장한 정보를 바르게 입력해 주세요. <br />
	<div class="find-pw-box content" >
		<!-- 
			`임시~발급`버튼을 클릭하면 회원db에서 조회한다.
			회원 이름과 아이디, 이메일 #name, #user_id, #email
		 -->
		<form class="find-pw-form" id="find-pw-form" method="post" action="${pageContext.request.contextPath}/login/mail.do">
		<%-- 이름은 한글을 사용하므로 별도의 디코딩 작업이 필요하다. model을 통해 전달 받기 --%>
		<c:choose>
			<c:when test="${name != ''}">
				<input type="text" name="name" id="name" class="form-control" placeholder="이름" value="${name}">
			</c:when>
			<c:otherwise>
				<input type="text" name="name" id="name" class="form-control" placeholder="이름">
			</c:otherwise>
		</c:choose>
			<input type="text" name="user_id" id="user_id" class="form-control" placeholder="아이디">
			<input type="email" name="email" id="email" class="form-control" placeholder="이메일">
			<button type="submit" class="btn btn-info btn-block">임시 비밀번호 발급 <i class="fas fa-user-circle"></i></button>
		</form>
	</div>
	
	<small>
	<br />
	이메일이 오지 않는다면 기재한 정보를 확인하여
	<br />
	다시 발급버튼을 눌러 주시기 바랍니다
	</small>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- sweetalert 플러그인 참조 -->
<script src="<%=request.getContextPath()%>/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>

<%@ include file="../_inc/footer.jsp"%>

<script type="text/javascript">
	/* url에 get방식으로 파라미터 값이 넘어왔다면, 파싱하여 해당 input태그에 값을 넣어준다 */
	function getUrlParams() {
	    var params = {};
	    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
	    return params;
	}
	window.onload = function() {
		urlParams = getUrlParams();
		
		$("#user_id").val(urlParams.id);
		//$("#name").val(urlParams.name);		// 이름은 한글을 사용하므로 decoding작업 필수로 진행한다.
		$("#email").val(urlParams.email);
	}
	
	$(function() {		
		/** 전체 회원 정보 조회를 위해 post 방식으로 ajax 요청 */
		$("#find-pw-form").submit(function(e) {
			//e.preventDefault();
			// 입력값 검사
			var name = $("#name").val();
			if (!name) {
				swal({
					title: "이름을 입력해주세요.",
					type: "error"
				}).then(function(result) {
					setTimeout(function() {
						$("#name").focus();
					}, 100);
				});
				return false;
			}
			var user_id = $("#user_id").val();
			if (!user_id) {
				swal({
					title: "아이디를 입력해주세요.",
					type: "error"
				}).then(function(result) {
					setTimeout(function() {
						$("#user_id").focus();
					}, 100);
				});
				return false;
			}
			var email = $("#email").val();
			if (!email) {
				swal({
					title: "이메일을 입력해주세요.",
					type: "error"
				}).then(function(result) {
					setTimeout(function() {
						$("#email").focus();
					}, 100);
				});
				return false;
			}

		}); // end submit
	});
</script>
