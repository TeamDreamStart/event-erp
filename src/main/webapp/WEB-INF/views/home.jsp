<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.google.com/specimen/Montserrat" rel="stylesheet">
    <style>
body {
    font-family: 'Montserrat';
    background-color: #E5E2DB;
    margin: 0;
    padding: 0px;
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
}

.container {
    width: 100%;
    max-width: 896px; /* 설문 양식의 너비 설정 */
    min-height: 797px;
    background-color: #FFFFFF;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    padding: 40px 50px;
    margin-top: 40px;
    margin-bottom: 0px;
}

/* 헤더 스타일 */
.header {
    display: flex;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 0px;
    border-bottom: none;
}

.back-arrow {
    text-decoration: none;
    color: #222;
    width: 40px;
    height: 40px;
    font-size: 40px;
    font-weight: bold;
    position: relative;
    margin-right: 30px;
    display: block;
}

.header h1 {
    font-size: 30px;
    font-weight: bold;
    color: #222;
    margin: 0;
}

/* 질문 섹션 및 그룹 스타일 */
.section {
    border: none;
    padding: 0;
    margin-bottom: 20px;
}

.section-title {
    font-size: 14px;
    font-weight: bold;
    color: #222;
    margin-bottom: 25px;
    padding-left: 0;
    border-left: none;
}

.question-group {
    margin-bottom: 30px;
    padding: 0px;
    border: none;  /*테두리 제거*/
    background-color: transparent /*배경색 투명*/
}

.question-number {
    font-size: 14px;
    font-weight: normal;
    color: #222;
    margin-top: 0;
    margin-bottom: 22px;
}

/* 선택지 스타일 */
.options-row {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
}

.options-row label {
    display: flex;
    align-items: center;
    cursor: pointer;
    font-size: 14px;
    color: #222;
    padding: 0px;
    border: none;
    border-radius: 0px;
    transition: none;
}

.options-row label:hover {
    background-color: transparent; /* hover 효과 제거 */
}

.options-row input[type="radio"],
.options-row input[type="checkbox"] {
    margin-right: 22px;
    width: 16px;
    height: 16px;

}

/* 버튼 스타일 */
.button-group {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-top: 44px;
    padding-top: 0px;
    border-top: none;
    text-align: center;
}

.btn {
    padding: 0;
    border: none;
    border-radius: 14px;
    font-size: 16px;
    cursor: pointer;
    margin: 0 8px;
    width: 106px;
    height: 34px;
    transition: background-color 0.2s;
    white-space: nowrap;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;

}

.btn-cancel {
    background-color: #F2F0EF;
    border: 1px solid #AFAFAF;
    color: #222;
}

.btn-submit {
    background-color: #BFD4F9;
    border: 1px solid #8FAFED;
    color: #222;
}
    </style>

  <title>설문 조사 (단일 선택)</title>
    <link rel="stylesheet" href="style.css">
    </head>
<body>
    <div class="container">
        <header class="header">
            <h1>설문조사</h1>
            <a href="#" class="back-arrow" aria-label="뒤로 가기">&larr;</a>
        </header>

        <form class="survey-form">
            <fieldset class="section">
                <legend class="section-title">흥미/인적사항 관련</legend>

                <div class="question-group">
                    <p class="question-number">1. 귀하의 성별은 남성입니까 여성입니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="gender" value="male"> 남성</label>
                        <label><input type="radio" name="gender" value="female"> 여성</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">2. 귀하의 연령은 어떻게 되십니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="age" value="10s"> 10대</label>
                        <label><input type="radio" name="age" value="20s"> 20대</label>
                        <label><input type="radio" name="age" value="30s"> 30대</label>
                        <label><input type="radio" name="age" value="40s"> 40대</label>
                        <label><input type="radio" name="age" value="50s"> 50대</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">3. 귀하가 좋아하는 음악 장르는 무엇입니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="music" value="ballad"> 발라드</label>
                        <label><input type="radio" name="music" value="hiphop"> 힙합</label>
                        <label><input type="radio" name="music" value="dance"> 댄스</label>
                        <label><input type="radio" name="music" value="rock"> 락</label>
                        <label><input type="radio" name="music" value="trot"> 트로트</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">4. 귀하가 좋아하는 영화 장르는 무엇입니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="movie" value="comedy"> 코미디</label>
                        <label><input type="radio" name="movie" value="thriller"> 스릴러</label>
                        <label><input type="radio" name="movie" value="action_sf"> 액션(SF)</label>
                        <label><input type="radio" name="movie" value="drama"> 드라마</label>
                        <label><input type="radio" name="movie" value="other_movie"> 기타</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">5. 귀하가 좋아하는 음식은 무엇입니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="food" value="korean"> 한식</label>
                        <label><input type="radio" name="food" value="western"> 양식</label>
                        <label><input type="radio" name="food" value="japanese"> 일식</label>
                        <label><input type="radio" name="food" value="chinese"> 중식</label>
                        <label><input type="radio" name="food" value="other_food"> 기타</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">6. 귀하의 현재 관심사는 무엇입니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="interest" value="career"> 진로</label>
                        <label><input type="radio" name="interest" value="certificate"> 자격증</label>
                        <label><input type="radio" name="interest" value="love"> 이성</label>
                        <label><input type="radio" name="friends" value="friends"> 친구</label>
                        <label><input type="radio" name="interest" value="other_interest"> 기타</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">7. 귀하는 훗날에 어떻게 돈을 벌고 싶으십니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="money_making" value="employment"> 취업</label>
                        <label><input type="radio" name="money_making" value="business"> 사업(창업)</label>
                        <label><input type="radio" name="money_making" value="self_employment"> 자영업</label>
                        <label><input type="radio" name="money_making" value="investment"> 투자</label>
                        <label><input type="radio" name="money_making" value="finance"> 재테크</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">8. 귀하의 취미는 어떤 분야에 가깝습니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="hobby_field" value="art"> 미술</label>
                        <label><input type="radio" name="hobby_field" value="music"> 음악</label>
                        <label><input type="radio" name="hobby_field" value="sports"> 운동(스포츠)</label>
                        <label><input type="radio" name="hobby_field" value="literature"> 문예</label>
                        <label><input type="radio" name="hobby_field" value="other_hobby_field"> 기타</label>
                    </div>
                </div>

                <div class="question-group">
                    <p class="question-number">9. 이성을 볼 때 무엇을 가장 중요하게 생각하십니까?</p>
                    <div class="options-row">
                        <label><input type="radio" name="ideal_type" value="education"> 학력</label>
                        <label><input type="radio" name="ideal_type" value="appearance"> 외모</label>
                        <label><input type="radio" name="ideal_type" value="job"> 직업</label>
                        <label><input type="radio" name="ideal_type" value="personality"> 성격</label>
                        <label><input type="radio" name="ideal_type" value="heart"> 마음</label>
                    </div>
                </div>

            </fieldset>
        </form>
        </div><div class="button-group">
            <button type="button" class="btn btn-cancel">취소</button>
            <button type="submit" class="btn btn-submit">설문 제출</button>
        </div>
</body>
</html>