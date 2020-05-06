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
	    	<div>
				<%@include file="board/nav.jsp" %>
	 		</div>
			<form name='homeForm' method="post" action="/member/login">
			  <div style="margin-top: 50;">
				<c:if test="${member == null}">
					<div style="margin-top: 50;">
						<label for="userId">아이디</label>
						<input type="text" id="userId" name="userId" class="form-control">
					</div>
					<div style="margin-top: 10;">
						<label for="userPass">패스워드</label>
						<input type="password" id="userPass" name="userPass" class="form-control">
					</div>
					<div style="margin-top: 10;">
						<button type="submit" class="btn btn-success">로그인</button>
						<button id="registerBtn" type="button" class="btn btn-success">회원가입</button>
					</div>
				</c:if>
				<c:if test="${member != null }">
					<div class="form-group">
						<p>${member.userId}님 환영 합니다.</p>
						<button id="memberUpdateBtn" type="button" class="btn btn-success">회원정보수정</button>
						<button id="memberdeleteBtn" type="button" class="btn btn-success">회원정보삭제</button>
						<button id="logoutBtn" type="button" class="cencle btn btn-danger">로그아웃</button>
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