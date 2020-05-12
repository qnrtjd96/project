<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
		// 엔드포인트 및 액세스 키 설정
		var ip = '134.201.250.155'
		var access_key = '49cf131c1f9277bb7cc0bd0c7ff1b127';
		
		// jQuery.ajax를 통해 API 결과를 얻음
		$.ajax({
		    url: 'http://api.ipstack.com/' + ip + '?access_key=' + access_key,   
		    dataType: 'jsonp',
		    success: function(json) {
		
		        // output the "capital" object inside "location"
		        alert(json.location.capital);
		        
		    }
		});
</script>

<div></div>
</body>
</html>