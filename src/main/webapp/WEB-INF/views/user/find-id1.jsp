<%
/**
* @filename    : find-id1.jsp
* @description : --- 아이디찾기 페이지 ---

				사용자가 입력한 정보와 
				가입시 저장된 정보가 일치하면
				다음페이지로 넘어간다

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>

<!-- 아이디찾기(1)페이지에 적용될 CSS 속성 -->
<style>
/** 아이디찾기(1) 페이지 스타일 */
.find-id-contents {
	width: 300px;
	min-height: 600px;
	padding-top: 100px;
}

/** 정보 입력란 스타일 */
.find-id-box {
	margin-top: 20px;
}

/** 입력폼과 버튼 사이의 간격 */
.find-id-form > input,button {
	margin-top: 10px;
	margin-bottom: 10px;
}
</style>
<!--// 아이디찾기(1)페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="find-id-contents container text-center">
    <h1>아이디찾기</h1>
    가입시 저장한 정보를 바르게 입력해 주세요. <br />
	<div class="content find-id-box">
	<!-- 
		`찾기`버튼을 클릭하면 회원db에서 조회한다.
		회원 이름과 이메일 #name, #email
	 -->
		<form class="find-id-form" id="find-id-form" method="post" action="${pageContext.request.contextPath}/login/find-id2.do">
			<input type="text" name="name" id="name" class="form-control" placeholder="이름"> 
			<input type="email" name="email" id="email" class="form-control" placeholder="이메일">
			<button type="submit" class="btn btn-info btn-block">찾기 <i class="fas fa-user-circle"></i></button>
		</form>
	</div>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->

<%@ include file="../_inc/footer.jsp"%>

<script type="text/javascript">
	function moveFindId() {
		location.href = "find-id2.do";
	}
	
	$(function() {
		/** 전체 회원 정보 조회를 위해 post 방식으로 ajax 요청 */
		$("#find-id-form").submit(function(e) {
			//e.preventDefault();
			// 값이 없을 경우
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
