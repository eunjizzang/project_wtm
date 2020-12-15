<%/**
 *@FileName : my-reserve.jsp
 *@프로그램 설명  :	병원 예약내역 페이지
 *@작성자 : 정은지 (ejzzang56@gmail.com)
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- ========== 컨텐츠 영역 시작 ========== -->

<style>
.thumbnail{
	margin-bottom:10px;
	width:300px; height:150px;
}
 a {
        color: #222;
    }
.reserve {
float:left;
}
a:hover {
        text-decoration: none;
        color: #222;
	}
.content1{
    margin-left:200px; 
    margin-top:50px;
    font-size: 18px; 
    margin-bottom:10px;
    }
.content2{
    margin-left:160px; 
    margin-right:160px; 
    padding-top:1px; 
    background-color: #f1f1f1;
    height:400px;
    }
.content2 >p{
	font-size: 18px; 
	margin-left:10px; 
	margin-bottom: 0px; 
	margin-top: 5px;
}
.reserve{
	width:300px; 
	float:left; 
	margin:5px;
}
.info{
	margin-left:20px; 
}
.state1{
	 
	height:35px;
}

nav{
margin-top: 350px;
margin-bottom: 50px;
margin-left: 250px;}
</style>
<div class="container">
<input type="hidden" id ="reservedate" name="reservedate" value="${item.reDate}" />
<div class="content1">
${memInfo.userName} <small>님</small><br/>
${memInfo.tel}
</div>
<div class="content2">
<p>내 예약</p>
            <!-- 한 개 영역 -->
                <c:choose>
    			<%-- 조회결과가 없는 경우 --%>
    			<c:when test="${output == null || fn:length(output) == 0}">
    				<div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px;">
    					<h2 align="center" style="width: 940px;">조회 결과가 없습니다.</h2>
    				</div>
    			</c:when>
                <%-- 조회결과가 있는 경우 --%>
                <c:otherwise>
                <%-- 조회결과에 따른 반복 처리 --%>
                	<c:forEach var="item" items="${output}" varStatus="status">
				        <%-- 출력을 위해 준비한 상품 이름 변수 --%>
				        <c:set var="name" value="${item.name}" />
                        
                        <%-- 상세페이지로 이동하기 위한 URL --%>
                        <c:url value="/my-reserve/reserve-1.do" var="viewUrl">
                            <c:param name="reserve_id" value="${item.reserveId}" />
                        </c:url>
                        
				        <div class="reserve">
                			<a href="${viewUrl}" class="thumbnail">
                    		<div class="state1${item.reserveId}" id="state1"><p class="state" id="statext${item.reserveId}">예약 완료</p></div>
                    		<div class="row">
                        	<div class="info">
                            <h3>${name}</h3>
                            <p class="text-left text-muted">
                                <small>일정| ${item.reDate}&nbsp;${item.reTime}</small>
                            </p>
                        </div>
                    </div>
                </a>
            </div>
					</c:forEach>
				</c:otherwise>				     
        </c:choose>
        <nav>
	    <ul class="pagination">
		    <%-- 이전 그룹에 대한 링크 --%>
		    <c:choose>
		        <%-- 이전 그룹으로 이동 가능하다면? --%>
		        <c:when test="${pageData.prevPage > 0}">
		            <%-- 이동할 URL 생성 --%>
		            <c:url value="/shop" var="prevPageUrl">
		                <c:param name="page" value="${pageData.prevPage}" />
		            </c:url>
		            <li><a href="${prevPageUrl}"><span>&laquo;</span></a></li>
		        </c:when>
		        <c:otherwise>
		            <li class="disabled"><span>&laquo;</span></li>
		        </c:otherwise>
		    </c:choose>
		    
		    <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
		    <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
		        <%-- 이동할 URL 생성 --%>
		        <c:url value="/mypage/my-reserve.do" var="pageUrl">
		            <c:param name="page" value="${i}" />
		        </c:url>
		        
		        <%-- 페이지 번호 출력 --%>
		        <c:choose>
		            <%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
		            <c:when test="${pageData.nowPage == i}">
		                <li class="active"><a href="${pageUrl}">${i}</a></li>
		            </c:when>
		            <%-- 나머지 페이지의 경우 링크 적용함 --%>
		            <c:otherwise>
		                <li><a href="${pageUrl}">${i}</a></li>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		    
		    <%-- 다음 그룹에 대한 링크 --%>
		    <c:choose>
		        <%-- 다음 그룹으로 이동 가능하다면? --%>
		        <c:when test="${pageData.nextPage > 0}">
		            <%-- 이동할 URL 생성 --%>
		            <c:url value="/shop" var="nextPageUrl">
		                <c:param name="page" value="${pageData.nextPage}" />
		            </c:url>
		            <li><a href="${nextPageUrl}"><span>&raquo;</span></a></li>
		        </c:when>
		        <c:otherwise>
		            <li class="disabled"><span>&raquo;</span></li>
		        </c:otherwise>
		    </c:choose>
	    </ul>
    </nav>
            </div>
            
</div>
<script type="text/javascript">
$(function () {
//현재 날짜 구하기
function getToday(){
       var date = new Date();
       var year = date.getFullYear();
       var month = ("0" + (1 + date.getMonth())).slice(-2);
       var day = ("0" + date.getDate()).slice(-2);
       return year  + month +  day;
   }
   var a = getToday();
var d = parseInt(a);

$.get("${pageContext.request.contextPath}/rest/reserve.do", function(req) {
// 날짜 지나면 
for (var i=0; i<req.re.length; i++) {
	req.re[i].reDate = parseInt(req.re[i].reDate.replace(/-/g,""));
	var element = document.getElementById("statext"+req.re[i].reserveId);
	if (d > req.re[i].reDate) {
	   $(".state1"+req.re[i].reserveId).css("background-color", "#c1c1c1");
	   $("#statext"+req.re[i].reserveId).css("font-size", "23px");
	   $("#statext"+req.re[i].reserveId).css("color", "#fff");
	   element.innerText = "이용 완료";
	}  
	   else {
	   $(".state1"+req.re[i].reserveId).css("background-color", "#2E9AFE");
	   $("#statext"+req.re[i].reserveId).css("font-size", "23px");
	   $("#statext"+req.re[i].reserveId).css("color", "#fff");
	}
}
}); 
}); 
</script>

<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>