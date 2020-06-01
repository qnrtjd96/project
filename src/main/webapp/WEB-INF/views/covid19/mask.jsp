<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>공공마스크를 입고한 약국조회</title>
</head>
<body>
	<input id="lat" type="hidden" value="${lat}"/>
	<input id="lon" type="hidden" value="${lon}"/>
	<div>
		<%@include file="nav.jsp" %>
	</div>
	<div id="map" style="width: 100%; height: 100vh;"></div>
	<!-- <input type="text" id="mark1" value= position.coords.latitude>
	<input type="text" id="mark2" value= position.coords.longitude> -->
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=92068749f55230080ea930abfa4851b9&libraries=clusterer"></script>
	<script>
	
	//브라우저 체크
	function getBrowserType() {
		var agt = navigator.userAgent.toLowerCase();
		if (agt.indexOf("chrome") != -1) {
			return 'Chrome';
		}
		if (agt.indexOf("opera") != -1) {
			return 'Opera';
		}
		if (agt.indexOf("staroffice") != -1) {
			return 'Star Office';
		}
		if (agt.indexOf("webtv") != -1) {
			return 'WebTV';
		}
		if (agt.indexOf("beonex") != -1) {
			return 'Beonex';
		}
		if (agt.indexOf("chimera") != -1) {
			return 'Chimera';
		}
		if (agt.indexOf("netpositive") != -1) {
			return 'NetPositive';
		}
		if (agt.indexOf("phoenix") != -1) {
			return 'Phoenix';
		}
		if (agt.indexOf("firefox") != -1) {
			return 'Firefox';
		}
		if (agt.indexOf("safari") != -1) {
			return 'Safari';
		}
		if (agt.indexOf("skipstone") != -1) {
			return 'SkipStone';
		}
		if (agt.indexOf("msie") != -1) {
			return 'Internet Explorer';
		}
		if (agt.indexOf("rv:11.0") != -1) {
			return 'Internet Explorer';
		}
		if (agt.indexOf("netscape") != -1) {
			return 'Netscape';
		}
		if (agt.indexOf("mozilla/5.0") != -1) {
			return 'Mozilla';
		}
		
	}
	var str = getBrowserType();
	if (getBrowserType("CHROM")){
		alert("크롬은 보안정책상 위치정보를 받아오지 못합니다.");
		
		}
	if (getBrowserType()){
		alert(str + "으로 접속하셨습니다.");
	}
	
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	 if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude; // 위도
	        $('#lat').val(lat);
	        var lon = position.coords.longitude; // 경도
	        $('#lon').val(lon);
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '사용자위치'; // 인포윈도우에 표시될 내용입니다
	            
	        var x = document.getElementById("lat").value;
	   	 	var y = document.getElementById("lon").value;
	
			const url = 'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat='+ x +'&lng='+ y +'&m=5000';
	
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			mapOption = {
				center : new kakao.maps.LatLng(37.553419, 126.971585), // 지도의 중심좌표
				level : 3
			// 지도의 확대 레벨
			};

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			// 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
			
			// 마커 클러스터러를 생성합니다 
			var clusterer = new kakao.maps.MarkerClusterer({
				map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
				averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
				minLevel : 5,  // 클러스터 할 최소 지도 레벨
				disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
			});
		
			fetch(url)
			 .then((res) => res.json())
			 .then((myJson) => { 
			
				var markers = [];
				
				// 마커 이미지의 이미지 주소입니다
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
				
				// 마커 이미지의 이미지 크기 입니다
				var imageSize = new kakao.maps.Size(24, 35);
	
				// 마커 이미지를 생성합니다    
				var markerImage = new kakao.maps.MarkerImage(imageSrc,
						imageSize);
				
					const storeInfos = myJson.stores;
					for (var i = 0; i < storeInfos.length; i++) {
						
						// 마커 이미지의 이미지 크기 입니다
						var imageSize = new kakao.maps.Size(24, 35);
	
						// 마커 이미지를 생성합니다    
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
						
						//마커가 표시될 위치
						var markerPosition = new kakao.maps.LatLng(storeInfos[i]["lat"], storeInfos[i]["lng"]); 
						
						//재고수량 안내
					    var goods = storeInfos[i]["remain_stat"];
					    if(storeInfos[i]["remain_stat"] == "plenty"){
					    	goods="재고 100개이상";
					   	}
					    else if(storeInfos[i]["remain_stat"] == "some"){
					    	goods="재고 30개이상";
					    }
					    else if(storeInfos[i]["remain_stat"] == "few"){
					    	goods="재고 2개이상";
					    }
					    else goods="재고없음";
					    
						//인포윈도우 텍스트에 담을 변수 생성
						var iwContent = "storeInfos[i]["name"] + //약국이름
										"<hr>"+					//줄바꿈
										goods + 				//재고수량
										"<hr>"+ 				//줄바꿈
										storeInfos[i]["addr"];	//주소
						
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
							map: map, // 마커를 표시할 지도
							position : markerPosition, //마커의 좌표 
							title : iwContent, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
							image : markerImage, // 마커 이미지
						});
						markers.push(marker);
					}
					clusterer.addMarkers(markers);
		 		});
			
				// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
				function makeOverListener(map, marker, infowindow) {
				    return function() {
				        infowindow.open(map, marker);
				    };
				}
			
				// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
				function makeOutListener(infowindow) {
				    return function() {
				        infowindow.close();
				    };
				}
					
				// 마커 클러스터러에 클릭이벤트를 등록합니다
				// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
				// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
				kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
			
					// 현재 지도 레벨에서 1레벨 확대한 레벨
					var level = map.getLevel()-1;
			
					// 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
					map.setLevel(level, {anchor : cluster.getCenter()});
				});
					
				// 지도 타입 변경 컨트롤을 생성한다
				var mapTypeControl = new kakao.maps.MapTypeControl();
			
				// 지도의 상단 우측에 지도 타입 변경 컨트롤을 추가한다
				map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
			
				// 지도에 확대 축소 컨트롤을 생성한다
				var zoomControl = new kakao.maps.ZoomControl();
			
				// 지도의 우측에 확대 축소 컨트롤을 추가한다
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
				// 지도 확대 레벨 변화 이벤트를 등록한다
				kakao.maps.event.addListener(map, 'zoom_changed', function() {
					console.log('지도의 현재 확대레벨은 ' + map.getLevel() + '레벨 입니다.');
				});
				
				// 지도에 마커와 인포윈도우를 표시하는 함수입니다
				function displayMarker(locPosition, message) {
				
				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({  
				        map: map, 
				        position: locPosition
				    }); 
				    
				    var iwContent = message, // 인포윈도우에 표시할 내용
				        iwRemoveable = true;
				
				    // 인포윈도우를 생성합니다
				    var infowindow = new kakao.maps.InfoWindow({
				        content : iwContent,
				        removable : iwRemoveable
				    });
				    
				    // 인포윈도우를 마커위에 표시합니다 
				    infowindow.open(map, marker);
				    
				    // 지도 중심좌표를 접속위치로 변경합니다
				    map.setCenter(locPosition);      
				}  
	    	});
	    
			} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
			    
			    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
			        message = 'geolocation을 사용할수 없어요..'
			        
			    displayMarker(locPosition, message);
			}
	</script>
</body>
</html>