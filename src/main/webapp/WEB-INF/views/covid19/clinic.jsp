<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>코로나 선별진료소</title>
</head>
<body>
	<div id="map" style="width: 100%; height: 100vh;"></div>

	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=92068749f55230080ea930abfa4851b9&libraries=clusterer"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
			level : 13, // 지도의 확대 레벨
			mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		};

		//지도를 생성한다.
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		// 마커 클러스터러를 생성합니다 
	    var clusterer = new kakao.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 10, //클러스터 할 최소 지도 레벨 
	        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
	    });

		// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
		var positions = [
		    {
		        content: '<div>카카오</div>', 
		        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>',
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>',
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>',
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>', 
		        latlng: new kakao.maps.LatLng()
		    },
		    {
		        content: '<div></div>',
		        latlng: new kakao.maps.LatLng()
		    },
		];
		var markers=[]

		for (var i = 0; i < positions.length; i ++) {
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng // 마커의 위치
		    });

		    // 마커에 표시할 인포윈도우를 생성합니다 
		    var infowindow = new kakao.maps.InfoWindow({
		        content: positions[i].content // 인포윈도우에 표시할 내용
		    });
		 	
		    markers.push(marker);
		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    }
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
		
		// 클러스터러에 마커들을 추가합니다
	    clusterer.addMarkers(markers);
		
	 	// 마커 클러스터러에 클릭이벤트를 등록합니다
	    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
	    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
	    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

	        // 현재 지도 레벨에서 1레벨 확대한 레벨
	        var level = map.getLevel()-1;

	        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
	        map.setLevel(level, {anchor: cluster.getCenter()});
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
	</script>
</body>
</html>