<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap"
	rel="stylesheet" />
<title>footer</title>
<style>
#footer {
	height: 360px;
	padding: 128px 62px 27px 62px;
	margin-bottom: 94px;
	border: 1px solid #222;
	background: #CBD4C2;
	color: #888; line-height: 40px;
	font-size: 16px;
}

#footer .footer_addr {
	margin-bottom: 48px;
	position: relative; 
}
#footer .footer_addr span:last-child {
	position: absolute; top : 46px; left: 0;
}

#footer hr {
	width: 1320px; height: 1px;
	margin: 88px 0 28px;
	background-color: #222;
}

.footer .address {
	margin: 64px 0 16px;
}
</style>
</head>
<body>
	<footer id="footer" class="container" role="contentinfo">
		<address class="footer_addr">
			<span>경기 수원시 팔달구 덕영대로 895번길 11</span> 
			<span>
				<a href="tel:0314204204" aria-label="대표전화 031-420-4204">
					대표전화. 031-420-4204</a>
			</span>
		</address>
		<hr>
		<small class="footer_copy"> &copy; <fmt:formatDate
				value="${now}" pattern="yyyy" /> DreamStart. All rights reserved.
		</small>
	</footer>
</body>
</html>
