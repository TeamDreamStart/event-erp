<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page session="false"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link href="<c:url value='/resources/css/home.css'/>" rel="stylesheet" type="text/css"/>
<script src="<c:url value='/js/main.js'/>"></script>
<link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet"/>
<title>Home</title>
</head>
<body>
	<header>
		<div class="header-container">
			<h1 class="logo"><a href="/">D</a></h1>
			<nav class="main-nav">
				<ul>
					<li><a href="#">Visit</a></li>
					<li><a href="#">Exhibitions</a></li>
					<li><a href="#">Store</a></li>
				</ul>
			</nav>
			<div class="user-actions">
				<div>
					<div href="#">Membership</div>
					<ul>
						<li><a href="#">로그인</a></li>
						<li><a href="#">로그아웃</a></li>
						<li><a href="#">회원가입</a></li>
					</ul>
				</div>
				<a href="#">Tickets</a>
			</div>
		</div>
	</header>
	<main>
		<section class="main-visual">
			<figure>
				<img src="<c:url value='/resources/img/grand.jpg'/>" alt="메인 베너입니다." class="visual-image"/>
				<figcaption class="hidden">할아버지 할머니가 미술관 구경하는 배너</figcaption>
			</figure>
			<div class="museum-status">
				<p>open 10:30 a.m.</p>
				<p>close 18:00 p.m.</p>
			</div>
		</section>

		<!-- Swiper -->
	<section class="horizontal-scroll-section exhibitions">
		<div class="section-header">
			<h2>Exhibitions</h2>
		</div>

  <div #swiperRef="" class="swiper mySwiper">
    <div class="swiper-wrapper">
      <article class="exhibition-card swiper-slide">
				<div class="placeholder">
				</div>
				<figure class="exhibition-1">
					<img src="<c:url value='/resources/img/ham.jpg'/>" alt="햄스터 이미지를 넣습니다."/>
					<figcaption>귀여운 햄쥐기 이미지</figcaption>
				</figure>
				<p class="title">전시1</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-2">
					<img src="<c:url value='/resources/img/ham1.jpg'/>" alt="햄스터 이미지1를 넣습니다."/>
				</figure>
				<p class="title">전시2</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-3">
					<img src="<c:url value='/resources/img/ham2.jpg'/>" alt="햄스터 이미지2를 넣습니다."/>
				</figure>
				<p class="title">전시3</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-4">
					<img src="<c:url value='/resources/img/ham3.jpg'/>" alt="햄스터 이미지3를 넣습니다."/>
				</figure>
				<p class="title">전시4</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-5">
					<img src="<c:url value='/resources/img/ham4.jpg'/>" alt="햄스터 이미지4를 넣습니다."/>
				</figure>
				<p class="title">전시5</p>
				</article>
				<article class="exhibition-card swiper-slide">
				<div class="placeholder"></div>
				<figure class="exhibition-6">
					<img src="<c:url value='/resources/img/ham5.jpg'/>" alt="햄스터 이미지를 넣습니다."/>
				</figure>
				<p class="title">전시6</p>
				</article>
    </div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>

  <!-- <p class="append-buttons">
    <button class="prepend-2-slides">Prepend 2 Slides</button>
    <button class="prepend-slide">Prepend Slide</button>
    <button class="append-slide">Append Slide</button>
    <button class="append-2-slides">Append 2 Slides</button>
  </p> -->

  <!-- Swiper JS -->
  <!-- <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script> -->

		<section class="calendar-section">
			<div class="section-header">
				<h2>Calendar</h2>
				<span class="calendar-add">더보기</span>
				<span class="notice-label">Notic</span>
			</div>
		</section>
	</main>
	<footer>
		<p>Copyright © 2025</p>
	</footer>

 <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper(".mySwiper", {
      slidesPerView: 3,
      centeredSlides: true,
      spaceBetween: 30,
      pagination: {
        el: ".swiper-pagination",
        type: "fraction",
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
  </script>
</body>


</html>
