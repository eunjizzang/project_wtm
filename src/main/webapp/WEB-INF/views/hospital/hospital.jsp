<%
	/**
* @filename : hospital.jsp
* @description : --- 병원 리스트 및 검색 페이지 ---
		1) .search_contents (제목~검색 영역)
		2) .map_contents (지도 영역)
		3) .list_contents (병원리스트 영역)
			-각 병원 블록: .list_item
				-병원 이름 블록: .list_title
				-병원 주소,번호,시간 블록: .content
* @author : 이상희(46wendy@naver.com)
*/
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>

<!-- 병원찾기 & 약국찾기 공통 css 참조 -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/css/map.css">

<style type="text/css">

/**  약국 & 병원 이미지와 h1 높이 맞추기 **/
.hospital_img {
	padding-bottom: 15px;
}

/** 검색 블록과 map 사이에 여백 주기 **/
.search_contents {
	padding-bottom: 10px;
}

/** 검색 블록 왼쪽에 여백주기 **/
.myform {
	margin-left: 25px;
	width: 570px;
	height: 37px;
	display: inline-flex;
}

/** 드롭다운 나란히 & 높이 & 테두리**/
.dropdown {
	float: left;
	height: 34px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

/** 드롭다운별 넓이 **/
.drop_subj {
	width: 130px;
}

.drop_city {
	width: 130px;
}

.drop_gu {
	width: 100px;
}

/** 검색 텍스트창 넓이 **/
.input-group {
	width: 200px;
}

/** 예약버튼 색, 넓이와 높이 **/
.btn-reserve {
	background-color: #2E9AFE;
	width: 176px;
	height: 32px;
    padding-top: 5px;
    margin-top: 15px;
    border: 0px;
}

/** 예약버튼 링크를 블럭과 크기 맞추기 **/
.btn-reserve a {
	text-decoration: none;
	padding: 0px;
	display: block;
	width: 150px;
	height: 30px;
	margin-left: -12px;
	margin-top: -7px;
	padding-top: 5px;
}

/** 밑줄 없애기 **/
a:hover {
	text-decoration: none;
}

/** assets 폴더 안에 포함말기! **/
/** 병원리스트에서 내용 영역 기본 숨김처리 **/
.content {
	display: none;
}
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container" style="width: 1100px;">
	<input type="hidden" id="userId" name="userId" value="${memInfo.userId}" />
	<input type="hidden" id="hospitalId" name="hospitalId" value="${item.hospitalId}" />
	<input type="hidden" id="hospitalName" name="hospitalName" value="${item.name}" />
	<!-- dropdown -->
	<div class="search_contents">
		<div class="page-header">
			<h1>
				<img src="assets/img/hospital.png" class="hospital_img"
					style="width: 50px">동네 병원을 찾아보세요
			</h1>
		</div>
		<form class="myform" id="myform" method="get" action="${pageContext.request.contextPath}/rest/hospital.do">
			<div class="form-group">	
				<!-- 진료과목 dropdown -->
				<select id="drop_subj" name="sub" class="dropdown drop_subj">
					<option value="">&nbsp; &nbsp; &nbsp; 진료과목</option>
					<option class="sub" value="가정의학과">&nbsp; 가정의학과</option>
					<option class="sub" value="정신건강의학과">&nbsp; 정신건강의학과</option>
					<option class="sub" value="정형외과">&nbsp; 정형외과</option>
					<option class="sub" value="신경외과">&nbsp; 신경외과</option>
					<option class="sub" value="성형외과">&nbsp; 성형외과</option>
					<option class="sub" value="내과">&nbsp; 내과</option>
					<option class="sub" value="마취통증의학과">&nbsp; 마취통증의학과</option>
					<option class="sub" value="산부인과">&nbsp; 산부인과</option>
					<option class="sub" value="소아청소년과">&nbsp; 소아청소년과</option>
					<option class="sub" value="안과">&nbsp; 안과</option>
					<option class="sub" value="이비인후과">&nbsp; 이비인후과</option>
					<option class="sub" value="피부과">&nbsp; 피부과</option>
					<option class="sub" value="비뇨의학과">&nbsp; 비뇨의학과</option>
					<option class="sub" value="재활의학과">&nbsp; 재활의학과</option>
					<option class="sub" value="치과">&nbsp; 치과</option>
					<option class="sub" value="한방내과">&nbsp; 한의학과</option>
				</select>
				<!-- drop_city -->
				<!-- 시/도 dropdown -->
				<select id="drop_city" name="si" class="dropdown drop_city">
					<option value="">  &nbsp; &nbsp; &nbsp; &nbsp; 시/도 </option>
					<option class="si" value="서울특별시">&nbsp; 서울특별시</option>
					<option class="si" value="부산광역시">&nbsp; 부산광역시</option>
					<option class="si" value="인천광역시">&nbsp; 인천광역시</option>
					<option class="si" value="대구광역시">&nbsp; 대구광역시</option>
					<option class="si" value="광주광역시">&nbsp; 광주광역시</option>
					<option class="si" value="대전광역시">&nbsp; 대전광역시</option>
					<option class="si" value="울산광역시">&nbsp; 울산광역시</option>
					<option class="si" value="세종특별자치시">&nbsp; 세종특별자치시</option>
					<option class="si" value="경기도">&nbsp; 경기도</option>
					<option class="si" value="강원도">&nbsp; 강원도</option>
					<option class="si" value="충청북도">&nbsp; 충청북도</option>
					<option class="si" value="충청남도">&nbsp; 충청남도</option>
					<option class="si" value="경상북도">&nbsp; 경상북도</option>
					<option class="si" value="경상남도">&nbsp; 경상남도</option>
					<option class="si" value="전라북도">&nbsp; 전라북도</option>
					<option class="si" value="전라남도">&nbsp; 전라남도</option>
					<option class="si" value="제주특별자치도">&nbsp; 제주특별자치도</option>
				</select>
				<!-- drop_city -->
				<!-- 구 dropdown -->
				<select id="drop_gu" name="gu" class="dropdown drop_gu">
					<option value="">  &nbsp; &nbsp; &nbsp;  시/구 </option>
				</select>
				<!-- drop_gu -->
			</div>
			<!-- form-group -->
			<div class="input-group">
				<input type="text" id="dong" class="form-control"
					placeholder="동을 입력하세요"> <span class="input-group-btn">
					<button type="submit" class="btn btn-success">
						<span class="fas fa-search"></span>
					</button>
				</span>
			</div>
			<!--  input-group -->
		</form>
		<span id="result"></span>
		<c:choose>
			<%-- 조회결과가 없는 경우 --%>
    		<c:when test="${si == null || fn:length(si) == 0}">
				<span></span>
			</c:when>
			<%-- 조회결과가 있는 경우 --%>
            <c:otherwise>
	        	<%-- 조회결과에 따른 반복 처리 --%>
	            <span id="result">${si} ${gu} ${dong}의 검색 결과입니다.(${count}건)</span>
	    	</c:otherwise>
		</c:choose>
	</div>	<!-- search_contents -->

	<!-- 지도 -->
	<div class="map_contents" id="map_contents">
		<div id="gmap" style="width: 770px; height: 770px;">
			<!-- map -->
		</div>
	</div>
	<!-- map_conents -->

	<!-- 병원 리스트 블록 -->
	<div class="list_contents">
		<c:choose>

			<%-- 조회결과가 없는 경우 --%>
    		<c:when test="${output == null || fn:length(output) == 0}">
    			<div class="list_item" style="background-color: #fff; border: 0;">
   				</div>
			</c:when>

			<%-- 조회결과가 있는 경우 --%>
			<c:otherwise>
				<%-- 조회결과에 따른 반복 처리 --%>
				<c:forEach var="item" items="${output}" varStatus="status">
				
					<%-- 상세페이지로 이동하기 위한 URL --%>
                    <c:url value="/hospital/reserve.do" var="viewUrl">
                    	<c:param name="id" value="${item.hospitalId}" />
                    </c:url>
                        
					<!-- 각 병원 블록 -->
					<div class="list_item">
						<!-- 병원 이름 블록 -->
						<h4 class="list_title">
							<a href="#content${item.hospitalId}" class="list_link">
								<span>${item.name}</span>
							</a>
						</h4>
						<!-- 병원 상세정보 블록 -->
						<div id="content${item.hospitalId}" class="content">
							<br />
							<span id="list_address">
								주소: ${item.addr}
							</span>
							
							<br />
							
							<a href="tel:${item.phone}">전화번호: ${item.phone}</a>
							
							<a href="${item.site}">사이트: ${item.site}</a>
							
							<hr />
							
							<strong class="hour${item.hospitalId}"></strong> 
							
							<hr />
							
							<span id ="list_time"> 
								[오늘] 시작: ${item.monOpen} - 종료: ${item.monClose}
							</span>

							<div class="text-center">
								<a href="${viewUrl}"  class="btn btn-reserve btn-primary">
					            	예약
					            </a>
					        </div>
								
						</div> <!-- .content-->
					</div> <!-- list_item -->
					
				</c:forEach>
			</c:otherwise>
			
		</c:choose>
	</div> <!-- list_contents -->
</div> <!-- container -->

<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- Ajax로 읽어온 내용을 출력하는데 사용될 HTML 템플릿 -->
<script id="map-list-tmpl" type="text/x-hendlebars-template">
	{{#each item}}
    	<div class="list_item">
        	<h4 class="list_title list_title{{hospitalId}}">
           		<a href="#content{{hospitalId}}" value="{{name}}" class="list_link">
              		<span data-value="{{hospitalId}}">{{name}}</span>
	            </a>
        	</h4>
        	<div id="content{{hospitalId}}" class="content">
            	<br />
            	<span id="list_address">
                	주소: {{addr}}
            	</span>
            	<br />
            	<a href="tel:{{phone}}">전화번호: {{phone}}</a>
                <a href="{{site}}"> 사이트: {{site}} </a>            		
            	<hr />
            	<strong id="hour{{hospitalId}}">OPEN</strong>
            	<hr />
            	<span class="list_time">
            		[오늘] 시작: {{openTime}} - 종료: {{closeTime}}
        		</span>
            	<div class="text-center">
					<a href="${pageContext.request.contextPath}/hospital/reserve.do?hospital_id={{hospitalId}}" class="btn btn-reserve btn-primary">
               			예약
					</a>
            	</div>
        	</div> 
    	</div>		
	{{/each}}
	<intput type="hidden" id="count" value="{{count}}" />
</script>

<!-- 주소 JSON 목록 -->
<script src="<%=request.getContextPath()%>/assets/js/region.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD1c7EPGRgB5QSw9rGZwmWyBxqemQDX8wM&region=kr">
</script>
<script src="<%=request.getContextPath()%>/assets/plugins/gmaps/gmaps.min.js"></script>
<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">
	$(function () {
		var map = new GMaps({
			el: '#gmap',		//지도를 표시할 div의 id값
			lat: 37,				//지도가 표시될 위도
			lng: 127,			//지도가 표시될 경도
			zoom: 9
		});
		/** dropdown 입력값 검사 */
		$(document).on("click", ".btn-success", function(e) {
			e.preventDefault();

			var subj = $("#drop_subj").val();
			if (!subj) {
				swal({
					title : "진료과목을 선택하세요", 		// 제목
					html : "", 									// 내용
					type : "error", 							// 종류
					confirmButton : true, 				// 확인버튼 표시여부
					confirmButtonText : "확인", 		// 확인버튼표시문구		
				});
				return;
			} 

			var city = $("#drop_city").val();
			if (!city) {
				swal({
					title : "도시를 선택하세요", 			// 제목
					html : "", 								// 내용
					type : "error", 						// 종류
					confirmButton : true, 			// 확인버튼 표시여부
					confirmButtonText : "확인", // 확인버튼표시문구		
				});
				return;
			}	else {
			
				var sub = $("#drop_subj option:selected").val();
				var si = $("#drop_city option:selected").val();
				var gu = $("#drop_gu option:selected").val();
				var dong = $("#dong").val();
					
				$.get("${pageContext.request.contextPath}/rest/hospital.do", 
					{"sub": sub, "si": si, "gu": gu, "dong": dong}, function(req) {
					console.log(sub + si + gu + dong);
					
					$(".list_item").empty();
					
					// 검색 건수가 0이라면
					if (req.count == 0) {
						$("#result").html(si + " " + gu + " " + dong + "의 " + sub + " 검색 결과가 존재하지 않습니다." );
					}	else {
						
						var map = new GMaps({
							el: '#gmap',					//지도를 표시할 div의 id값
							lat: req.item[0].lat,		//지도가 표시될 위도
							lng: req.item[0].lon,		//지도가 표시될 경도
							zoom: 15
						}); 
						
						// 조회 건수
						var count = req.count;
	
						$("#result").html(si + " " + gu + " " + dong + "의 " + sub + " 검색 결과입니다." + "(" + count + "건)" );
						
						// 연속으로 검색할 시, 새로 고침 효과
						$(".list_item").empty();
						
						console.log(req);
						
						var source = $("#map-list-tmpl").html();
						var template = Handlebars.compile(source);
						var result = template(req);
						
						$(".list_item").append(result);
						
						for (var i=0; i<req.item.length; i++) {
		                    if(req.item[i].lat == null) {
		                       continue;
		                    } 
		                    
		                 	// 지도 마커 클릭시 입력될 텍스트
							var desc = "<h3>";				
							desc += req.item[i].name;
							desc += "</h3><br/>";
							desc += req.item[i].addr;
							
		                    //console.log(desc);
								
							// 현재 시간 구하기
							var d = new Date();
							var t = d.getHours() * 100;
							t += d.getMinutes();
								
							// 현재시간 기준 영업시간 아닐 경우, CLOSE + 배경색 회색 + 구글맵 마커 회색
							if (t > req.item[i].closeTime || req.item[i].openTime > t) {
								$("#hour" + req.item[i].hospitalId).html("CLOSE");
								$(".list_title" + req.item[i].hospitalId).css("background-color", "#d5d5d5");
								map.addMarker({
									title: req.item[i].hospitalId + "." + req.item[i].name,
									lat: req.item[i].lat,
									lng: req.item[i].lon,
									icon:{
										url:"${pageContext.request.contextPath}/assets/img/marker2.png",
										scaledSize: new google.maps.Size(50, 50)
									},
											
									infoWindow:{
										content: desc
									}
								})
							}	// 현재시간 기준 영업시간인 경우, OPEN + 배경색 그대로 하늘색 + 구글맵 마커 빨간색
								else if (t < req.item[i].closeTime && req.item[i].openTime < t) {
								$("#hour" + req.item[i].hospitalId).html("OPEN");
								$(".list_title" + req.item[i].hospitalId).css("background-color", "#cde8fa");
								map.addMarker({
									title: req.item[i].hospitalId + "." + req.item[i].name,
									lat: req.item[i].lat,
									lng: req.item[i].lon,
									icon:{
										url:"${pageContext.request.contextPath}/assets/img/marker.png",
										scaledSize: new google.maps.Size(50, 50)
									},
										
									infoWindow:{
										content: desc
									}
								})
							}	else {
								// NULL값 인 경우, HOLIDAY + 배경색 회색 + 구글맵 마커 회색
								$("#hour" + req.item[i].hospitalId).html("HOLIDAY");
								$(".list_title" + req.item[i].hospitalId).css("background-color", "#d5d5d5");
								map.addMarker({
									title: req.item[i].hospitalId + "." + req.item[i].name,
									lat: req.item[i].lat,
									lng: req.item[i].lon,
									icon:{
										url:"${pageContext.request.contextPath}/assets/img/marker2.png",
										scaledSize: new google.maps.Size(50, 50)
									},
										
									infoWindow:{
										content: desc
									}
								})
							} 
						}
					} 
				});
			}
		});
	});
	
	/** 게시글의 제목을 클릭한 경우 호출되는 이벤트 정의 */
	$(document).on("click", ".list_title a", function(e) {
		// 링크의 기본동작(페이지 이동) 방지
		e.preventDefault();

		// 클릭한 요소의 href 속성을 가져온다. --> 내용영역의 id
		var target = $(this).attr("href");
       	// 가져온 내용영역의 id를 화면에 표시한다.
        $(target).slideToggle(100);
        // 내용영역(.content) 증에서 클릭한 요소가 지정된 항목만 제외(not($(target))하고 화면에서 숨김.
        
        // 구글맵 마커에 title속성은 "id.name"으로 저장되어 있으므로 id와 name 속성을 가져온다.
        var id = $(this).find("span").attr("data-value");
        var name = $(this).find("span").html();
		
        // 구글 맵에서 해당하는 약국이 클릭이 된다.
        $("#gmap").find("div[title='"+ id + "." + name +"']").click();
        $(".content").not($(target)).slideUp(100);
    });
        
	/** 구글맵 마커 클릭한 경우 호출되는 이벤트 정의 */
    $(document).on("click","#gmap > div > div > div > div > div > div > div",function(e) {
    	// 링크의 기본동작(페이지 이동) 방지
		e.preventDefault();
    	
    	// 구글맵 마커에 저장해 놓은 title 속성 가져옴
		var title= $(this).attr("title");
		
    	// title은 id.name으로 저장되어 있으므로 "." 앞까지의 id 값을 가져온다.
		var dot = title.indexOf(".");
		var id = title.substring(0, dot);
		
		// 마커 클릭시 해당하는 약국 블록이 열림
		$("#content" +id).slideDown(100);
		// 해당 블록을 제외하고 숨긴다. 
		$(".content").not($("#content" + id)).slideUp(100);
	}); 
	
$(function() {
		$(document).on("click", ".btn-reserve", function(e) {
			
			e.preventDefault();
			
			const current = $(this);
			const url = current.attr('href');
					
			console.log($("#userId").val());
					
			if ($("#userId").val() == null || $("#userId").val() =="") {
				swal({
					title: "로그인후 이용하실 수 있는 <br /> 서비스입니다.",
				    text: "",
				     type: "error",
				     confirmButtonText: "확인",
				     showCancelButton: true,
				     cancelButtonText: "취소",
				}).then(function(result) {
					if (result.value) {
						window.location.href = "${pageContext.request.contextPath}/login.do";
					}
				})	
			} else {
				swal({
				title: "확인",
				text: "예약하시겠습니까?",
				type: "question",
				confirmButtonText: "확인",
				showCancelButton: true,
				cancelButtonText: "취소"
			}).then(function(result) {
						if (result.value) {
							window.location.href = url;
					}
				});
			}    	
		});
	});         
        
</script>
<script src="assets/js/regex.js"></script>

<%@ include file="../_inc/footer.jsp"%>