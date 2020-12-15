<%
/**
* @filename    : find-id2.jsp
* @description : --- 아이디찾음 페이지 ---

				아이디와 가입시간을 보여준다

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!-- 현재날짜를 출력하기 위해 import -->
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="../_inc/header.jsp"%>

<!-- 아이디찾기(2)페이지에 적용될 CSS 속성 -->
<style>
/** 아이디찾기(2) 페이지 스타일 */
.find-id-contents {
	width: 400px;
	min-height: 600px;
	padding-top: 100px;
}

/** 버튼형태의 input태그 스타일 */
.find-id-contents > .input-group {
	display: inline-block;
}
</style>
<!--// 아이디찾기(2)페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="find-id-contents container text-center">
    <h1>아이디찾기</h1>
    고객님의 정보와 일치하는 아이디 입니다.
    <br /><br />
	<div class="jumbotron">
		<!-- 
			회원 아이디와 가입일시 (부정 가입 방지를 위해 알려준다)
			#user_id, #join_date
		 -->
		<%-- 컨트롤러에서 Model 객체를 통해 넘어온 값 출력 --%>
		<c:choose>
			<c:when test="${output != ''}">
				<strong id="user_id">${output.userId}</strong><br />
				가입일시: <span id="join_date">${output.regDate}
				<%--
				Date now = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				out.println(sf.format(now));
				--%>
				</span>				
			</c:when>
		</c:choose> 
	</div>
	<div class="input-group text-center">
		<!-- 각 페이지로 이동하고 받아온 값을 보내준다 -->
		<input class="btn btn-info" type="button" value="로그인하기"
		 onclick="location.href='/wtm/login?id=${output.userId}'">
		<input class="btn btn-info" type="button" value="비밀번호 찾기"
		 onclick="location.href='find-pw.do?id=${output.userId}&name=${input.userName}&email=${input.email}'"> 
	</div>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>
