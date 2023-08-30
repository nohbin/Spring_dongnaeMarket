<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<script	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){

    var roomName = '${room.name}';
    var username = '${username}';
    var roomId = '${room.roomId}';
    
    

    console.log(roomName + ", " + roomId + ", " + username);

    var sockJs = new SockJS("/ws-stomp");
    //1. SockJS를 내부에 들고있는 stomp를 내어줌
    var stomp = Stomp.over(sockJs);

    //2. connection이 맺어지면 실행
    stomp.connect({}, function (){
       console.log("STOMP Connection")

       //4. subscribe(path, callback)으로 메세지를 받을 수 있음
       stomp.subscribe("/sub/chat/room/" + roomId, function (chat) {
           var content = JSON.parse(chat.body);

           var writer = content.writer;
           var str = '';
           var message = content.message;
           console.log(writer);
           if(message===''){
        	   return;
           }else{
        	   if(writer === username){						// 내가쓴 메시지
                   str = "<div class='col-6'>";
                   str += "<div class='alert alert-secondary'>";
                   str += "<b>" + writer + " : " + message+ "</b>";
                   str += "</div></div>";
                   $("#msgArea").append(str);
               }
               else{
                   str = "<div class='col-6'>";
                   str += "<div class='alert alert-warning'>";
                   str += "<b>" + writer + " : " + message + "</b>";
                   str += "</div></div>";
                   $("#msgArea").append(str);
               } 
        	   
           }  
       });

       //3. send(path, header, message)로 메세지를 보낼 수 있음
       stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
    });

    $("#button-send").on("click", function(e){
        var msg = document.getElementById("msg");

        console.log(username + ":" + msg.value);
        stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
        msg.value = '';
    });
});

</script>
<body>
	<div class="container">
		<div class="col-6">
			<h1>${room.name}</h1>
		</div>

		<div>
			<div id="msgArea" class="col"></div>
			<div class="col-6">
				<div class="input-group mb-3">
					<input type="text" id="msg" class="form-control">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary" type="button"
							id="button-send">전송</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6"></div>
	</div>
</body>

</html>