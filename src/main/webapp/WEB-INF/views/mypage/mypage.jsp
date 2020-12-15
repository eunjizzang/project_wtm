<%/**
 *@FileName : mypage.jsp
 *@프로그램 설명  : 마이페이지
 *@작성자 : 정은지 (ejzzang56@gmail.com)
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- ========== 컨텐츠 영역 시작 ========== -->
<style>
.content1{float:left;width:400px;height:600px;}
.info{margin-left:27%; margin-top:10px;}
.box1{
	border:2px solid #ccc;
	margin-top:150px;
	width:300px; height:150px;
}
.box2{
background-color: #eee;
	margin-top:75px;
	border:2px solid #ccc;
	width:300px;
	height:175px;
}
.box3{
	margin-top:75px;
	background-color: #eee;
	border:2px solid #ccc;
	width:300px;
	height:175px;
}
.box4{
background-color: #eee;
	border:2px solid #ccc;
	width:300px;
	height:175px;
}
.box5{
background-color: #eee;
	border:2px solid #ccc;
	width:300px;
	height:175px;
}
.profile{border-bottom:1px solid #ccc;}
.profile>h4{margin-left:20px;}
.profiledetail{margin-left:20px;}
.content2{width:350px;float:left;height:300px;}
.content3{width:350px;float:left;height:300px;}
.content4{width:350px;float:left;height:300px;}
.content5{width:350px;float:left;height:300px;}
.list-group{width:280px;margin-left:8px;margin-bottom:5px;text-align:center;}
body > div.container > div.content2 > div > div.detail > button{background-color:#999;}
body > div.container > div.content2 > div > div.detail > button > a{color:#fff}
body > div.container > div.content3 > div > div.detail > button{background-color:#999;}
body > div.container > div.content3 > div > div.detail > button > a{color:#fff}
body > div.container > div.content4 > div > div.detail > button{background-color:#999;}
body > div.container > div.content4 > div > div.detail > button > a{color:#fff}
body > div.container > div.content5 > div > div.detail > button{background-color:#999;}
body > div.container > div.content5 > div > div.detail > button > a{color:#fff}
.detail{margin-left:220px;margin-top:5px;margin-bottom:5px;heigt:25px;}
.name{float:left;margin-left:10px;}
</style>
<div class="container" style="width: 1150px;">
<div class="content1">
<div class="box1">
    <div class="profile"><h4><strong>프로필</strong></h4></div>
        <div class="profiledetail">
            <h4>이름: ${memInfo.userName}</h4>
            <h4>아이디: ${memInfo.userId}</h4>
            <h4>이메일: ${memInfo.email}</h4>
        </div>
    </div>
    <div class="info">
	    <a href="<%=request.getContextPath()%>/mypage/update-pw.do"><button type="button" class="btn btn-info">정보수정</button></a>
	</div>
</div>

<div class="content2">
<div class="box2">
<div class="name"><h4><strong>주문내역</strong></h4></div>
<div class="detail">
	    <a href="<%=request.getContextPath()%>/mypage/order.do"><button type="button" class="btn btn-default">더보기</button></a>
	</div>
	<div class="list-group">
		<c:choose>
		
			<%-- 조회결과가 없는 경우 --%>
			<c:when test="${output == null || fn:length(output) == 0}">
			    <div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px; padding-left: 0px">
			        <h4 align="center" style="background-color: white; width: 280px; margin-top: 0px; height: 123px; padding-top: 50px; border-radius: 4px; border:1px solid #ddd">주문내역이 없습니다.</h4>
			    </div>
			</c:when>
			<%-- 조회결과가 있는 경우 --%>
			<c:otherwise>
				<%-- 조회결과에 따른 반복 처리 --%>
		   		<c:forEach begin="0" end="2" var="item" items="${output}" varStatus="status">
		   			<%-- 상세페이지로 이동하기 위한 URL --%>
			        <c:url value="/mypage/order-detail.do" var="viewUrl">
			            <c:param name="id" value="${item.id}" />
			        </c:url>
			        <!-- 주문내역 -->
			        <c:forEach begin="0" end="0" var="info" items="${item.prodInfo}" varStatus="status">
		           		<a href="${viewUrl}"class="list-group-item" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${info.name}</a>
		            </c:forEach>
	        	</c:forEach>
	        </c:otherwise>
			
		</c:choose>
	</div>
</div>
</div>
<div class="content3">
<div class="box3">
<div class="name"><h4><strong>예약내역</strong></h4></div>
<div class="detail">
	    <a href="<%=request.getContextPath()%>/mypage/my-reserve.do"><button type="button" class="btn  btn-default">더보기</button></a>
	</div>
<div class="list-group">
            <c:choose>
		
			<%-- 조회결과가 없는 경우 --%>
			<c:when test="${output2 == null || fn:length(output2) == 0}">
			    <div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px; padding-left: 0px">
			        <h4 align="center" style="background-color: white; width: 280px; margin-top: 0px; height: 123px; padding-top: 50px; border-radius: 4px; border:1px solid #ddd">예약내역이 없습니다.</h4>
			    </div>
			</c:when>
			<%-- 조회결과가 있는 경우 --%>
			<c:otherwise>
				<%-- 조회결과에 따른 반복 처리 --%>
		   		<c:forEach begin="0" end="2" var="item2" items="${output2}" varStatus="status">
		   			<%-- 상세페이지로 이동하기 위한 URL --%>
			        <c:url value="/my-reserve/reserve-1.do" var="viewUrl">
			            <c:param name="reserve_id" value="${item2.reserveId}" />
			        </c:url>
		           		<a href="${viewUrl}"class="list-group-item" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${item2.name}</a>
		            
	        	</c:forEach>
	        </c:otherwise>
			
		</c:choose>
        </div>
</div>
</div>
<div class="content4">
<div class="box4">
<div class="name"><h4><strong>달력</strong></h4></div>
<div class="detail">
	    <a href="<%=request.getContextPath()%>/calendar"><button type="button" class="btn btn-default">더보기</button></a>
	</div>
<div class="list-group">
            <c:choose>
		
			<%-- 조회결과가 없는 경우 --%>
			<c:when test="${output3 == null || fn:length(output3) == 0}">
			    <div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px; padding-left: 0px">
			        <h4 align="center" style="background-color: white; width: 280px; margin-top: 0px; height: 123px; padding-top: 50px; border-radius: 4px; border:1px solid #ddd">일정이 없습니다.</h4>
			    </div>
			</c:when>
			<%-- 조회결과가 있는 경우 --%>
			<c:otherwise>
				<%-- 조회결과에 따른 반복 처리 --%>
		   		<c:forEach begin="0" end="2" var="item3" items="${output3}" varStatus="status">
		   			<%-- 상세페이지로 이동하기 위한 URL --%>
			        <c:url value="/calendar" var="viewUrl">
			        </c:url>
		           		<a href="${viewUrl}"class="list-group-item" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${item3.title}</a>
		            
	        	</c:forEach>
	        </c:otherwise>
			
		</c:choose>
        </div>
</div>
</div>

</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>