
<%
	/**
* @filename    : chart-bar.jsp
* @description : --- include 파일 ---

	가로 막대 그래프

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<script src="assets/js/chart.min.js"></script>
<script src="assets/js/utils.js"></script>
<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container">
	<canvas id="bar-chart"></canvas>
</div>
<script>	
	$(function() {
		
		// ajax 통신 결과 (json data)
		var jdata;
		
		// 지역 이름 배열
		var region = [];
		
		// 누적확진자수 배열
		var nh_data = [];
		
		// 누적격리해제수 배열
		var nk_data = [];
		
		$.ajax({
			type: "post",
			url : "/wtm/rest/covid/region",
			dataType : "json",
			async:false,
			success : function(data) { jdata = data.item; }
		});	// end $.ajax
		
		for (var i = 0; i < jdata.length; i++) {
			region[i] = jdata[i]['지역'];
			nh_data[i] = jdata[i]['누적확진자'];
			nk_data[i] = jdata[i]['누적격리해제'];
		}
				
		var color = Chart.helpers.color;
		var horizontalBarChartData = {
			labels : region,
			datasets : [
					{
						label : '누적확진자수',
						backgroundColor : color(window.chartColors.purple).alpha(0.5).rgbString(),
						data : nh_data,
					},
					{
						label : '누적격리해제수',
						backgroundColor : color(window.chartColors.grey).alpha(0.9).rgbString(),
						data : nk_data,
					} ]
		};
		var ctx = document.getElementById('bar-chart').getContext('2d');
		window.myHorizontalBar = new Chart(ctx, {
			type : 'horizontalBar',
			data : horizontalBarChartData,
			options : {
				elements : {
					rectangle : {
						borderWidth : 2,
					}
				},
				responsive : true,
				legend : {
					position : 'bottom',
				},
				title : {
					display : true,
					text : '시도별 발생 동향'
				},
				gridLines: {
					display: true,
					drawBorder: true,
					drawOnChartArea: false,
				}
			}
		});
	});	// ens fun

</script>
<!--// ========== 컨텐츠 영역 끝 ========== -->
