<%/**
 *@FileName : reserve-2.jsp
 *@프로그램 설명  : 이용완료 상세 페이지
 *@작성자 : 정은지 (ejzzang56@gmail.com)
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- ========== 컨텐츠 영역 시작 ========== -->

<style>
 a {
        color: #222;
    }
.content1{padding-bottom:10px;}
.content2{width:300px; margin:5px; height: 200px;}
.content3{padding-top:30px;margin-left:180px;width: 300px;
	height: 300px;
	float:left;
}
.content4{padding-top:150px;margin-bottom:50px; margin-left:520px;}
.thumbnail{
	width:900px; height:auto ;
}
    a:hover {
        text-decoration: none;
        color: #222;
    }
    .res{width:880px; border-bottom:1px solid #eee;}
    .row{padding-top:20px; padding-top:3px;}
    .text1{margin-left:20px;}
    .text2{margin-left:20px;border-bottom:3px solid #eee;margin-right:25px;}
    .text3{margin-left:20px;padding-bottom:5px;}
    .text4{margin-left:20px;padding-bottom:10px;}
    .ss{background-color: #c1c1c1; height:35px;padding-bottom:20px;width:880px;}
    .ss>h4{ margin:0;color: #fff;font-size: 23px;}
    #map{width: 300px;
	height: 300px;}
	.cancel{margin-left:200px;}
}
    
</style>

<div class="container thumbnail">
	<div class="content1">
	예약자 정보<br />
	<h4>${memInfo.userName} 님</h4>
	<h4>${memInfo.tel}</h4>
	</div>
	<div class="content2">
		<div class="res">
		                    <div class="ss">
		                    <h4>이용 완료</h4>
		                    </div>
			                    <div class="row">
			                        <div class="text1">
			                        	<small>No.11</small></div>
			                        	 <div class="text2">
			                            <h3>은지네 병원</h3></div>
			                             <div class="text3">
			                            <p class="text-left text-muted">
			                                	일정| 2020.07.27.(월)
			                            </p></div>
			                            <div class="text4">
			                            <h3>오시는길</h3></div>
			                    </div>
			             </a>       
		</div>
	</div>
	<div class="content3">
    <div id="map">
    </div>

    <script>
			function initMap() {
	
				var uluru = {
					lat : 37.502582,
					lng : 127.024856
				};
	
				var map = new google.maps.Map(
	
				document.getElementById('map'), {
					zoom : 17,
					center : uluru
				});
	
				var marker = new google.maps.Marker({
					position : uluru,
					map : map
				});
	
			}
		</script>


    <script async defer

    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBqB7Pvxiv5c4SNjYwiMJ3U8_uW2YIkG-M&callback=initMap&region=kr">

    </script>
</div>
	<div class="content4">
	
	    <address>
	        <strong>은지네 병원</strong><br />
	        주소 : 서울시 어쩌구 <br>
	        운영시간 : 09:00 ~ 18:00 <br>
	        <abbr title="Phone">전화번호 : </abbr> (010) 1234-5678
	    </address>
	<span class="cancel">
	    <button type="button" class="btn btn-default "><a href="<%=request.getContextPath()%>/reserve-2/write-review.do">리뷰 쓰기</a></button>
	</span>
	</div>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>