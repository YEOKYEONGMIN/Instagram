<%@page import="com.example.domain.ReplyVO"%>
<%@page import="com.example.domain.AttachVO"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.BoardLikeDAO"%>
<%@page import="com.example.repository.ReplyDAO"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
System.out.println("id :" + id );
//DAO 객체 준비
MemberDAO memberDAO = MemberDAO.getInstance();

//아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);

BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();
ReplyDAO replyDAO = ReplyDAO.getInstance();

List<BoardVO> boardList = boardDAO.getBoards(memberVO.getUsername());
AttachVO attachVO = new AttachVO();
ReplyVO replyVO = new ReplyVO();
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="/images/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="/css/profile.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap"
        rel="stylesheet">
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
				<li class="navi-item"><a href="../home.jsp"><i
						class="fas fa-home"></i></a></li>
				<li class="navi-item"><a href="../message.jsp"><i
						class="far fa-paper-plane"></i></a></li>
				<li class="navi-item"><a href="../popular.jsp"><i
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
    <section class="profile">
        <div class="container">
            <div class="profile-left">
                <div class="profile-img-wrap story-border">
                	<%
                   	if (memberVO.getProfileImg()==null ) { // 첨부파일이 없으면
                   		%>
                   <img id="img" src="/images/profileImg.jpg" />
                    	<%
                   	}else {
                   		%>
                   	<img id="img" src="/member/display.jsp?fileName=<%=memberVO.getProfileImg() %>">
                   	<%
                   	}
                   	%>
                    <svg viewbox="0 0 110 110">
                        <circle cx="55" cy="55" r="53" />
                    </svg>
                </div>
            </div>
            <div class="profile-right">
                <div class="name-group">
                    <h2><%=memberVO.getUsername() %></h2>
                    <button class="cta" onclick="location.href='profileSetting.jsp'">프로필 편집</button>
                    <button class=" modi"><i class="fas fa-cog"></i></button>
                    <button class="cta" onclick="location.href='/board/insertBoard.jsp'">게시글쓰기</button>
                </div>
                <div class="follow">
                    <ul>
                        <li><a href="">게시물<span>6</span></a> </li>
                        <li><a href="">팔로워<span>106</span></a> </li>
                        <li><a href="">팔로우<span>102</span></a> </li>
                    </ul>
                </div>
                <div class="state">
                    <h4><%=memberVO.getName() %></h4>
                    <a href="">
                        <p><%=memberVO.getMemo() %></p>
                        <a href="http://<%=memberVO.getWeb() %>" target='_blank'><%=memberVO.getWeb() %></a>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <section class="story">
        <div class="container">
            <div class="story-item">
                <div class="stroy-img">
                    <img src="/images/profile.jpeg" alt="">
                </div>
                <div class="story-name">
                    <p>Culture</p>
                </div>
            </div>
            <div class="story-item">
                <div class="stroy-img">
                    <img src="/images/profile.jpeg" alt="">
                </div>
                <div class="story-name">
                    <p>Cats</p>
                </div>
            </div>
            <div class="story-item">
                <div class="stroy-img">
                    <img src="/images/profile.jpeg" alt="">
                </div>
                <div class="story-name">
                    <p>Resturant</p>
                </div>
            </div>
            <div class="story-item">
                <div class="stroy-img">
                    <img src="/images/profile.jpeg" alt="">
                </div>
                <div class="story-name">
                    <p>Cafe</p>
                </div>
            </div>
        </div>
    </section>


    <div class="gallery">
        <div class="container">
            <div class="controller">
                <ul class="con-list">
                    <li class="tab-item tab-border" id="tab-1"><a href="#a"><i
                                class="fas fa-th"></i><span>게시물</span></a></li>
                    <li class="tab-item" id="tab-2"><a href="#a"><i class="fas fa-tv"></i><span>IGTV</span></a></li>
                    <li class="tab-item" id="tab-3"><a href="#a"><i class="far fa-bookmark"></i><span>저장됨</span></a>
                    </li>
                    <li class="tab-item" id="tab-5"><a href="#a"><i class="fas fa-id-card-alt"></i><span>태그됨</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <section id="tab-content">
        <div class="container">
            <!--Tab1-->
            <div id="tab-1-content" class="tab-content-item show">
                <div class="tab-1-content-inner">
                   
                      <% for (BoardVO boardVO : boardList) {
                    	  int num=boardVO.getNum();
                    	  attachVO = attachDAO.getAttachesByBno2(num);
                    	  String fileCallPath = attachVO.getUploadpath() + "/" + attachVO.getFilename();
                    	  %>
                    	  <div class="img-box">
                    	  <a href="/board/boardContent.jsp?num=<%=num%>"><img src="/board/display.jsp?fileName=<%=fileCallPath %>" alt=""></a>
                        	<div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span><%=boardVO.getLikecount() %></span></a>
                            <a href="#a" class=""><i class="fas fa-comment"></i><span><%=replyDAO.getReplyCount(num) %></span></a>
                        	</div>
                        </div>
                    	  <%} %>
                    
                    
                </div>
            </div>

            <!-- Tab-2 -->
            <div id="tab-2-content" class="tab-content-item">
                <div class="tab-2-content-inner">
                    <span><i class="fas fa-tv"></i></span>
                    <p>동영상 업로드</p>
                    <b>동영상은 길이가 1~60분 사이여야 합니다.</b>
                    <div>
                        <button class="btn-sky">업로드</button>
                    </div>
                </div>
            </div>

            <!-- Tab3 -->
            <div id="tab-3-content" class="tab-content-item">
                <div class="tab-3-content-inner">
                    <span><i class="far fa-bookmark"></i></span>
                    <p>저장</p>
                    <b>다시 보고 싶은 사진과 동영상을 저장하세요. 콘텐츠를 저장해도 다른 사람에게 알림이 전송되지 않으며, 저장된 콘텐츠는 회원님만 볼 수 있습니다.</b>
                </div>
            </div>

            <!-- Tab4 -->
            <div id="tab-5-content" class="tab-content-item">
                <div class="tab-5-content-inner">
                    <div class="img-box">
                        <a href=""><img src="/images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                            <a href="#a" class=""><i class="fas fa-comment"></i><span>10</span></a>
                        </div>
                    </div>
                    <div class="img-box">
                        <a href=""><img src="/images/profile.jpeg" alt=""></a>
                        <div class="comment">
                            <a href="#a" class=""><i class="fas fa-heart"></i><span>36</span></a>
                            <a href="#a" class=""><i class="fas fa-comment"></i><span>10</span></a>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </section>


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
                <div class="lang">
                    <select name="" id="">
                        <option value="">한국어</option>
                    </select>
                </div>
                <div class="copy-right">
                    <p>© 2020 Instagram from Facebook</p>
                </div>
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
    <script defer src="/js/profile.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
    </script>
</body>

</html>