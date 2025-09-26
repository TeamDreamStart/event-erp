<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<header> </header>

	<nav></nav>

	<article>
		<!-- file upload -->
		<h3>Controller</h3>
		<!-- 		<div>
			<form action="/upload" method="post" enctype="multipart/form-data">
				ownerType-> DB 테이블명  owner_id->controller 에서 넘겨주자
				<input type="hidden" name="ownerType" value="board_post"> <input
					type="file" name="uploadFile" multiple>
				<button type="submit">업로드</button>
			</form>
		</div>
 -->
		<hr>
		<h3>Ajax</h3>
		<!-- ajax upload -->
		<div class="imgWrapper">
			<div class="uploadImg"></div>
		</div>
		<div id="ajaxUpload">
			<p>파일 업로드 최대 크기는 5MB 입니다.</p>
			<input type="file" name="uploadFile" multiple>
			<div class="uploadResult">
				<ul>
				</ul>
			</div>
		</div>
		<button id="uploadBtn">업로드</button>

		<script type="text/javascript">
			$(document).ready(function() {
				// 업로드할 수 없는 파일 확장자와 최대 파일 크기 설정
				var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //정규표현식
				//이미지 파일만 허용
				/* var regex = new RegExp("(.*?)\\.(jpg|jpeg|png|gif|bmp|webp)$", "i");  */
				var maxSize = 5242880; //5MB

				// 파일 확장자 및 크기 체크하는 함수
				function checkExtension(fileName, fileSize) {
					// 파일 크기가 최대 크기를 초과하는 경우 경고 메시지 출력 후 false 반환
					if (fileSize >= maxSize) {
						alert("파일 사이즈 초과");
						return false;
					}
					// 업로드할 수 없는 파일 확장자인 경우 경고 메시지 출력 후 false 반환
					if (regex.test(fileName)) {
						alert("해당 종류의 파일은 업로드할 수 없습니다.");
						return false;
					}
					// 파일 확장자 및 크기가 모두 유효한 경우 true 반환
					return true;
				} //end function

				var cloneObj = $("#ajaxUpload").clone();
				// 업로드
				$("#uploadBtn").on("click", function(e) {
					// FormData 객체 생성	
					var formData = new FormData();
					// input 태그에서 파일을 가져옴
					var inputFile = $("input[name='uploadFile']");
					// 파일 목록을 가져와 formData에 추가
					var files = inputFile[0].files;
					console.log(files);

					//폼데이터 객체에 담아온 파일들을 넣어준다
					for (var i = 0; i < files.length; i++) {
						// 가져온 파일들을 순회하며 확장자 및 크기 체크 후 formData에 추가
						if (!checkExtension(files[i].name, files[i].size)) {
							return false;
						}
						formData.append("uploadFile", files[i]);
					}

					// AJAX를 통해 서버에 파일 업로드 요청
					$.ajax({
						url : '/uploadAjax',
						processData : false,
						contentType : false,
						data : formData,
						type : 'POST',
						dataType : 'json',
						success : function(result) {
							console.log(result);
							showUploadFile(result);
							
							// 업로드 후 input 초기화 (다시 같은 파일 선택 가능하게)
							inputFile.val("");
						}
					}); //end ajax
				});
 
				var uploadResult = $(".uploadResult ul");

				function showUploadFile(uploadResultArr) {
					var str = "";
					$(uploadResultArr).each(function(i, obj) {
						console.log("@@@@@@@@@@@@@@@@@"+obj.image);
						if(!obj.image){
							str += "<li><img src='resources/img/attach.png'>" + obj.originalName +"</li>"
						}else{
							/* str += "<li>" + obj.originalName + "</li>"; */
							var fileCallPath = encodeURIComponent(obj.storedPath+"/s_"+obj.uuid+"_"+obj.originalName);
							str += "<li><img src='/display?fileName="+fileCallPath+"'></li>";
						}
					});
					uploadResult.append(str);
				}
			});
		</script>
	</article>

	<footer> </footer>
</body>
</html>