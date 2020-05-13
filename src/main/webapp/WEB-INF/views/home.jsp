<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
	<title>Home</title>
	<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
</head>
	<script type="text/javascript">
			$(document).ready(function(){
				$("#logoutBtn").on("click", function(){
					location.href="member/logout";
				})
				$("#registerBtn").on("click", function(){
					location.href="member/register";
				})
				
				$("#memberUpdateBtn").on("click", function(){
					location.href="member/memberUpdateView";
				})
				
				$("#memberdeleteBtn").on("click", function(){
					location.href="member/memberDeleteView";
				})
			})
	</script>
<body>
	<section id="container">
		<div class="container">
			<header>
				<h1 style="font-size: -webkit-xxx-large;">project</h1>
			</header>
			<hr />
			
	    	<div>
				<%@include file="board/nav.jsp" %>
	 		</div>
			<form name='homeForm' method="post" action="/member/login">
			  <div style="margin-top: 50;" class="form-group">
				<c:if test="${member == null}">
					<div style="margin-top: 30;">
						<label for="userId" style="font-size: 18px;">아이디</label>
						<input type="text" id="userId" name="userId" class="form-control" style="height: calc(2.25rem + 10px);" />
					</div>
					<div style="margin-top: 10;">
						<label for="userPass" style="font-size: 18px;">패스워드</label>
						<input type="password" id="userPass" name="userPass" class="form-control" style="height: calc(2.25rem + 10px);" /> 
					</div>
					<div style="margin-top: 30; text-align: center;">
						<button type="submit" class="btn btn-success btn-lg btn-block">로그인</button>
					</div>
					<div style="margin-top: 10; text-align: center;">
						<button id="registerBtn" type="button" class="btn btn-warning btn-lg btn-block">회원가입</button>
					</div>
				</c:if>
				<c:if test="${member != null }">
					<div class="form-group" style="text-align: center; font-size: 50px;">
						<p style="font-size: xx-large;">${member.userId}님 어떤거 하시겠습니까?</p>
						<button id="memberUpdateBtn" type="button" class="btn btn-success" style="text-align: center; font-size: 20px;">정보수정하기</button>
						<button id="memberdeleteBtn" type="button" class="btn btn-success" style="text-align: center; font-size: 20px;">회원탈퇴하기</button>
					</div>
				</c:if>
				<c:if test="${msg == false}">
					<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
				</c:if>
			  </div>	
			</form>
		</div>	
	</section>
</body>
</html>