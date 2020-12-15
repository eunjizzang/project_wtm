<%
/**
* @filename    : chart-lind.jsp
* @description : --- include 파일 ---

				선 그래프

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<script src="assets/js/chart.min.js"></script>
<script src="assets/js/utils.js"></script>

<style>
/** 그래프 */
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container">
	<canvas id="line1"></canvas>
	<br> <br>
	<canvas id="line2"></canvas>
	<br> <br>
</div>

<script>
$(function() {
	
	// ajax 통신 결과 (json data)
	var jdata;
	
	// 날짜 배열
	var data = [];
	
	// 누적확진자수 배열
	var nh_data = [];
	
	// 일일확진자수 배열
	var dh_data = [];
	
	// 누적격리해제수 배열
	var nk_data = [];
	
	// 일일확진자수 배열
	var dk_data = [];
	
	// 누적사망자수 배열
	var die = [];
	
	// 일일사망자수 배열
	var d_die = [];
	
	$.ajax({
		type: "post",
		url : "/wtm/rest/covid/confirm",
		dataType : "json",
		async:false,
		success : function(data) { jdata = data.item; }
	});	// end $.ajax
	
	for (var i = 0; i < jdata.length; i++) {
		data[i] = jdata[i]['날짜'].substring(5,10).replace("-", "/");		// 날짜
		nh_data[i] = jdata[i]['누적확진자'];								// 누적확진
		dh_data[i] = jdata[i]['확진자'];									// 일일확진
		nk_data[i] = jdata[i]['누적격리해제'];								// 누적격리해제
		dk_data[i] = jdata[i]['격리해제'];									// 일일격리해제
		die[i] = jdata[i]['누적사망자'];									// 누적사망자		
		d_die[i] = jdata[i]['사망자'];										// 누적사망자		
	}

	var chartData = {
			labels : data,
			datasets : [
					{
						type : 'bar',
						label : '확진환자수',
						backgroundColor : window.chartColors.yellow,
						data : nh_data
					},
					{
						type : 'bar',
						label : '격리해제수',
						backgroundColor : window.chartColors.blue,
						data : nk_data
					},
					{
						type : 'bar',
						label : '사망자수',
						backgroundColor : window.chartColors.red,
						data : die
					}]

		};
	var ctx = document.getElementById('line1').getContext('2d');
	window.myMixedChart = new Chart(ctx, {
		type : 'bar',
		data : chartData,
		options : {
			responsive : true,
			title : {
				display : true,
				text : '코로나 현황 누계'
			},
			legend : {
				position : 'right',
			},
			tooltips : {
				mode : 'index',
				intersect : true
			}
		}
	});
	
	var chartData = {
		labels : data,
		datasets : [
				{
					type : 'line',
					label : '확진환자수',
					borderColor : window.chartColors.yellow,
					borderWidth : 3,
					fill : false,
					data : dh_data
				},
				{
					type : 'line',
					label : '격리해제수',
					borderColor : window.chartColors.blue,
					borderWidth : 3,
					fill : false,
					data : dk_data
				},
				{
					type : 'line',
					label : '사망자수',
					borderColor : window.chartColors.red,
					borderWidth : 3,
					fill : false,
					data : d_die
				}]

	};
	var ctx = document.getElementById('line2').getContext('2d');
	window.myMixedChart = new Chart(ctx, {
		type : 'bar',
		data : chartData,
		options : {
			responsive : true,
			title : {
				display : true,
				text : '일일 코로나 현황'
			},
			legend : {
				position : 'right',
			},
			tooltips : {
				mode : 'index',
				intersect : true
			}
		}
	});
});	// ens fun
</script>
	<!--// ========== 컨텐츠 영역 끝 ========== -->