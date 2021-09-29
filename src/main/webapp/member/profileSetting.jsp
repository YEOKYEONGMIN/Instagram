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
    <link rel="stylesheet" href="/css/profileSetting.css">
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
				<li class="navi-item"><a href="/message.jsp"><i
						class="far fa-paper-plane"></i></a></li>
				<li class="navi-item"><a href="/popular.jsp"><i
						class="far fa-compass"></i></a></li>
				<li class="navi-item"><a href="" id="followBtn"><i
						class="far fa-heart"></i></a></li>
				<li class="navi-item"><a href="/member/profile.jsp"><span
						class="my-account"><img src="/images/profileImg.jpg"></span></a></li>
			</ul>
		</nav>
		</div>
	</header>
    <main class="main">
        <section class="setting-container">
            <article class="setting__menu">
                <ul>
                    <li><a href="#" class="active">프로필 편집</a></li>
                    <li><a href="/member/passChange.jsp">비밀번호 변경</a></li>
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
            <form id="frm" enctype="multipart/form-data">
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
                        <div class="filebox">
                        <label for="profileImg">프로필 사진 바꾸기</label>
                        <input type="file"  id="profileImg" class="profileImg" name="profileImg" accept="image/jpeg, image/jpg, image/png"  "/>
                        </div>
                    </div>
                </div>
                <div class="content-item__02">
                    <div class="item__title">이름</div>
                    <div class="item__input">
                        <input type="text" name="name" value="<%=memberVO.getName() %>" />
                        <span>사람들이 이름, 별명 또는 비즈니스 이름 등 회원님의 알려진 이름을 사용하여 회원님의 계정을 찾을 수 있도록 도와주세요.</span>
                        <span>이름은 14일 안에 두 번만 변경할 수 있습니다.</span>
                    </div>
                </div>
                <div class="content-item__03">
                    <div class="item__title">사용자 이름</div>
                    <div class="item__input">
                        <input type="text" name="username" value="<%=memberVO.getUsername() %>"  />
                        <span>대부분의 경우 14일 이내에 사용자 이름을 다시 <%=username %>(으)로 변경할 수 있습니다. <a href="">더 알아보기</a></span>
                    </div>
                </div>
                <div class="content-item__04">
                    <div class="item__title">웹사이트</div>
                    <div class="item__input">
                        <input type="text" name="web" value="<%=memberVO.getWeb() %>" placeholder="웹 사이트" />
                    </div>
                </div>
                <div class="content-item__05">
                    <div class="item__title">소개</div>
                    <div class="item__input">
                        <textarea name="memo" id="" rows="3" ><%=memberVO.getMemo() %></textarea>
                    </div>
                </div>
                <div class="content-item__06">
                    <div class="item__title"></div>
                    <div class="item__input">
                        <span><b>개인정보</b></span>
                        <span>비즈니스나 반려동물 등에 사용된 계정인 경우에도 회원님의 개인 정보를 입력하세요. 공개 프로필에는 포함되지 않습니다.</span>
                    </div>
                </div>
                <div class="content-item__07">
                    <div class="item__title">이메일</div>
                    <div class="item__input">
                        <input type="text" name="email" value="<%=memberVO.getEmail() %>" placeholder="이메일"  />
                    </div>
                </div>
                <div class="content-item__08">
                    <div class="item__title">전화번호</div>
                    <div class="item__input">
                        <input type="text" name="phone" value="<%=memberVO.getPhone() %>" placeholder="전화번호" />
                    </div>
                </div>
                <div class="content-item__09">
                    <div class="item__title">성별</div>
                    <div class="item__input">
                        <input type="text" name="gender" />
                    </div>
                </div>
                <div class="content-item__10">
                    <div class="item__title">비슷한 계정 추천</div>
                    <div class="item__input">
                        <input type="checkbox" name="check" />
                        <span>팔로우할 만한 비슷한 계정을 추천할 때 회원님의 계정을 포함합니다. <a href="">[?]</a></span>
                    </div>
                </div>
                <div class="content-item__11">
                    <div class="item__title"></div>
                    <div class="item__input">
                        <button type="button" id="btn">제출</button><a href="">계정을 일시적으로 비활성화</a>
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
    function readImage(input) {
        // 인풋 태그에 파일이 있는 경우
        if(input.files && input.files[0]) {
            
            // FileReader 인스턴스 생성
            const reader = new FileReader()
            // 이미지가 로드가 된 경우
            reader.onload = e => {
                const previewImage = document.getElementById("img")
                previewImage.src = e.target.result
            }
            // reader가 이미지 읽도록 하기
            reader.readAsDataURL(input.files[0])
        }
    }
    // input file에 change 이벤트 부여
    const inputImage = document.getElementById("profileImg")
    inputImage.addEventListener("change", e => {
        readImage(e.target)
    })
    
    
    $('#btn').on('click', function () {
		

		var id = $('input[name="id"]').val();
		
		var form = $('form#frm')[0];
		//console.log(form);
		//console.log(typeof form);
		
		var formData = new FormData(form); // 쿼리스트링으로 넘겨줌
		console.log(formData);
		console.log(typeof formData);
		
		
		// ajax 함수 호출
		$.ajax({
			url: '/api/members/'+id,
			method: 'PUT',
			data: formData,
			processData: false, // 파일전송시 false 설정 필수!
			contentType: false, // 파일전송시 false 설정 필수!
			success: function (data) {
				console.log(data);
				
				alert(data.result);
				location.href = '/member/profile.jsp';
			}
		});
		
	});
    </script>
</body>
	
</html>