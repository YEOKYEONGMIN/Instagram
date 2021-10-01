<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="/images/insta.svg">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
</head>

<body>
    <div class="container">
        <main>
            <section class="login">

                <article class="login__form__container">
                    <div class="login__form">
                        <h1><img src="/images/logo.png" alt=""></h1>
                        <p>친구들의 사진과 동영상을 보려면<br>
                            가입하세요
                        </p>
                        <button class="cta blue"><i class="fab fa-facebook-square"></i> Facebook으로 로그인</button>
                        <form action="/member/joinBirth.jsp" method="POST">
                        <div class="login__horizon">
                            <div class="br"></div>
                            <div class="or">또는</div>
                            <div class="br"></div>
                        </div>
                        <div class="login__input">
                        	<div class="line">
                        	<input type="text" name="id"  id="id" placeholder="휴대폰 번호 또는 이메일 주소">
                          	<span id="spanId" class="material-icons"></span>
                            </div>
                            <div class="line">
                            <input type="text" name="name" id="name" placeholder="성명">
                            <span id="spanName" class="material-icons"></span>
                            </div>
                            <div class="line">
                            <input type="text" name="username" id="username" placeholder="사용자이름">
                            <span id="spanUname" class="material-icons"></span>
                            </div>
                            <div class="line">
                            <input type="password" name="passwd" id="passwd" placeholder="비밀번호">
                            <span id="spanPass" class="material-icons"></span>
                            </div>
                            <div class="login__button">
                            <button id="btn" type="submit" disabled="disabled">가입</button>
                            </div>
                        </div>
						</form>
                        <div class="login__facebook">
                            <p class="sign-detail">
                                가입하면 Instagram의 약관,데이터 정책 및 쿠키<br>
                                정책에 동의하게 됩니다
                            </p>
                        </div>
                    </div>
                    <div class="login__register">
                        <span>계정이 있으신가요?</span>
                        <a href="/index.jsp">로그인</a>
                    </div>
                    <div class="login__download">
                        <p>앱을 다운로드하세요.</p>
                        <div class="download__btn">
                            <button><img src="/images/appstore.png" alt=""></button>
                            <button><img src="/images/google.png" alt=""></button>
                        </div>
                    </div>
                </article>
            </section>
        </main>
        <footer>
            <nav class="footer__menu">
                <ul>
                    <li><a href="#">소개</a></li>
                    <li><a href="#">블로그</a></li>
                    <li><a href="#">채용 정보</a></li>
                    <li><a href="#">도움말</a></li>
                    <li><a href="#">API</a></li>
                    <li><a href="#">개인정보처리방침</a></li>
                    <li><a href="#">약관</a></li>
                    <li><a href="#">인기 계정</a></li>
                    <li><a href="#">해시태그</a></li>
                    <li><a href="#">위치</a></li>
                </ul>
                <span class="footer__copy">© 2021 Instagram from Facebook</span>
            </nav>
        </footer>
    </div>
    <script src="/js/jquery-3.6.0.js"></script>
    <script src="/js/jquery.serializeObject.min.js"></script>
	<script>
		var spanid = document.getElementById("spanId");
		var spanname = document.getElementById("spanName");
		var spanuname = document.getElementById("spanUname");
		var spanpass = document.getElementById("spanPass");
		var btn = document.getElementById("btn");
		var pass;
		$('input#id').on('focusout', function() {
			pass = $('input#passwd').val();
			var id = $(this).val();
			var $span = $(this).next();
			if (id.length == 0) {
				$span.html('');
				$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
				return;
			}
			// ajax 함수 호출
			$.ajax({
				url : '/api/members/' + id,
				method : 'GET',
				success : function(data) {
					console.log(data);
					console.log(typeof data);

					if (data.idCount == 0) {
						$span.html('check_circle_outline').css('color', 'gray');
					} else { // data.count == 1
						$span.html('highlight_off').css('color', 'red');
					}
					if($('#spanId').html()=='check_circle_outline'&&$('#spanName').html()=='check_circle_outline'&&
							$('#spanUname').html()=='check_circle_outline'&&$('#spanPass').html()=='check_circle_outline'&&
							pass.length>=4){
						 $('#btn').css('background-color','#0095F6');
				    	    btn.disabled = false;
					}else{
						$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
		        		btn.disabled = true;
					}
				} // success
			});
			
		});
		$('input#name').on('focusout', function() {
			pass = $('input#passwd').val();
			var name = $(this).val();
			var $span = $(this).next();
			if (name.length == 0) {
				$span.html('');
				$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
				return;
			}
			
			$span.html('check_circle_outline').css('color', 'gray');
			if($('#spanId').html()=='check_circle_outline'&&$('#spanName').html()=='check_circle_outline'&&
					$('#spanUname').html()=='check_circle_outline'&&$('#spanPass').html()=='check_circle_outline'&&
					pass.length>=4){
				 $('#btn').css('background-color','#0095F6');
		    	    btn.disabled = false;
			}else{
				$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
			}
		});
		
		$('input#username').on('focusout', function() {
			pass = $('input#passwd').val();
			var username = $(this).val();
			var $span = $(this).next();

			if (username.length == 0) {
				$span.html('');
				$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
				return;
			}

			// ajax 함수 호출
			$.ajax({
				url : '/api/members/' + username,
				method : 'GET',
				success : function(data) {
					console.log(data);
					console.log(typeof data);

					if (data.usernameCount == 0) {
						$span.html('check_circle_outline').css('color', 'gray');
					} else { // data.count == 1
						$span.html('highlight_off').css('color', 'red');
					}
					if($('#spanId').html()=='check_circle_outline'&&$('#spanName').html()=='check_circle_outline'&&
							$('#spanUname').html()=='check_circle_outline'&&$('#spanPass').html()=='check_circle_outline'&&
							pass.length>=4){
						 $('#btn').css('background-color','#0095F6');
				    	    btn.disabled = false;
					}else{
						$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
		        		btn.disabled = true;
					}
				} // success
			});
		});
		$('input#passwd').on('focusout', function() {
			pass = $('input#passwd').val();
			var passwd = $(this).val();
			console.log(passwd);
			console.log(pass);
			var $span = $(this).next();
			if (passwd.length == 0) {
				$span.html(' ');
				return;
			}
		
			$span.html('check_circle_outline').css('color', 'gray');
			if($('#spanId').html()=='check_circle_outline'&&$('#spanName').html()=='check_circle_outline'&&
					$('#spanUname').html()=='check_circle_outline'&&$('#spanPass').html()=='check_circle_outline'&&
					pass.length>=4){
				 $('#btn').css('background-color','#0095F6');
		    	    btn.disabled = false;
			}else{
				$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
			}
		
			
		});
		

		
			
		
	</script>
</body>

</html>