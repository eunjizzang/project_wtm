<%
/**
* @filename    : login.jsp
* @description : --- 로그인 페이지 ---
* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>

<!-- 로그인 페이지에만 적용될 CSS 속성 -->
<style type="text/css">
/** 로그인 컨텐츠영역 크기 지정 */
.login-contents {
	height: 600px;
}

/** 로그인 박스의 위치와 크기, 배경 색 */
.login-box {
	width: 360px;
	height: 450px;
/* 	카카오 로그인 추가인 경우에는 top:60px */
	padding: 100px 10px 10px 10px;
	background-color: #F2F2F2;
	/* 	투명도
    opacity: 0.5; */
	position: absolute;
	top: 230px;
	/* 부모를 기준으로 움직여서 정 가운데보다 오른쪽으로 치우쳐짐 */
	left: 50%;
	/* 자식을 기준으로 50% 움직인다 */
	transform: translate(-50%);
	margin: auto;
	text-align: left;
}

/** 로그인 박스 하위 폼태그 위치, 크기 지정*/
.login-form {
	margin: auto;
	width: 250px;
	height: auto;
}

/** 로그인 페이지(폼태그) 안의 모든 버튼 공통 스타일 적용 */
.login-box>form>.login-contents-btn>.btn {
	/* 넓이 100% */
	width: 100%;
}

/** 회원가입 버튼 스타일 */
.signup-btn {
	margin: 10px 0 10px 0;
	color: white;
	background-color: #2E9AFE;
}

/** 카카오계정 로그인 버튼 스타일 */
.kakao-btn {
	/* 카카오톡 시그니처 색상 */
	background-color: #F7E600;
}

.kakao-btn>.kakao-icon {
	/* 아이콘과 텍스트 사이의 마진 */
	margin-right: 10%
}

/** 아이디 찾기 / 비밀번호 찾기 링크 사이의 마진 */
.login-form>.login-link>a:nth-child(1) {
	margin-right: 5%
}
</style>
<!-- //로그인 페이지에만 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container login-contents"></div>
<div class="login-box">
	<form class="form-horizontal login-form" name="login_form" id="login_form" method="post" action="${pageContext.request.contextPath}/login/login_ok.do">
		<!-- 아이디 입력 박스 -->
		<div class="form-group">
			<c:choose>
				<c:when test="${cookie.save_uid == null}">
					<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해 주세요" required>
				</c:when>
				<c:otherwise>
					<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해 주세요" value="${cookie.save_uid.value}" required>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 비밀번호 입력 박스 -->
		<div class="form-group">
			<input type="password" class="form-control" name="user_pw" placeholder="비밀번호를 입력해 주세요" required>
		</div>
		<!-- 로그인, 회원가입, 카카오계정로그인 버튼 -->
		<div class="login-contents-btn form-group">
			<button type="submit" class="login-btn btn btn-warning">로그인</button>
			<a class="signup-btn btn"
				href="<%=request.getContextPath()%>/login/join-agree.do">회원가입</a>
<!-- 
			<button type="button" class="kakao-btn btn" onclick="loginFormWithKakao()">
				<div class="kakao-icon fas fa-comment"></div>
				카카오 계정으로 로그인
			</button>
 -->			
<%-- 			<a class="btn btn-warning" href="${kakao_url}"><i class="kakao-icon fas fa-comment"></i>&nbsp; 카카오 계정으로 로그인</a> --%>
<!-- 
			<button type="button" class="btn btn-default api-btn" onclick="unlinkApp()">카카오톡 로그아웃</button>
 -->			
		</div>
		<!-- 체크박스 2종 -->
		<div class="login-chkbox form-group">
			<div class="checkbox">
				<c:choose>
					<c:when test="${cookie.save_uid == null || cookie.save_uid.value == ''}">
						<label><input type="checkbox" id="save_uid" name="save_uid" value="Y"> 아이디 저장</label>
					</c:when>
					<c:otherwise>
						<label><input type="checkbox" id="save_uid" name="save_uid" value="Y" checked> 아이디 저장</label>
					</c:otherwise>
				</c:choose>
			</div>
<!-- 			<div class="checkbox"> -->
<!-- 				<label><input type="checkbox" name="save_mem" value="Y"> 로그인 상태 유지</label> -->
<!-- 			</div> -->
		</div>
		<!-- 단순링크 2종 -->
		<div class="login-link form-group">
			<a href="<%=request.getContextPath()%>/login/find-id1.do">아이디찾기</a> <a href="<%=request.getContextPath()%>/login/find-pw.do">비밀번호 찾기</a>
		</div>
	</form>
</div>

<p id="login-form-result"></p>

<!--// ========== 컨텐츠 영역 끝 ========== -->
<script type="text/javascript">

	/* url에 get방식으로 파라미터 값이 넘어왔다면, 파싱하여 해당 input태그에 값을 넣어준다 */
	function getUrlParams() {
	    var params = {};
	    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
	    return params;
	}
		
	window.onload = function() {
		urlParams = getUrlParams();
		if (urlParams.id != undefined) {
			$("#user_id").val(urlParams.id);
		}
	};

</script>

<%@ include file="../_inc/footer.jsp"%>
