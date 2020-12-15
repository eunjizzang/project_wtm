
<%
	/**
* @filename    : chart-pie.jsp
* @description : --- include 파일 ---

	파이(도넛형) 그래프

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<script src="assets/js/chart.min.js"></script>
<script src="assets/js/utils.js"></script>
<style>
.chart-container {
	width: 470px;
}

.piecontainer {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: center;
}
</style>
<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="piecontainer">
	<div class="chart-container">
		<canvas id="pie-chart"></canvas>
	</div>
	<div class="chart-container">
		<canvas id="pie-chart2"></canvas>
	</div>
</div>
<script>
	var config = {
		type : 'doughnut',
		data : {
			datasets : [ {
				data : [ 40, 60 ],
				backgroundColor : [  window.chartColors.yellow,
						window.chartColors.green ],
				label : 'Dataset 1'
			} ],
			labels : [ '여자', '남자' ]
		},
		options : {
			responsive : true,
			legend : {
				position : 'right',
			},
			title : {
/* 				display : true,
				text : 'Chart.js Doughnut Chart' */
			},
			animation : {
				animateScale : true,
				animateRotate : true
			}
		}
	};

	var ctx = document.getElementById('pie-chart').getContext('2d');
	window.myDoughnut = new Chart(ctx, config);
	var ctx = document.getElementById('pie-chart2').getContext('2d');
	window.myDoughnut = new Chart(ctx, config);
</script>
<!--// ========== 컨텐츠 영역 끝 ========== -->
