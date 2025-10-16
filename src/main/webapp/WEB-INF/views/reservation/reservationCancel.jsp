<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700;900&display=swap" rel="stylesheet"/>
<title>reservation cancle</title>
<style>
body{
 background-color: #E5E2DB;
  color: #222222;
  font-family: 'Montserrat', sans-serif;
  font-size: 16px;
  font-weight: normal;
  margin: 0;
  padding: 0 120px 60px;
  line-height: 1;
}
main {
  margin-top: 0;
  padding: 0;
}
.container {
width: 100%;
  margin: 0 auto;
  padding: 0;
}
.section-header {
 position: relative;
 padding-top: 40px;
 margin-bottom: 40px;
 text-align: left;
}
.section-header h2{
 font-size: 20px;
 font-weight: bold;
 user-select: none;
 cursor: default;
 margin: 0;
 padding: 0;
}
.main-cancle{
	max-width: 1000px;
  margin: 0 auto;
  background-color: #FAF9F6;
  color: #222222;
  overflow: hidden;
	padding: 30px;
  min-height: 600px;
  display: flex;
  flex-direction: column;
  position: relative;
	
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <main>
 <div class="container">
 <div class="section-header">
  <h2>예약취소</h2>
 </div>
 <div class="main-cancle">
   <article class="reservation-info">
    <h4>예약정보</h4>
		<p>이벤트: 가을 음악 페스티벌</p>
		</article>
		<article class="cancle-reason" aria-required="true">
    <h4>예약정보</h4>
		<textarea style="overflow: scroll;" class="cancle-scroll">
			<input type="radio" class="mind" name="cancleReason" value="단순변심">
			<label for="mind">단순변심</label>
			<input type="radio" class="disaster" name="cancleReason" value="천재지변">
			<label for="disaster">천재지변</label>
			<input type="radio" class="moved" name="cancleReason" value="이벤트일정 변동">
			<label for="moved">이벤트일정 변동</label>
			<input type="radio" class="cancle" name="cancleReason" value="공연취소">
			<label for="cancle">공연취소</label>
			<input type="radio" class="disease" name="cancleReason" value="건강상의 이유">
			<label for="disease">건강상의 이유</label>
			<p>취소금액: 15000원</p>
		</textarea>

		<button onclick="history.back()" id="btn-back">취소</button>
		<button type="submit" class="reservation-cancle">예약취소</button>
		</article>
 </div>
 </div>
 </main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>