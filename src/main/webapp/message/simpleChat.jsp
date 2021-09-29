<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
System.out.println("id :" + id );

MemberDAO memberDAO = MemberDAO.getInstance();
MemberVO memberVO = memberDAO.getMemberById(id);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="../img/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="/css/message2.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

</head>
<style>
div#chatBox{
	width: 583px;
	height: 500px;
	padding: 20px 10px;
	overflow: auto;
}

</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
    <main class="main">
        <section class="message__container">
            <article class="message">
                <div class="message__friendlist">
                    <div class="my__id">
                        <div class="id__btn">
                            <button>myAccount <i class="fas fa-chevron-down"></i></button>
                        </div>
                        <div class="write__btn">
                            <button><i class="far fa-edit"></i></button>
                        </div>
                    </div>
                    <div class="friend__id">
                        <ul class="friend__id__list">
                            <li>
                                <div class="friend__profile"><img src="/images/profileImg.jpg" alt=""></div>
                                <div class="friend__state">
                                    <p>이름</p>
                                    <p>상태메세지</p>
                                </div>
                            </li>
                            <li>
                                <div class="friend__profile"><img src="/images/profileImg.jpg" alt=""></div>
                                <div class="friend__state">
                                    <p>이름</p>
                                    <p>상태메세지</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="message__view">
                    <div class="message__list">
                        <div class="start">
                     		<input type="hidden" id="nickname" value="<%=memberVO.getUsername()%>">
							<div id="chat">
								<div id="chatBox"></div>
								<br> <input type="text" id="message" placeholder="채팅글 입력">
								<button type="button" id="btnSend">전송</button>
							</div>
						</div>
                    </div>
                </div>
            </article>
        </section>
    </main>





<script src="/js/jquery-3.6.0.js"></script>
<script>
	var webSocket;
	var nickname;
	$( document ).ready(function() {
		nickname = $('input#nickname').val();
		
		connect(); // 웹소켓 객체생성하여 웹소켓 서버 접속 후 소켓이벤트 연결하기
		addWinEvt(); // beforeunload, unload 이벤트 연겷하기
	});
	
	
	
	function connect(){
		var url = 'ws://' + location.host + '/simpleChat'
		console.log('url : ' + url);
		
		// 웹소켓 서버에 연결하기
		webSocket = new WebSocket(url);
		
		// 소켓이벤트 연결하기 (총 4가지: open, message, close, error)
		webSocket.onopen = onOpen; // 서버에 연결된 후 호출됨
		webSocket.onclose = onClose; // 서버와 연결이 끊긴 후 호출됨 
		webSocket.onmessage = onMessage; // 서버로부터 메시지를 받으면 호출됨
	} // connect
	
	function onOpen(event){
		webSocket.send(nickname + "님이 입장하였습니다.")
		scrollDown();
		
		$('div#first').css('display', 'none');
		$('div#chat').css('display', 'block')
	} // onOpen
	function onClose(event){
		$('div#chatBox').append('<div class="chat-message">채팅방과 연결이 끊어졌습니다.</div>');
		 
		scrollDown();
	} // onClose
	function onMessage(event){
		console.log(typeof event.data);
		
		var str = event.data;
		$('div#chatBox').append(`<div class="chat-message">\${str}</div>`);
		
		scrollDown();
	} // onMessage
	
	// 채팅방 연결끊기 버튼 클릭시
	$('#btnDisconnect').on('click', function(){
		disconnect();
		
	});
	
	function disconnect(){
		if(webSocket == null){
			return;
		}
		
		webSocket.send(nickname + " 님이 퇴장하였습니다.");
		scrollDown();
		
		webSocket.close();
		webSocket = null;
		
		$(this).prop('disabled', true);
		$('#btnSend').prop('disabled', true);
	}
	
	
	$('#btnSend').on('click', function(){
		send();	
	});
	
	$('input#message').on('keyup', function(event){
		if(event.keyCode == 13){ // 엔터키를 누르면
			send();
		}
	});
	
	// 채팅내용을 서버에 전송하기
	function send(){
		var str = $('input#message').val();
		
		webSocket.send(nickname + ' : ' + str);
		
		$('input#message').val('');
		$('input#message').focus();
	} // send
	
	
	// 채팅스크롤바를 하단으로 이동시키기
	function scrollDown() {
		var scrollHeight = $('div#chatBox')[0].scrollHeight;
		$('div#chatBox').scrollTop(scrollHeight);
	}
	
	// beforeunload, unload 이벤트 연결
	function addWinEvt(){
		// 브라우저에 현재 화면이 unload 되기 이전에 발생되는 이벤트
		window.addEventListener('beforeunload', function(event){
			var dialogText = 'Dialog text here';
			// 크롬은 이벤트 객체에 returnValue 속성에 텍스트값 설정이 필요함
			event.returnValue = dialogText;
			return dialogText;
		});
		// 브라우저에 기존 화면이 다른 화면으로 완전히 unload 되면 발생되는 이벤트
		window.addEventListener('unload', function(){
			disconnect();
		});
	}
	
     $('#profile').on('click',function(){
    	$ul = $('#profile').children();
    	if($ul.hasClass('drop')===true){
    		$ul.removeClass('drop')
    	}else{
    		$ul.addClass('drop');
    	}
    });
   
</script>
</body>
</html>