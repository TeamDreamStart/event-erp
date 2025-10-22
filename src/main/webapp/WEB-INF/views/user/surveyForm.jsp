<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>설문조사</title>
</head>

<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp" flush="true" />

  <main id="main" class="container" role="main">
    <h2>설문조사</h2>
    <form action="<c:url value='/my-info/survey/${eventId}/submit'/>" method="post">
      <input type="hidden" name="eventId" value="${eventId}">
      <input type="hidden" name="surveyId" value="${surveyId}">

      <c:forEach var="q" items="${questions}">
        <div>
          <p><strong>${q.question}</strong></p>
          <c:forEach var="opt" items="${options[q.questionId]}">
            <label>
              <input type="radio" name="answer_${q.questionId}" value="${opt.optionId}">
              ${opt.label}
            </label><br>
          </c:forEach>
        </div>
        <hr>
      </c:forEach>

      <div>
        <button type="submit" class="btn">설문 제출</button>
        <a href="/my-info" class="btn join">취소</a>
      </div>
    </form>
  </main>

  <jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
