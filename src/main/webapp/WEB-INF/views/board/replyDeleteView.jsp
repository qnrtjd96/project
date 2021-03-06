<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
		 <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 
	 	<title>블로그</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			/* 취소버튼을 눌렀을때에 (페이징을 유지할 수 있게) 이동할수 있는 하이퍼 링크를 달아준다. */
			$(".cancel_btn").on("click", function(){
				location.href = "/board/readView?bno=${replyDelete.bno}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
			
		})
		
	</script>
	<body>
		<section id="container">
			<div class="container">
				<div id="root">
					<header>
						<h1 style="font-size: -webkit-xxx-large;">project</h1>
					</header>
					<hr />
					 
					<div>
						<%@include file="nav.jsp" %>
					</div>
					<section id="container">
						<form name="updateForm" role="form" method="post" action="/board/replyDelete">
							<input type="hidden" name="bno" value="${replyDelete.bno}" readonly="readonly"/>
							<input type="hidden" id="rno" name="rno" value="${replyDelete.rno}" />
							<input type="hidden" id="page" name="page" value="${scri.page}"> 
							<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
							<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
							<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
								
							<div>
								<p style="font-size: 25px; text-align: center;">삭제 하시겠습니까?</p>
								<div style="text-align: center;">
								<button type="submit" class="delete_btn" style="font-size: 15px;">예 삭제합니다.</button>
								<button type="button" class="cancel_btn" style="font-size: 15px;">아니오. 삭제하지 않습니다.</button>
								</div>
							</div>
						</form>
					</section>
					
				</div>
			</div>
		</section>
	</body>
</html>