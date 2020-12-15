<%/**
 *@FileName : reserve-1.jsp
 *@프로그램 설명  : 예약완료 상세 페이지
 *@작성자 : 정은지  (ejzzang56@gmail.com)
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- ========== 컨텐츠 영역 시작 ========== -->
<style>
.thumbnail{
	width:900px; height:auto; padding-bottom:40px;
}
a {
    color: #222;
}
a:hover {
    text-decoration: none;
    color: #222;
}
.content1{
	padding-bottom:10px;
}
.content2{
	width:300px; 
	margin:5px; 
	height: 200px;
}
.content3{
	padding-top:30px;
	margin-left:180px;
	width: 300px;
	height: 300px;
	float:left;
}
.content4{
	padding-top:150px;
	margin-bottom:50px; 
	margin-left:520px;
}
.res{
	width:880px; 
	border-bottom:1px solid #eee;
}
.row{
	padding-top:20px; 
	padding-top:3px;
}
.text1{
	margin-left:20px;
}
.text2{
	margin-left:20px;
	border-bottom:3px solid #eee;
	margin-right:25px;
}
.text2 > h3 {margin: 0px 0px 10px;}
.text3{
	margin-left:20px;
	padding-bottom:5px;
}
.text4{
	margin-left:20px;
	padding-bottom:10px;
}
.state1{
	height:35px;
	padding-bottom:20px;
	width:880px;
}

#gmap{
	width: 300px;
	height: 300px;
}
.cancel{
	margin-left:200px;
}
</style>

<div class="container thumbnail">
<input type="hidden" id="reserveId" name="reserveId" value="${output.reserveId}" />
<input type="hidden" id ="lat" name="lat" value="${output.lat}" />
<input type="hidden" id ="lon" name="lon" value="${output.lon}" />
<input type="hidden" id ="name" name="name" value="${output.name}" />
	<div class="content1">
	예약자 정보<br />
	<h4>${memInfo.userName} 님</h4>
	<h4>${memInfo.tel}</h4>
	</div>
	<div class="content2">
		<div class="res">
		                    <div class="state1${output.reserveId}">
		                    <p class="statext" id="statext${output.reserveId}">예약 완료</p>
		                    </div>
			                    <div class="row">
			                        <div class="text1">
			                        	<small>${output.reserveId}</small></div>
			                        	 <div class="text2">
			                            <h3>${output.name}</h3></div>
			                             <div class="text3">
			                            <p class="text-left text-muted">
			                                	일정| ${output.reDate}&nbsp;${output.reTime} 
			                            </p></div>
			                            <div class="text4">
			                            <h3>오시는길</h3></div>
			                    </div>
			             </a>       
		</div>
	</div>
	<div class="content3">
    <div id="gmap">
    </div>

<!--Google CDN 서버로부터 jQuery 참조 -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1c7EPGRgB5QSw9rGZwmWyBxqemQDX8wM&region=kr">
</script>
<script src="<%=request.getContextPath()%>/assets/plugins/gmaps/gmaps.min.js"></script>
<script>
$(document).ready(function() {
	var map = new GMaps({
		el: '#gmap',					//지도를 표시할 div의 id값
		lat: $("#lat").val(),		//지도가 표시될 위도
		lng: $("#lon").val(),		//지도가 표시될 경도
		zoom: 17
	});
	
	map.addMarker({
		title: $("#name").val(),
		lat: $("#lat").val(),
		lng: $("#lon").val(),
		icon:{
			url:"${pageContext.request.contextPath}/assets/img/marker.png",
			scaledSize: new google.maps.Size(30, 30)
		}
	});
});
</script>


</div>
	<div class="content4">
	
	    <address>
	        <strong>${output.name}</strong><br />
	        주소 : ${output.addr}<br>
	        <abbr title="Phone">전화번호 : </abbr> ${output.phone}
	    </address>


 <form name="join_form" id="join_form"> 
	<span class="cancel">
	    <button type="submit" class="btn btn-default btn-cancel" id="review">취소</button>
	</span>
</form>	
	
	<script>
	
	
	
	$(function() {
		
		// jQuery Ajax가 restful을 처리할 수 있도록 기능 확장.
		// ajax-helerp.js에 추가했지만 인식이 안돼서 여기에 넣음.
		jQuery.each([ "put", "delete" ], function(i, method) {
		    jQuery[method] = function(url, data, callback, type) {
		        if (jQuery.isFunction(data)) {
		            type = type || callback;
		            callback = data;
		            data = undefined;
		        }

		        return jQuery.ajax({
		            url : url,
		            type : method,
		            dataType : type,
		            data : data,
		            success : callback
		        });
		    }
		});
		
		$(".btn-cancel").click(function(e) {
			e.preventDefault();
			
				swal({
					title: "취소하시겠습니까?",
					type: "warning",
					confirmButtonText: "예",
					cancelButtonText : "아니오",
					showCancelButton: true
				}).then(function(result) {
					
					
					if (result.value) {
						$.delete("${pageContext.request.contextPath}/reserve/cancel.do", {
							"id" : $("#reserveId").val()
						})
						swal({
							title: "예약이 취소되었습니다",
							type: "success",
							confirmButtonText: "확인",
						})
						window.location.href = "${pageContext.request.contextPath}/mypage/my-reserve.do";
					}
					
					else {}
				});
		});
		
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
			   $("#statext"+req.re[i].reserveId).css("margin-left", "5px");
			}  
			   else {
			   $(".state1"+req.re[i].reserveId).css("background-color", "#2E9AFE");
			   $("#statext"+req.re[i].reserveId).css("font-size", "23px");
			   $("#statext"+req.re[i].reserveId).css("color", "#fff");
			   $("#statext"+req.re[i].reserveId).css("margin-left", "5px");
			}
		}
		}); 
	});
	</script>	
	</div>
</div>



<!--// ========== 컨텐츠 영역 끝 ========== -->

<%@ include file="../_inc/footer.jsp"%>