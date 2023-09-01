<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="/resources/css/chatting.css" rel="stylesheet">
<script	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<!-- <script src="/resources/js/chat/main.js"></script> -->
<script type="text/javascript">
$(document).ready(function(){
	const $msg = document.getElementById("msg");
    const $send= document.getElementById("button-send");
    
    var image= '';
    var imageDM = "<button type='button' id='button-send'>"+"<img src='/resources/img/chat/DM.png' class='dm-icon' id='buy' alt=''>"+"</button>";
    var imageBUY = "<button type='button' id='button-send'>"+"<img src='/resources/img/chat/buy.png' class='dm-icon' id='buy' alt=''>"+"</button>";
    
    $msg.addEventListener('input',(event)=>{
    	if(event.target.value!==''){
    		if(image==="<img src='/resources/img/chat/dm.png' class='dm-icon' alt=''>"){
    			return;
    		}
    		
            image="<img src='/resources/img/chat/dm.png' class='dm-icon' alt=''>";
	        $send.firstElementChild.remove();
            $("#button-send").append(image);
        }else{
			image="<img src='/resources/img/chat/buy.png' class='dm-icon' id='buy' alt=''>"
			$send.firstElementChild.remove();
			$("#button-send").append(image);
		}
	});

    
    var roomName = '${room.name}';
    var username = '${member.getM_name()}';
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
           if(message===''){
        	   return;
           }else{
        	   if(writer === username){
                   str = "<li class='me'>";
                   str += "<div class='entete'>";
                   str += "<img src='/resources/img/chat/user.png' alt=''>";
                   str += "<h2>"+writer+"</h2></div>";
                   str += "<h3>10:12AM, Today</h3>";
                   str += "<div class='message'>";
                   str += "<b>" + message+ "</b>";
                   str += "</div></li>";
                   $("#chat").append(str);
               }
               else{
            	   str = "<li class='you'>";
                   str += "<div class='entete'>";
                   str += "<img src='/resources/img/chat/user.png' alt=''>";
                   str += "<h2>"+writer+"</h2></div>";
                   str += "<div class='message'>";
                   str += "<b>" + message+ "</b></div>";
                   str += "<h3>10:12AM, Today</h3></li>";
                   $("#chat").append(str);
               } 
        	   
           }  
       });
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       var  payment = '결제함수~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
       
       
       
       
       
       const $buy = document.getElementById('buy');
       $buy.addEventListener("click", ()=>{
    	   stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: payment, writer: username}));
       });
       
       
       
       
       
      
       
       
       
       
       
       
       

       
       


       //3. send(path, header, message)로 메세지를 보낼 수 있음
       stomp.send('/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
    });
    $(".dm-icon")
    

   $("#button-send").on("click", function(e){
        var msg = document.getElementById("msg");

        console.log(username + ":" + msg.value);
        stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
        msg.value = '';
        $send.firstElementChild.remove();
        image="<img src='/resources/img/chat/buy.png' class='dm-icon' id='buy' alt=''>"
        $send.innerHTML = image;
    });
    $("#msg").on("keydown", function(e) {
        if (e.key === "Enter") {  
            e.preventDefault();

            var msg = document.getElementById("msg");
            

            console.log(username + ":" + msg.value);
            stomp.send('/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
            msg.value = '';

            $send.firstElementChild.remove();
            image = "<img src='/resources/img/chat/buy.png' class='dm-icon' id='buy' alt=''>";
            $send.innerHTML = image;
			
            return false;
        }
    });
    
    
});
</script>
<script type="text/javascript">


$(document).ready(()=>{
    $("#searchUser").on("keydown",(e)=>{
        if(e.key === "Enter"){
            e.preventDefault();
            let findUserName = e.target.value;
            e.target.value='';
            console.log(findUserName);
            var $userPlusButton =document.getElementById('userPlusButton');
            
            $.ajax({
				url:'./findUserName',
				type: 'POST',
				data: findUserName,
				contentType: "application/json",
				success:(response)=>{
					console.log(response);
					if(response == 'find'){
		                UserSearchButton = "<button type='button' class='plusUser' id='plusUser'>";
		                UserSearchButton += "<img src='/resources/img/chat/plus.png' class='plus' src=''>";
		                UserSearchButton += "</button>";
		                $("#userPlusButton").append(UserSearchButton);
					}
					else{
						alert("이름을 확인해 주세요.");
						if($userPlusButton.firstChild){
		                	$userPlusButton.removeChild($userPlusButton.firstChild);
		                console.log('false');
		                }

					}
				},error:(data)=>{
					alert(data);
				}
			});
            

            return false;
        }
    });
    
});

</script>

<body>
	<div class="container" style="background-color: #eff3f7;">
		<aside>
		
			<header>
				<div id="userPlusButton"></div>
				<input type="text" id="searchUser" placeholder="search"> 
			</header>

			<ul>
            <!-- 비 접송 중 -->
				<li>
					<img src="/resources/img/chat/user.png" alt="">
					<div>
						<h2>offline user</h2>
						<h3>
							<span class="status orange"></span>
							offline
						</h3>
					</div>
				</li>
            <!-- 접속 중 -->
				<li>
					<img src="/resources/img/chat/user.png" alt="">
					<div>
						<h2>on user</h2>
						<h3>
							<span class="status green"></span>
							online
						</h3>
					</div>
				</li>
			</ul>
		</aside>

		<main>
			<header>
				<img src="/resources/img/chat/user.png" alt="">
				<div>
					<h2>${member.m_name}</h2>
				</div>
			</header>
		
		
			<!-- 메시지 전송 및 받기 -->
			<div class="body" style="vertical-align: bottom">
				<ul id="chat"></ul>
			</div>

			<footer>
			<div id="Buy-Send">
				<button type="button" id="button-send" >
					<img src="/resources/img/chat/buy.png" class="dm-icon" id='buy' alt="">
				</button>
			</div>
				
				<textarea id="msg" placeholder="입력하시오"></textarea>
			</footer>
			
		</main>
	</div>
</body>
</html>

