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
	 	<!-- 주소API를 받아오기위한 script -->
	 	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	 	<!-- 지도API를 받아오기위한 script -->
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=92068749f55230080ea930abfa4851b9&libraries=services"></script>
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
				
				if($("#userPass1").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass1").focus();
					return false;
				}
				
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				
				if($("#address").val()==""){
					alert("주소를 입력해주세요.");
					$("#address").focus();
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
		};
		
		$(function(){ 
			$("#alert-success").hide(); 
			$("#alert-danger").hide(); 
			$("#userPass1").keyup(function(){ 
				var pwd=$("#userPass").val(); 
				var pwd1=$("#userPass1").val(); 
				if(pwd != "" || pwd1 != ""){ 
					if(pwd == pwd1){ 
					$("#alert-success").show();
					$("#alert-danger").hide();
					$("#submit").removeAttr("disabled"); 
				}else{ 
					$("#alert-success").hide();
					$("#alert-danger").show();
					$("#submit").attr("disabled","disabled"); 
				} 
			} 
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
					<div class="form-group has-feedback" >
						<label class="control-label" for="userPass" style="font-size: 18px;">패스워드 재확인</label>
						<input class="form-control" type="password" id="userPass1" name="userPass1" style="height: calc(2.25rem + 10px);"/>
						<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
						<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div> 
					</div>
					<div class="form-group has-feedback">
						<label class="control-label" for="userName" style="font-size: 18px;">성명</label>
						<input class="form-control" type="text" id="userName" name="userName" style="height: calc(2.25rem + 10px);"/>
					</div>
					<div class="form-group has-feedback">
						<label class="control-label" for="userAddress" style="font-size: 18px;">주소</label>
						<button type="button" onclick="sample5_execDaumPostcode();" value="주소검색" class="addChk" id="addChk">주소검색</button>
						<input class="form-control" type="text" id="address" name="address" style="height: calc(2.25rem + 10px);" placeholder="상세주소는 이어서 적어주세요"/>
					</div>
					<div class="form-group has-feedback" id="map" style="width:100%;height:300px;margin-top:10px;display:none">
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
	<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });


    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {
                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
    </script>
</html>