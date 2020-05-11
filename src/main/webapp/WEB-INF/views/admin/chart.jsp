<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>관리자 통계페이지</title>
	
	<!-- 라이브러리 load -->
	<!-- 라이버러리 참조 -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
	<div class="container">
		<header>
			<h1 style= "font-size: 50;">블로그-관리자</h1>
		</header>
		<div>
			<%@include file="nav.jsp" %>
		</div>
		<div id="piechart_3d" style="width: 900px; height: 500px;"></div>
		
		<form name="admin" method="get">
			<input type="text" id="board" value="${boardcount}"/>
			<input type="text" id="reply" value="50"/>
			<input type="text" id="member" value="40"/>
		</form>
		
	</div>
	<script type="text/javascript">
	
	$(document).ready(function(){
		var formObj = $("form[name='admin']");
	      //최신차트 세팅
	      google.charts.load("current", {packages:["corechart"]});
	      //최신차트 로드
	      google.charts.setOnLoadCallback(drawChart);
	     /*  30초마다 재갱신
		  google.charts.setOnLoadCallback(function(){
		  setInterval(columnChart1(),30000);
		  } */
		  
	      /* 데이터 세팅하는 곳 */
	      function drawChart() {
			  /* 게시글 총 개수  */
			  var test = $("#board").val();
			  var board = parseInt(test);
			  
			  /* 댓글 총 개수 */
			  var test2 = $("#reply").val();
			  var reply = parseInt(test2);
			  
			  /* 회원수 총 개수 */
			  var test3 = $("#member").val();
			  var member = parseInt(test3)
			  
	          var data = google.visualization.arrayToDataTable([
		          ['Task', 'Hours per Day'],
		          ['게시글',     $('#board').val()],
		          ['댓글',      reply],
		          ['회원수',     member],
	          ]);
			
	        /* 옵션 세팅 */
	        var options = {
	          title: '총 개수는 누가 많을까?',
	          is3D: true,
	        };
			
	        /* 차트 그리기  div객체에 맵핑시킴(piechart_3d) */
	        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
	        chart.draw(data, options);
	      };
	});
    </script>
</body>
</html>

