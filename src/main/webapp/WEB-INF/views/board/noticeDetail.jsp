<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.cdnfonts.com/css/peristiwa" rel="stylesheet">
<link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet">
 <link rel="stylesheet" href="/webapp/resources/css/noticeList.css">

        <style>
        
        body {
            background-color: #E5E2DB; /* 배경색 */
            font-family: 'Montserrat', sans-serif;
            color: #222; /* 텍스트색 */
            margin: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        /* 메인 콘텐츠 래퍼: 888px로 고정 및 중앙 정렬 */
        main {
            width: 888px; /* 핵심 컨테이너 너비 */
            margin: 140px auto 80px auto; /* 상단 여백 추가 */
            padding: 0;
            background-color: transparent;
            flex-grow: 1;
        }

        /* ---------------------------------------------------- */
        /* 공지사항 본문 섹션 스타일 (Notice Title) */
        /* ---------------------------------------------------- */

        .notice-section {
            width: 100%; /* 888px */
            position: relative;
        }

        .notice-section h2 {
            /* 메인 타이틀 "Notice" */
            text-align: center;
            font-size: 30px;
            font-weight: bold; 
            margin-bottom: 80px; /*타이틀 아래 간격*/
            letter-spacing: 0.1em;
        }

		.notice-section h2::after{
			content: none;
		}
        

        /* 전체 흰색 박스 (제목, 메타, 내용 포함) */
        .notice-wrapper {
            background-color: #FAF9F6;
            border-radius: 0; 
            margin-top: 80px; /* H2와의 간격 */
            padding: 40px; /* 내부 여백 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            
            /* [수정] 상자 윗부분만 1px #222 선 적용 */
            border-top: 1px solid #222;
        }

        /* 게시글 제목 */
        .notice-header h3 { 
            font-size: 14px;
            font-weight: bold;
            margin: 0;
            color: #222;
            padding-bottom: 25px; /* 아래 선과의 간격 */
			padding-top: 26px;;
        }
        
        /* 제목 아래 얇은 선 */
        .notice-title-separator {
            border: none;
            border-top: 1px solid #AFAFAF; 
            margin: 0; /* 메타 정보와의 간격 */
        }

        /* 메타 정보 (등록일자 | 조회수) */
        .notice-meta-row {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            font-size: 16px;
            color: #AFAFAF; /* 회색 텍스트 */
            padding-bottom: 23px; /* 아래 구분선과의 간격 */
			padding-top: 24px;
        }

        /* 내용과 메타 정보를 나누는 구분선 */
        .header-separator {
            border: none;
            border-top: 1px solid #AFAFAF; /* 매우 얇고 밝은 선 */
            margin: 0;
        }

        /* 공지사항 내용 영역 */
        .notice-content {
			max-width: 616px;
            width: 100%; 
            min-height: 400px; 
            padding-top: 26px; /* 구분선과의 간격 */
            line-height: 22; /* 행간 조정 */
        }

        .notice-content p {
            margin: 0 0 15px 0;
            font-size: 14px;
			line-height: 1.57;  /*22px / 14px*/
            color: #222;
        }

        .notice-content strong {
            color: #FF0000;
            font-weight: bold;
        }
        
        /* [시스템 점검 안내] 부분 스타일링 */
        .notice-content p:nth-child(4) {
            margin-top: 25px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        /* 목록 버튼 컨테이너 (흰색 박스 외부) */
        .back-button-container {
            width: 100%; 
            margin: 32px auto 0;
            text-align: right;
            padding-right: 0;
        }

        .back-button {
            width: 106px;
            height: 34px;
            border-radius: 14px; /* 더 둥글게 */
            background-color: #fff;
            border: 1px solid #222;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .back-button:hover {
            background-color: #f0f0f0;
        }
    </style>

<title>noticedetail</title>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	

	<main>
		<section class="notice-section">
			<h2>Notice</h2>
			<div class="notice-header">
				<h3>${postDTO.title }</h3>
				<div class="notice-meta">
					<span>등록일자:s</span> | <span>조회:s
						</span>
				</div>
			</div>
			<div class="notice-content">
				<c:if test="${not empty fileList }">
					<c:forEach var="fileDTO" items="${fileList}">
						<img style="width:100%"
							src="${pageContext.request.contextPath}/resources/uploadTemp/${fileDTO.storedPath}/${fileDTO.uuid}_${fileDTO.originalName}"
							alt="${fileDTO.originalName}">
					</c:forEach>
					<br>
				</c:if>
				<c:if test="${empty fileList }">
					<span>* 첨부된 사진이 없습니다.</span><br>
				</c:if>
				${postDTO.content }
			</div>
			<div class="back-button-container">
				<button class="back-button" onclick="location.href='/notices'">목록</button>
			</div>
		</section>
	</main>
	<footer
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</footer>
</body>
</html> 