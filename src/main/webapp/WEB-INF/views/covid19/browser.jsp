<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8" />
<title>Hello, Test World</title>
</head>
<body>
	<div id="example"></div>

	<!-- jQuery library -->
	<script src="resources/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
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
		alert(str);
	</script>
</body>
</html>