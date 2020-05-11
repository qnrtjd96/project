<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Bootstrap CSS -->

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Insert title here</title>
</head>

<script>
	
</script>

<body>
<nav class="navbar navbar-expand navbar-dark bg-dark">
  <a class="navbar-brand" href="../" style="font-size: 18px; padding-top: 1.2rem; !important">KANGSAN.COM</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample02" aria-controls="navbarsExample02" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarsExample02">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/board/list" style="font-size: 2vmin;">■글목록<span class="sr-only"></span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="/board/writeView" style="font-size: 2vmin;">■글 작성<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="../covid19/clinic2" style="font-size: 2vmin;">■코로나 진료소<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="../covid19/mask" style="font-size: 2vmin;">■마스크 판매처<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <c:if test="${member.grade == null}"><a href="/" class="nav-link" style="font-size: 2vmin;">■로그인</a></c:if>
		<c:if test="${member.grade == 0}"><a href="/member/logout" class="nav-link" style="font-size: 2vmin;">■로그아웃</a></c:if>
	  </li>
	  	<c:if test="${member.grade == 1 }">
		  <li class="nav-item active">
			<c:if test="${member.grade != 0}"><a href="/member/logout" class="nav-link" style="font-size: 2vmin;">■관리자로그아웃</a></c:if>
		  </li>
	  	</c:if>
		<li class="nav-item active">
			<c:if test="${member.grade == 1}"><a href="/admin/list" class="nav-link" style="font-size: 2vmin;">■관리자 화면</a></c:if>
		</li>
    </ul>
  </div>
</nav>
</body>
</html>