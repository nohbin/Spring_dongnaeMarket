<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">

<script type="text/javascript">

$(document).ready(()=>{
	$("#roomSubmit").submit(()=>{
		
		var titles = document.getElementById("title").value;

		
		if (titles !== "") {
			alert(titles + " 방이 개설되었습니다.");
			
			$.ajax({
				url: './createRoom', // 실제 요청할 URL
				method: 'POST',
				data: {title: title}, // 요청 데이터
				dataType: 'json', // 응답 데이터 형식
				success: (responseData)=>{
					// 성공적으로 응답을 받았을 때의 동작
					console.log(responseData); // 응답 데이터 출력
				}
			});
			
			
		}else {
			alert("Please write the name.");
		}	
	});
});
</script>
<body>
	<div class="container">
    
		<div id="lists">
			<ul>
				<li><a href="/chat/room?roomId=${list.roomId}"">${list.name}</a></li> 
			</ul>
		</div>

		<form action="./createRoom" method="post" id="roomSubmit">
			<input type="text" id="title" name="title" class="form-control">
			<button class="btn btn-secondary">개설하기</button>
		</form>
	    
	</div>        
</body> 
</html>