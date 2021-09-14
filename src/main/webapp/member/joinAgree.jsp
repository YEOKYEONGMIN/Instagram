<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberVO" class="com.example.domain.MemberVO"/>

<%-- 사용자 입력값 가져오기 -> MemberVO 객체에 저장하기 --%>
<jsp:setProperty property="*" name="memberVO"/>

<% 
// 생년월일 문자열에서 하이픈(-) 기호 제거하기
String year = request.getParameter("yy");
String month = request.getParameter("mm");
String day = request.getParameter("dd");

String birthday = year+month+day;
birthday.trim(); // 하이픈 문자열을 빈문자열로 대체
memberVO.setBirthday(birthday);

System.out.println(memberVO); // 서버 콘솔 출력
%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인ㆍInstagram</title>
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

                <article class="login__form__container">
                    <div class="login__form">
                    	
                        <h4>이용 약관에 동의</h4>
                        <p>Instagram은 회원님의 개인 정보를 안전하게 보<br>호합니다. 새 계정을 만들려면 모든 약관에 동<br>의하세요.</p>
                        
                        <form id="frm">
                        	<input type="hidden" name="id" value="<%=memberVO.getId() %>">
                            <input type="hidden" name="name" value="<%=memberVO.getName() %>">
                            <input type="hidden" name="username" value="<%=memberVO.getUsername() %>">
                            <input type="hidden" name="passwd" value="<%=memberVO.getPasswd() %>">
                            <input type="hidden" name="birthday" value="<%=memberVO.getBirthday() %>">
							<div class="login__box">
								<div class="login__check">
									<div class="allAgree"><p>이용약관 3개에 모두동의</p></div>
									<div class="chk"><input type="checkbox" id="chkAll"  onclick='selectAll(this)'></div>
								</div>
								<hr>
								<div class="login__check1">
									<div class="left"><p>이용 약관(필수)</p></div>
									<div class="left"><a href="https://help.instagram.com/581066165581870" target='_blank'>더 알아보기</a></div>
									<div class="chk"><input type="checkbox" id="chk1" name="chk"  ></div>
								</div>
								<div class="login__check1">
									<div class="left"><p>데이터 정책(필수)</p></div>
									<div class="left"><a href="https://help.instagram.com/519522125107875" target='_blank'>더 알아보기</a></div>
									<div class="chk"><input type="checkbox" id="chk2" name="chk"></div>
								</div>
								<div class="login__check1">
									<div class="left"><p>위치기반 기능(필수)</p></div>
									<div class="left"><a href="https://help.instagram.com/626057554667531" target='_blank'>더 알아보기</a></div>
									<div class="chk"><input type="checkbox" id="chk3" name="chk"></div>
								</div>
								<div class="login__button">
									<button id="btn" type="button" disabled="disabled">다음</button>
								</div>
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
    <script src="/js/jquery-3.6.0.js"></script>
    <script src="/js/jquery.serializeObject.min.js"></script>
    <script>
    var chk1 = document.getElementById("chk1");
	var chk2 = document.getElementById("chk2");
	var chk3 = document.getElementById("chk3");
	var chkAll = document.getElementById("chkAll");
	var btn = document.getElementById("btn");
    function selectAll(selectAll)  {
    	  const checkboxes 
    	       = document.getElementsByName('chk');
    	  
    	  checkboxes.forEach((checkbox) => {
    	    checkbox.checked = selectAll.checked;
    	    $('#btn').css('background-color','#0095F6');
    	    btn.disabled = false;
    	  })
    	}
    	
    	$(chkAll).on('click',function(){
    		if(chkAll.checked == false){
        		$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
        	}
    	});
    	$(chk1).on('click',function(){
    		if(chk1.checked && chk2.checked && chk3.checked){
        		chkAll.checked = true;
        		$('#btn').css('background-color','#0095F6');
        		btn.disabled = false;
        	}else {
        		chkAll.checked = false;
        		$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
        	}
    	});
    	$(chk2).on('click',function(){
    		if(chk1.checked && chk2.checked && chk3.checked){
        		chkAll.checked = true;
        		$('#btn').css('background-color','#0095F6');
        		btn.disabled = false;
        	}else {
        		chkAll.checked = false;
        		$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
        	}
    	});
    	$(chk3).on('click',function(){
    		if(chk1.checked && chk2.checked && chk3.checked){
        		chkAll.checked = true;
        		$('#btn').css('background-color','#0095F6');
        		btn.disabled = false;
        	}else {
        		chkAll.checked = false;
        		$('#btn').css('background-color','rgba(var(--d69,0,149,246),.3)');
        		btn.disabled = true;
        	}
    	});
    	$('#btn').on('click', function () {
    		

    		var obj = $('form#frm').serializeObject();
    		console.log(obj);
    		console.log(typeof obj);
    		
    		var strJson = JSON.stringify(obj);
    		console.log(strJson);
    		console.log(typeof strJson);
    		
    		
    		// ajax 함수 호출
    		$.ajax({
    			url: '/api/members',
    			method: 'POST',
    			data: strJson,
    			contentType: 'application/json; charset=UTF-8',
    			success: function (data) {
    				console.log(data);
    				
    				alert(data.result);
    				location.href = '/index.jsp';
    			}
    		});
    		
    	});
    </script>
</body>

</html>