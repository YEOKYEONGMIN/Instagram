<%@page import="java.io.Console"%>
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
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
</head>

<body>
	<div class="container">
		<main>
			<section class="login">
				<article class="login__img">
					<img src="images/img01.jpg" alt="">
				</article>

				<article class="login__form__container">
					<form id="frm">
						<div class="login__form">
							<h1>
								<img src="images/logo.png" alt="">
							</h1>
							<div class="login__input">
								<input type="text" name="id" id="id"
									placeholder="전화번호, 사용자 이름 또는 이메일"> <input
									type="password" name="passwd" id="passwd" placeholder="비밀번호">
								<button id="btn" type="button" disabled="disabled">로그인</button>
							</div>
							<div class="login__horizon">
								<div class="br"></div>
								<div class="or">또는</div>
								<div class="br"></div>
							</div>
							<div class="login__facebook">
								<button id="btn2">
									<i class="fab fa-facebook-square"></i> <span>Facebook으로
										로그인</span>
								</button>
								<p id="p"></p>
							</div>
							<a href="#" class="loin__forgetpassword">비밀번호를 잊으셨나요?</a>
						</div>
					</form>
					<div class="login__register">
						<span>계정이 없으신가요?</span> <a href="/member/Sign.jsp">가입하기</a>
					</div>
					<div class="login__download">
						<p>앱을 다운로드하세요.</p>
						<div class="download__btn">
							<button>
								<img src="images/appstore.png" alt="">
							</button>
							<button>
								<img src="images/google.png" alt="">
							</button>
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
    var btn = document.getElementById("btn");
    var pass,id;
    var p = $('#btn2').next();
    $('#btn').on('click', function () {
    	
    		var obj = $('form#frm').serializeObject();
    		console.log(obj);
    		console.log(typeof obj);
    		var strJson = JSON.stringify(obj);
    		console.log(strJson);
    		console.log(typeof strJson);
    		var id = $('input#id').val();
    		
    		// ajax 함수 호출
    		$.ajax({
    			url: '/api/members',
    			method: 'POST',
    			data: strJson,
    			contentType: 'application/json; charset=UTF-8',
    			success: function (data) {
    				console.log(data);
    				console.log(data.member.id);
    				console.log(data.member.passwd);
    				//alert(data.member);
    				if(data.idChk && data.passChk){
    					
    					console.log('로그인패스 성공');
    					location.href = '/home.jsp';
    				}else if(data.idChk == false){
    					p.html('입력한 사용자 이름을 사용하는 계정을 찾을 수 없습니다. 사용자 이름을 확인하고 다시 시도하세요.').css('color', 'red');
    				}else if(data.passChk == false){
    					p.html('잘못된 비밀번호입니다. 다시 확인하세요.').css('color', 'red');
    				}
    			}
    		});
    		
    	});
    $('input#id').on('keyup', function() {
		pass = $('input#passwd').val();
		var id = $(this).val();
		if (id.length != 0 && pass.length != 0) {
			$('#btn').css('background-color','#0095F6');
	    	btn.disabled = false;
		}else{
			
	    	$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
	    	btn.disabled = true;
			return;
		}
    });
    $('input#passwd').on('keyup', function() {
		id = $('input#id').val();
		var pass = $(this).val();
		if (id.length != 0 && pass.length != 0) {
			$('#btn').css('background-color','#0095F6');
	    	btn.disabled = false;
		}else{
			
	    	$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
	    	btn.disabled = true;
			return;
		}
    });
    </script>
</body>

</html>