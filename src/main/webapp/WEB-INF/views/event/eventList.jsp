<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>eventList</title>
</head>
<body>
	<header class="header">
		<div class="header-top">
		<span class="header-left">
			<a href="/" class="logo-link"><span class="logo">D</span></a>
			</span>
			<span class="header-right">
				<span class="user-actions">
					<a href="#" class="mypage-link">my page</a>
					<button class="btn-login">login</button>
				</span>
			</span>
		</div>
			<nav class="header-nav">
				<a href="#">Visit</a>
				<a href="#">Exhibitions</a>
				<a href="#">Store</a>
			</nav>
	</header>
	<main class="main-content-wrapper">
		<div class="content-container">
		<article class="exhibitions-article">
			<section class="exhibition-section present-exhibitions">
				<div class="section-header">
				<h2>Present Exhibitions</h2>
				</div>
				<div class="exhibition-grid">
					<div class="exhibition-card">    
						<div class="placeholder">
							<figure class="exhibition-1">
								<img src="#"/>
								<figcaption>사진 1</figcaption>
							</figure>
							<a href="#" class="btn-reserve">바로 예매하기</p> <span class="arrow-right">→</span>
						</div>
					</div>
					<div class="exhibition-card">
						<div class="placeholder">
							<figure class="exhibition-2">
								<img src="#"/>
								<figcaption>사진 2</figcaption>
							</figure>
							<a href="#" class="btn-reserve">바로 예매하기</p> <span class="arrow-right">→</span>
						</div>
					</div>
					<div class="exhibition-card">
						<div class="placeholder">
							<figure class="exhibition-3">
								<img src="#"/>
								<figcaption>사진 3</figcaption>
							</figure>
							<a href="#" class="btn-reserve">바로 예매하기</p> <span class="arrow-right">→</span>
						</div>
					</div>
					<div class="exhibition-card">
						<div class="placeholder">
							<figure class="exhibition-4">
								<img src="#"/>
								<figcaption>사진 4</figcaption>
							</figure>
							<a href="#" class="btn-reserve">바로 예매하기</p> <span class="arrow-right">→</span>
						</div>
					</div>
				</div>
			</section>

			<section class="exhibition-section previous-exhibitions">
			<div class="section-header">
				<h2>Previous Exhibitions</h2>
				</div>
				<div class="exhibition-grid">
					<div class="exhibition-card large">
						<img src="https://via.placeholder.com/250x400/8A2BE2/FFFFFF?text=HOUSE+WORKSHOP+2023.09.25" alt="Previous Exhibition Large Image" class="exhibition-image">
					</div>
					<div class="exhibition-card">
						<div class="placeholder">
							<figure class="pr-exhibition-1">
								<img src="#"/>
								<figcaption>사진 1</figcaption>
							</figure>
						</div>
					</div>
							<div class="exhibition-card">
						<div class="placeholder">
							<figure class="pr-exhibition-2">
								<img src="#"/>
								<figcaption>사진 2</figcaption>
							</figure>
						</div>
						</div>
							<div class="exhibition-card more-link">
								<div class="more-text">
                  더 많은 <br>이전 전시가 보고싶다면?
                </div>
                <a href="#" class="more-link">
                <span class="icon-circle-arrow">→</span> </a>
			</div>
		</div>
		</section>

		<section class="exhibition-section next-exhibitions">
			<div class="section-header">
						<h2>Next Exhibitions</h2>
					</div>
					<div class="next-exhibitions-grid">
						<div class="next-exhibitions-card">
							To be continue . . .
						</div>
						<div class="next-exhibitions-card">
						</div>
					</div>
				</section>
			</article>
		</div>
	</main>

	<footer class="footer">
		<p>수원시 팔달구 덕영대로 895번길 11</p>
		<p>대표전화. 031-420-4204</p>
		<hr class="footer-hr">
		<p>@jfdfhfksehfkjsnckaul</p>
	</footer>
</body>
</html>