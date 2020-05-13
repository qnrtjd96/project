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
		<title>회원가입</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			// 취소
			$(".cencle").on("click", function(){
				
				location.href = "/";
						    
			})
		
			$("#submit").on("click", function(){
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				alert(${member.userId} + "님 회원정보 수정이 완료되었습니다.");
			});
		});
	</script>
	<body>
		<section id="container">
			<div class="container">
			 <header>
				<h1 style="font-size: -webkit-xxx-large;">project</h1>
			 </header>
			 <hr />
			 
			 <div>
				<%@include file="../board/nav.jsp" %>
			 </div>
				<form action="/member/memberUpdate" method="post">
					<div class="form-group has-feedback">
						<label class="control-label" for="userId" style="font-size: 18px;">아이디</label>
						<input class="form-control" type="text" id="userId" name="userId" value="${member.userId}" readonly="readonly" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback">
						<label class="control-label" for="userPass" style="font-size: 18px;">패스워드</label>
						<input class="form-control" type="password" id="userPass" name="userPass" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback">
						<label class="control-label" for="userName" style="font-size: 18px;">성명</label>
						<input class="form-control" type="text" id="userName" name="userName" value="${member.userName}" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback" style="margin-top: 30;">
						<button class="btn btn-success btn-lg btn-block" type="submit" id="submit">회원정보수정</button>
					</div>
					<div class="form-group has-feedback" style="margin-top: 10;">
						<button class="cencle btn btn-danger btn-lg btn-block" type="button">취소</button>
					</div>
				</form>
			</div>
		</section>
		
	</body>
	
</html>