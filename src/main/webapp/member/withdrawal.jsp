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
    <link rel="stylesheet" href="/css/withdrawal.css">
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
                    <li><a href="/member/passChange.jsp">비밀번호 변경</a></li>
                    <li><a href="#">앱 및 웹사이트</a></li>
                    <li><a href="#">이메일 및 SMS</a></li>
                    <li><a href="#">푸시 알림</a></li>
                    <li><a href="#">연락처 관리</a></li>
                    <li><a href="#">공개범위 및 보안</a></li>
                    <li><a href="#">로그인 활동</a></li>
                    <li><a href="#">Instagram에서 보낸 이메일</a></li>
                    <li><a href="#" class="active">계정 삭제</a></li>
                </ul>
            </article>
            <form id="frm">
            <input type="hidden" id="id" name="id" value="<%=memberVO.getId() %>" />
            <input type="hidden" id="pass" name="pass" value="<%=memberVO.getPasswd() %>" />
            <article class="setting__content">
                <div class="content-item__01">
                    <div class="item__btn">
                        <h2>계정 삭제</h2>
                    </div>
                </div>
                <div class="content-item__02">
                    <div class="item__input">
                        잠시 Instagram 활동을 쉬고 싶으시다면 계정을 삭제하는 대신 일시적으로 비활성화할 수 있습니다. Instagram 활동을 쉬는 동안에는 회원님의 프로필이 Instagram에 표시되지 않습니다.
                    </div>
                </div>
             
                <div class="content-item__03">
                    <div class="item__input">
                    	기본 계정이 삭제되는 것을 막기 위해 보조 계정으로 로그인했는지 확인해주세요. 현재 <span><%=memberVO.getUsername() %></span>(으)로 로그인한 상태입니다. 이 계정이 아닌 경우에는 먼저 로그아웃한 뒤 올바른 계정으로 로그인하세요.
                    </div>
                </div>
                <div class="content-item__04">
                    <div class="item__title">비밀번호를 다시 입력하세요</div>
                    <div class="item__input">
                        <input type="password" name="passwd" id="passwd" />
                    </div>
                </div>
                <div class="content-item__11">
                    <div class="item__input">
                        <a href="">비밀번호를 잊으셨나요?</a>
                    </div>
                </div>
                <div class="content-item__11">
                    
                    <div class="item__input">
                        <button type="button" id="btn"><%=memberVO.getUsername() %> 삭제</button>
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
		var id = $('#id').val();
		var pass = $('#pass').val();
		var passwd = $('#passwd').val();
		console.log(pass);
		console.log(passwd);
		if(pass==passwd){
		 if (!confirm("계정을 삭제하시겠습니까?.")) {
		        return;
		    } else {
		    	$.ajax({
					url: '/api/members/' + id,
					method: 'DELETE',
					success: function (data) {
						console.log(data.member);
						
						if(data.isDeleted){
							location.href = '/index.jsp';
							
						}
					}
				});	// ajax 함수 호출
		    }
		}else{
			alert("비밀번호가 잘못 입력되었습니다. 다시 입력해주세요.");
		}
	});
    </script>
</body>
	
</html>