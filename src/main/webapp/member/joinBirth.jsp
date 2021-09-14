<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="memberVO" class="com.example.domain.MemberVO"/>

<%-- 사용자 입력값 가져오기 -> MemberVO 객체에 저장하기 --%>
<jsp:setProperty property="*" name="memberVO"/>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인ㆍInstagram</title>
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
                    	<div class="img">
                        <h1><img src="/images/cake.png"></h1>
                        </div>
                        <h4>생일 추가</h4>
                        <p>공개프로필에 포함되지 않습니다.</p>
                        <button onclick="popup();">왜 생일정보를 입력해야 하나요?</button>
                        <form action="/member/joinAgree.jsp" method="post">
                        	<input type="hidden" name="id" value="<%=memberVO.getId() %>">
                            <input type="hidden" name="name" value="<%=memberVO.getName() %>">
                            <input type="hidden" name="username" value="<%=memberVO.getUsername() %>">
                            <input type="hidden" name="passwd" value="<%=memberVO.getPasswd() %>">
                        <div class="login__select">
                            <select name="mm" id="month"></select>
                            <select name="dd" id="day"></select>
                            <select name="yy" id="year"></select>
                        </div>
                        <div class="login__birth">
                        	<p class="sign-birth">태어난 날짜를 입력해야 합니다.</p>
                        	<p class="sign-birth">비즈니스나 반려동물 등을 위한 계정인 경우에도 회원<br>님의 생일 정보를 사용하세요.</p>
                        </div>
                        <div class="login__input">
                            <button type="submit">다음</button>
                        </div>
						</form>
						<a href="/member/Sign.jsp">돌아가기</a>
                       
                            
        
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
    <div class="modal-container">
        <div class="modal">
        	<div class="title">
        	<h4>생일</h4><button onclick="closePopup()"><span class="material-icons">close</span></button>
        	</div>
        	<div class="img">
            <h1><img src="/images/cake.png"></h1>
            </div>
            <h3>Instagram에 표시되는 생일</h3>
            <p>생일을 입력하면 기능과 회원님에게 표시되는 광고<br>
            가 개선되며 Instagram 커뮤니티를 안전하게 유지하<br>
            는 데 도움이 됩니다. 입력한 생일은 개인 정보 계정
            <br>설정에서 확인할 수 있습니다.</p>
            <a href="https://help.instagram.com/155833707900388">더 알아보기</a>
        </div>
    </div>
    <script src="/js/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script>
    $(document).ready(function(){ 
    	var now = new Date(); 
    	var year = now.getFullYear(); 
    	var mon = (now.getMonth() + 1) > 9 ? ''+(now.getMonth() + 1) : '0'+(now.getMonth() + 1); 
    	var day = (now.getDate()) > 9 ? ''+(now.getDate()) : '0'+(now.getDate()); //년도 selectbox만들기 
    	for(var i = year ; i > year-103 ; i--) { 
    		$('#year').append('<option value="' + i + '">' + i + '</option>'); 
    		} // 월별 selectbox 만들기 
    	for(var i=1; i <= 12; i++) { 
    		var mm = i > 9 ? i : "0"+i ; $('#month').append('<option value="' + mm + '">' + mm + '월</option>'); 
    		} // 일별 selectbox 만들기 
    	for(var i=1; i <= 31; i++) { 
    		var dd = i > 9 ? i : "0"+i ; $('#day').append('<option value="' + dd + '">' + dd+ '</option>'); 
    		} 
    	$("#year > option[value="+year+"]").attr("selected", "true");
    	$("#month > option[value="+mon+"]").attr("selected", "true");
    	$("#day > option[value="+day+"]").attr("selected", "true");
    	});
    
    
    function popup() {
        document.querySelector('.modal-container').style.display = "flex";
    }
    function closePopup() {
        document.querySelector('.modal-container').style.display = "none";
    }
    document.querySelector('.modal-container').addEventListener('click', (e) => {
        if (e.target.tagName === "DIV") {
            document.querySelector('.modal-container').style.display = "none";
        }
    });
    </script>
</body>

</html>