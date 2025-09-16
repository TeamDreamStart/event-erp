<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<header>
		<div class="header-container">
			<a href="/" class="logo">D</a>
			<nav class="main-nav">
				<ul>
					<li><a href="#">Visit</a></li>
					<li><a href="#">Exhibitions</a></li>
					<li><a href="#">Store</a></li>
				</ul>
			</nav>
			<div class="user-actions">
				<a href="#">Membership</a>
				<a href="#">Tickets</a>
			</div>
		</div>
	</header>
	<main>
		<section class="main-visual">
			<img src="<c:url value='#'/>" alt="Museum Interior" class="visual-image"/>
			<div class="museum-status">
				<p>open 10:30 a.m.</p>
				<p>close 18:00 p.m.</p>
				<p>The time on the server is ${serverTime}.</p>
			</div>
		</section>
		<section class="horizontal-scroll-section exhibitions">
			<h2>Exhibitions</h2>
			<div class="card-container">
				<article class="exhibition-card">
				</article>
        <article class="exhibition-card"></article>
        <article class="exhibition-card"></article>
			</div>
		</section>
	</main>
	<footer>
		<p>Copyright © 2025</p>
	</footer>
</body>
</html>
