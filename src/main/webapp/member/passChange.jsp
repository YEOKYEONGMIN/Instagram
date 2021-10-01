<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
String username = (String) session.getAttribute("username");

//DAO 객체 준비
MemberDAO memberDAO = MemberDAO.getInstance();

//아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);


%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="../img/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="/css/passChange.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

</head>

<body>
   
	<header class="header">
		<div class="container">
			<a href="" class="logo"><img src="/images/logo.png" alt=""></a>
			<div class="input-search">
			<input type="text" placeholder="검색">
		</div>
		<nav class="navi">
			<ul class="navi-list">
				<li class="navi-item"><a href="/home.jsp"><i
						class="fas fa-home"></i></a></li>
				<li class="navi-item"><a href="/message/message.jsp"><i
						class="far fa-paper-plane"></i></a></li>
				<li class="navi-item"><a href="/popular.jsp"><i
						class="far fa-compass"></i></a></li>
				<li class="navi-item"><a href="" id="followBtn"><i
						class="far fa-heart"></i></a></li>
				<li class="navi-item" id="profile"><a href="#"><span
						class="my-account"><img src="/images/profileImg.jpg"></span></a>
					<ul>
                        <li><a href="/member/profile.jsp"><i class="far fa-user-circle"></i> 프로필</a></li>
                        <li><a href="/member/logout.jsp">로그아웃</a></li>
                    </ul>		
				</li>
			</ul>
		</nav>
		</div>
	</header>
    <main class="main">
        <section class="setting-container">
            <article class="setting__menu">
                <ul>
                    <li><a href="/member/profileSetting.jsp">프로필 편집</a></li>
                    <li><a href="#" class="active">비밀번호 변경</a></li>
                    <li><a href="#">앱 및 웹사이트</a></li>
                    <li><a href="#">이메일 및 SMS</a></li>
                    <li><a href="#">푸시 알림</a></li>
                    <li><a href="#">연락처 관리</a></li>
                    <li><a href="#">공개범위 및 보안</a></li>
                    <li><a href="#">로그인 활동</a></li>
                    <li><a href="#">Instagram에서 보낸 이메일</a></li>
                    <li><a href="/member/withdrawal.jsp">계정 삭제</a></li>
                </ul>
            </article>
            <form id="frm">
            <input type="hidden" name="id" value="<%=memberVO.getId() %>" />
            <article class="setting__content">
                <div class="content-item__01">
                	<%
                   	if (memberVO.getProfileImg()==null ) { // 첨부파일이 없으면
                   		%>
                    <div class="item__img"><img id="img" src="/images/profile.jpeg" /></div>
                    	<%
                   	}else {
                   		%>
                   	<div class="item__img"><img id="img" src="/member/display.jsp?fileName=<%=memberVO.getProfileImg() %>"></div>
                   	<%
                   	}
                   	%>
                    <div class="item__btn">
                        <h2><%=memberVO.getUsername() %></h2>
                    </div>
                </div>
                <div class="content-item__02">
                    <div class="item__title">이전 비밀번호</div>
                    <div class="item__input">
                        <input type="password" name="oldPasswd" />
                    </div>
                </div>
                <div class="content-item__03">
                    <div class="item__title">새 비밀번호</div>
                    <div class="item__input">
                        <input type="password" name="passwd"  id="passwd" />
                    </div>
                </div>
                <div class="content-item__04">
                    <div class="item__title">새 비밀번호 확인</div>
                    <div class="item__input">
                        <input type="password" name="newPasswdChk" id="newPasswdChk" />
                    </div>
                </div>
                <div class="content-item__11">
                    <div class="item__title"></div>
                    <div class="item__input">
                        <button type="button" id="btn">비밀변호 변경</button>
                    </div>
                </div>
              	 <div class="content-item__11">
                    <div class="item__title"></div>
                    <div class="item__input">
                        <a href="">비밀번호를 잊으셨나요?</a>
                    </div>
                </div>
            </article>
             </form>
        </section>
    </main>
    <footer>
        <div class="container">
            <ul>
                <li><a href="#a">소개</a></li>
                <li><a href="#a">블로그</a></li>
                <li><a href="#a">채용 정보</a></li>
                <li><a href="#a">도움말</a></li>
                <li><a href="#a">API</a></li>
                <li><a href="#a">개인정보처리방침</a></li>
                <li><a href="#a">약관</a></li>
                <li><a href="#a">인기 계정</a></li>
                <li><a href="#a">해시태그</a></li>
                <li><a href="#a">위치</a></li>
            </ul>
            <div class="copy">
                <select name="" id="">
                    <option value="">한국어</option>
                </select>
                <p>© 2020 Instagram from Facebook</p>
            </div>
        </div>
    </footer>
    <div class="modal-heart">
        <div class="follow">
            <div class="follow__item">
                <div class="follow__img"><img src="/images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="/images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="/images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="/images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="/images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
        </div>
    </div>
    <script src="/js/jquery-3.6.0.js"></script>
    <script src="/js/jquery.serializeObject.min.js"></script>
    <script src="/js/follow.js"></script>
    <script>
    $('#profile').on('click',function(){
    	$ul = $('#profile').children();
    	if($ul.hasClass('drop')===true){
    		$ul.removeClass('drop')
    	}else{
    		$ul.addClass('drop');
    	}
    });
    
    $('#btn').on('click', function () {

    	
    	var pass = $('#passwd').val();
    	var passChk = $('#newPasswdChk').val();
    	console.log(pass);
    	console.log(passChk);
		
    	if(pass != passChk){
    		alert("두 비밀번호가 일치하는지 확인하세요.");
    		return;
    	}
    	
    	
    	var obj = $('form#frm').serializeObject();
		console.log(obj);
		console.log(typeof obj);
		var strJson = JSON.stringify(obj);
		console.log(strJson);
		console.log(typeof strJson);
		
		
		
		// ajax 함수 호출
		$.ajax({
			url: '/api/members/pass',
			method: 'PUT',
			data: strJson,
			contentType: 'application/json; charset=UTF-8',
			success: function (data) {
				console.log(data);
				if(data.BpassChk){
					alert("비밀번호 변경성공");
					location.href = '/member/profile.jsp';
				}
				else{
					alert("이전 비밀번호가 잘못 입력되었습니다. 다시 입력해주세요.");
				}
				
			}
		});
		
	});
    </script>
</body>
	
</html>