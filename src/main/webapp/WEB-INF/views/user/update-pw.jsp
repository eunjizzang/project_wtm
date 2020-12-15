<%
/**
* @filename    : update-pw.jsp
* @description : --- 회원정보 수정전 페이지 ---

				

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

<style>
/** 페이지 컨텐츠 스타일 - 크기 지정 */
.update-pw-contents { width: 360px; min-height: 600px; padding-top: 100px; }
/* 검색 버튼의 둥글기 */
button.btn-info { border-radius: 0 4px 4px 0; }
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="update-pw-contents container text-center">
	<div class="top">
		<span><img src="<%=request.getContextPath()%>/assets/img/user.png"></span>
		<p> <b>회원 정보 수정</b> </p>
	</div>
	<div class="content input-group">
		<!-- 
			회원 비밀번호 #user_pw
		 -->
		<form class="user-pw-form" id="updatepw-form" method="post" action="${pageContext.request.contextPath}/mypage/update-pw_ok.do">
			<input type="password" name="user_pw" id="user_pw" class="form-control" placeholder="비밀번호를 입력하세요" style="width: 280px;">
			<button type="submit" class="btn btn-info btn-block" style="width: 50px;">확인</button>
		</form>
	</div>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- sweetalert 플러그인 참조 -->
<script src="<%=request.getContextPath()%>/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>

<%@ include file="../_inc/footer.jsp"%>

<script type="text/javascript">
	function moveUpdate() {
		location.href = "update.do";
	} 
	
	$(function() {
		//** 현재 로그인한 회원의 비밀번호 조회를 위해 post 방식으로 ajax 요청 *
		$("#updatepw-form").submit(function(e) {
			
			//e.preventDefault(); <-- 이거때문에 뭐 못하는데..??
			
			var user_pw = $("#user_pw").val();
			// 값이 없을 경우 -> 값을 넣어주세요 return false;
			if (!user_pw) {
				swal({
					title: "비밀번호를 입력해주세요.",
					type: "error"
				}).then(function(result) {
					setTimeout(function() {
						// 커서를 비밀번호 입력창으로 이동시킨다
						$("#user_pw").focus();
					}, 100);
				});
				return false;
			}
		}); // end submit
	});
</script>