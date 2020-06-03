<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Bootstrap CSS -->

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Insert title here</title>
</head>

<script>
	
</script>

<body>
<nav class="navbar navbar-expand navbar-dark bg-dark">
  <a class="navbar-brand" href="../" style="font-size: 1.5vmax; !important">KANGSAN.COM</a>
  <button class="navbar-toggler" type="button">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarsExample02">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/board/list" style="font-size: 1.5vmin;">■글목록<span class="sr-only"></span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="/board/writeView" style="font-size: 1.5vmin;">■글 작성<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="../covid19/clinic2" style="font-size: 1.5vmin;">■코로나 진료소<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="../covid19/mask" style="font-size: 1.5vmin;">■마스크 판매처<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
        <!-- jstl구문중 하나면서 if문을 이용하여 grade(등급)값을 추출하여 grade가 null이면 로그인,  0이면 로그아웃을 뜨게 했다. -->
        <c:if test="${member.grade == null}"><a href="/" class="nav-link" style="font-size: 1.5vmin;">■로그인</a></c:if>
		<c:if test="${member.grade == 0}"><a href="/member/logout" class="nav-link" style="font-size: 1.5vmin;">■로그아웃</a></c:if>
	  </li>
	  	<!-- 관리자 모드 일때는 grade가 1이므로 1일때만 나오게 설정을 해놓았고, 이중 if문을 쓴것을 볼 수 있다. -->
	  	<c:if test="${member.grade == 1 }">
		  <li class="nav-item active">
		  	<!-- grade값이 0 이 아니면 관리자 로그아웃을 뜨게 설정해놓은것을 볼수 있음 -->
			<c:if test="${member.grade != 0}"><a href="/member/logout" class="nav-link" style="font-size: 1.5vmin;">■관리자로그아웃</a></c:if>
		  </li>
	  	</c:if>
		<li class="nav-item active">
			<!-- grade의 값이 1이면(>>이게 관리자 등급임) 관리자 화면을 띄어준다. -->
			<c:if test="${member.grade == 1}"><a href="/admin/list" class="nav-link" style="font-size: 1.5vmin;">■관리자 화면</a></c:if>
		</li>
    </ul>
  </div>
</nav>
</body>
</html>