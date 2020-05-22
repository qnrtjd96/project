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
						    
			});
			
			//회원가입
			$("#submit").on("click", function(){
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				}
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
				var idChkVal = $("#idChk").val();
				if(idChkVal == "N"){
					alert("중복 확인을 누르지 않았습니다.");
					return false;
				}
				else if(idChkVal == "Y"){
					alert("회원가입이 완료되었습니다.")
					$("#regForm").submit();
				}
			})
		});
		
		
		function fn_idChk(){
			$.ajax({
				url : "/member/idChk",
				type : "post",
				dataType : "json",
				data : {"userId" : $("#userId").val()},
				success : function(data){
					if(data == 1){
						alert("중복된 아이디입니다.");
					}else if(data == 0){
						$("#idChk").attr("value", "Y");
						alert("사용가능한 아이디입니다.");
					}
				}
			})
		}
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
			<div class="container">
				<form action="/member/register" method="post">
					<div class="form-group has-feedback">
						<label class="control-label" for="userId" style="font-size: 18px;">아이디</label>
						<button class="idChk" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
						<input class="form-control" type="text" id="userId" name="userId" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback" >
						<label class="control-label" for="userPass" style="font-size: 18px;">패스워드</label>
						<input class="form-control" type="password" id="userPass" name="userPass" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback">
						<label class="control-label" for="userName" style="font-size: 18px;">성명</label>
						<input class="form-control" type="text" id="userName" name="userName" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback" style="text-align: center;">
						<button class="btn btn-success btn-lg btn-block" type="submit" id="submit">회원가입</button>
					</div>
					<div class="form-group has-feedback" style="text-align: center;">
						<button class="cencle btn btn-danger btn-lg btn-block" type="button">취소</button>
					</div>
				</form>
			</div>
		  </div>
		</section>
	</body>
</html>