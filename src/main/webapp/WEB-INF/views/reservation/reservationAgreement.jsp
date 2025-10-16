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
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <main>
 <div class="container">
 <div class="section-header">
  <h2>Reservation</h2>
 </div>
 </div>
 </main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>