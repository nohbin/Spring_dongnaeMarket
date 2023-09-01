<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(()=>{
	const $test = document.getElementById('test');
	
	
	
		findUserName=()=>{
			let findUserName = $('#m_name').val();
			console.log(findUserName);
		 	$.ajax({
				url:'./findUserName',
				type: 'POST',
				data: findUserName,
				contentType: "application/json",
				success:(response)=>{
					console.log(response);
					if(response == 'find'){
						
						alert("성공");
					}
					else{
						alert("이름을 확인해 주세요.");
					}
				},error:(data)=>{
					alert(data);
				}
			}); 
		}
		
});

</script>

<body>
<h5>지금은 test중</h5>
<div>
<input type="text" id="m_name" name="m_name">
<button type="button" name="findUserName" onclick="findUserName()">전송</button>
</div>

</body>
</html>