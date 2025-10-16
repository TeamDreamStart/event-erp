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
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 16px;
}

.section-header h2 {
	font-size: 30px;
	font-weight: 700;
	line-height: 40px;
}
.main-cancle{
 max-width: 800px;
margin: 0 auto;
background-color: #FAF9F6;
color: #222222;
padding: 30px;
box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
flex-grow: 1;
overflow-y: auto;
max-height: 600px; 
caret-color: transparent;
}
.cancle-scroll{
 width: 100%;
 height: 300px;
overflow-y: scroll;
border: none;
padding: 0;
background-color: #FAF9F6;
color: #222222;
}
.end-btn{
  margin: 58px auto 0 auto;
  display: block;
  width: fit-content;
  text-align: center;
}
#btn-back{
  border: 1px solid #AFAFAF;
  background-color: #F2F0EF;
  margin-right: 16px;
  padding: 8px 2px;
  width: 80px;
  border-radius: 12px;
  font-weight: bold;
 cursor: pointer;
}
.reservation-cancle{
  border: 1px solid #8FAFED;
  background-color: #BFD4F9;
  padding: 8px 2px;
  border-radius: 12px;
  width: 80px;
  font-weight: bold;
 cursor: pointer;
}
.reservation-info h4,
.cancle-reason h4 {
font-size: 14px;
font-weight: bold;
margin-top: 0;
margin-bottom: 15px;
}
.reservation-info p {
margin-bottom: 25px;
font-size: 14px;
}
.cancle-reason label {
margin-right: 20px;
font-size: 14px;
}
.cancle-reason input[type="radio"] {
margin-right: 4px;
}
.cancle-reason p {
margin-top: 30px;
font-weight: bold;
font-size: 14px;
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
 
    
    <div style="overflow: scroll;" class="cancle-scroll">
        <article class="reservation-info">
       <h4>예약정보</h4>
       <p>이벤트: 가을 음악 페스티벌</p>
      </article>
   
   <article class="cancle-reason" aria-required="true">
   <h4>예약취소사유</h4>
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
        <div style="height: 150px;"></div>
   </article>
  </div>
  
    <div class="end-btn">
   <button onclick="history.back()" id="btn-back">취소</button>
   <button type="submit" class="reservation-cancle">예약취소</button>
  </div>
</div>
</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>