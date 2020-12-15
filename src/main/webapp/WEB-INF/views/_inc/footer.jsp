
<%
	/**
* @filename    : footer.jsp
* @description : --- include 파일 ---
* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!-- footer -->
<div class="footer">
	<div class="container">
		<div class="footer-info">
			<h3>
				<i class="fas fa-laptop-code"></i> Programmers
			</h3>
			<ul class="list-unstyled">
				<li><a href="#"><i class="fas fa-smile-wink"></i> Park
						Sooin</a></li>
				<li><a href="#"><i class="far fa-smile-wink"></i> Oh Hyejin</a></li>
				<li><a href="#"><i class="fas fa-kiss-beam"></i> Lee Minhee</a></li>
				<li><a href="#"><i class="far fa-kiss-beam"></i> Lee
						Sanghee</a></li>
				<li><a href="<%=request.getContextPath()%>/mypage"><i
						class="fas fa-laugh"></i> Jeong Eunji</a></li>
			</ul>
		</div>
		<div class="footer-info">
			<h3>
				<i class="fas fa-sitemap"></i> Site Map
			</h3>
			<ul class="list-unstyled">
				<li><a href="#"><i class="fas fa-long-arrow-alt-right"></i>
						약검색</a></li>
				<li><a href="<%=request.getContextPath()%>/hospital"><i
						class="fas fa-long-arrow-alt-right"></i> 병원검색</a></li>
				<li><a href="#"><i class="fas fa-long-arrow-alt-right"></i>
						약국검색</a></li>
				<li><a href="#"><i class="fas fa-long-arrow-alt-right"></i>
						달력</a></li>
				<li><a href="#"><i class="fas fa-long-arrow-alt-right"></i>
						쇼핑</a></li>
			</ul>
		</div>
		<div class="footer-info">
			<h3>
				<i class="fas fa-briefcase-medical"></i> Medical Services
			</h3>
			<ul class="list-unstyled">
				<li><a href="<%=request.getContextPath()%>/hospital"><i
						class="fas fa-long-arrow-alt-right"></i> 병원 예약</a></li>
				<li><a href="#"><i class="fas fa-long-arrow-alt-right"></i>
						24시 약국 찾기</a></li>
			</ul>
		</div>
	</div>
</div>
<!-- Copyright *항상 하단에 고정 -->
<footer class="text-right container-fluid navbar-fixed-bottom">
	Copyright &copy;
	<script>
		document.write(new Date().getFullYear());
	</script>
	All rights reserved by 이거모약
</footer>
<!-- footer 끝 -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 코로나현황 바로가기 버튼 floating button custom -->
<a href="<%=request.getContextPath()%>/#covid19" class="float">
	<i class="fas fa-virus my-float"></i>
</a>
<div class="label-container">
	<div class="label-text">코로나 국내 현황</div>
	<i class="fa fa-play label-arrow"></i>
</div>
<!-- // 코로나현황 바로가기 버튼 -->

</body>

</html>