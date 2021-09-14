<%@page import="com.example.repository.BoardLikeDAO"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.example.domain.AttachVO"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
System.out.println("id :" + id );

//DAO 객체 준비
BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();
//board 테이블에서 전체글 리스트로 가져오기 
List<BoardVO> boardList = boardDAO.getBoards();
MemberDAO memberDAO = MemberDAO.getInstance();
BoardLikeDAO boardLikeDAO = BoardLikeDAO.getInstance();

//아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);
List<AttachVO> attachList;
int count;
String username;
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
    <link rel="stylesheet" href="css/home.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	</head>

<body>
    <jsp:include page="/include/header.jsp" />
    <main class="main">
        <section class="container">
            <article class="friend-list">
                <div class="friend-list__item">
                    <div><img src="images/k1.jpg" alt=""></div>
                    <div>D__Dsg</div>
                </div>
                <div class="friend-list__item">
                    <div><img src="images/profile.jpeg" alt=""></div>
                    <div>Sal__9</div>
                </div>
                <div class="friend-list__item">
                    <div><img src="images/profile.jpeg" alt=""></div>
                    <div>DD2</div>
                </div>
                <div class="friend-list__item">
                    <div><img src="images/profile.jpeg" alt=""></div>
                    <div>Tae_w__w</div>
                </div>
            </article>
            <% for (BoardVO boardVO : boardList) {
            	username = boardVO.getUsername();
            	memberVO = memberDAO.getMemberByUsername(username);
                		%>
                		 <article class="story-list">
                <div class="story-list__item">
                    <div class="sl__item__header">
                    <%
                   	if (memberVO.getProfileImg()==null ) { // 첨부파일이 없으면
                   		%>
                   		<div><img src="/images/profileImg.jpg" alt=""></div>
                   			<%
                   	}else {
                   		%>
                        <div><img src="/member/display.jsp?fileName=<%=memberVO.getProfileImg() %>" alt=""></div>
                        <%
                        } 
                        %>
                        <div><span><%=boardVO.getUsername() %></span><br><%=boardVO.getLocation() %></div>
                        <div><button onclick="popup();"><i class="fas fa-ellipsis-h"></i></button></div>
                    </div>
                    <div class="flex">
                        <div class="carousel">
                            <div class="viewbox">
                                <div class="btn btn-back hidden">
                                    <i class="fas fa-chevron-left left-indicator"></i>
                                </div>
                                <div class="track">
                    <%
                    int num=boardVO.getNum();
                    attachList = attachDAO.getAttachesByBno(num);
                  
					count = 0;
                    for (AttachVO attach : attachList) {
                    	count++;
                    	String fileCallPath = attach.getUploadpath() + "/" + attach.getFilename();
                    	System.out.println(attach.getUploadpath()+"\n"+attach.getFilename());
                    	%>
                    	<div id="sl__item__img" class="slide active">
                        	<img class="images" src="/board/display.jsp?fileName=<%=fileCallPath %>" alt="">
                    	</div>
                    	<%
                    }
                    	%>
                    	</div>
                    	<%if(count>1){ %>
                                <div class="btn btn-next">
                                    <i class="fas fa-chevron-right right-indicator"></i>
                                </div>
                                <%} %>
                            </div>
                        </div>
                    </div>
                    	<div class="sl__item__contents">
                        <div class="sl__item__contents__icon">
                        <%memberVO=memberDAO.getMemberById(id); %>
                        	<input type="hidden" value="<%=memberVO.getUsername() %>">
                        	<input type="hidden" value="<%=boardVO.getNum()%>">
                        	<%if(boardLikeDAO.getLike(boardVO.getNum(), memberVO.getUsername())==0){ %>
                            	<button type="button" id="btn<%=boardVO.getNum() %>" onclick="like(<%=boardVO.getNum()%>);" class="btn-like"><i class="far fa-heart"></i></button>
                            <%} else { %>
                            	<button type="button" id="btn<%=boardVO.getNum() %>" onclick="like(<%=boardVO.getNum()%>);" class="btn-like"><i class="fas fa-heart" style="color: red;"></i></button>
                            	<%} %>	  
                            <button><i class="far fa-comment"></i></button>
                            <button><i class="far fa-paper-plane"></i></button>
                            <div class="nav-indicator">
                            <%if(count>1){ %>
                                <div class="dot active"></div>
                            <%for(int i=0; i<count-1;i++){ %>    
                                <div class="dot"></div>
                                <%}
                                }%>
                            </div>
                            <button><i class="far fa-bookmark"></i></button>
                        </div>
                        <div class="sl__item__contents__content">
                        <%if(boardVO.getLikecount()>0){ %>
                            <P id="likecount<%=boardVO.getNum()%>">좋아요 <%=boardVO.getLikecount() %>개</P>
                            <% } else { %>
      							<P id="likecount<%=boardVO.getNum()%>"></P>
                            <%} %>
                            <p><span><%=boardVO.getUsername()%></span>  <%=boardVO.getContent() %></p>
                            <button>댓글 123개 모두 보기</button>
                            <ul class="comment">
                                <li><span>아이디</span>댓글댓글댓글댓글 <button><i class="far fa-heart"></i></button></li>
                                <li><span>아이디</span>댓글댓글댓글댓글 <button><i class="far fa-heart"></i></button></li>
                            </ul>
                            <div class="sl__item__contents__timeline">2일 전</div>
                        </div>
                    </div>
                    <div class="sl__item__input">
                        <input type="text" placeholder="댓글 달기...">
                        <button>게시</button>
                    </div>
                </div>
                    	<%
            }
                    %>
                    
             
            </article>
        </section>
    </main>
    <div class="modal-container">
        <div class="modal">
            <button>신고</button>
            <button>팔로우 취소</button>
            <button>게시물로 이동</button>
            <button>Share to...</button>
            <button>링크복사</button>
            <button>퍼가기</button>
            <button id="cancel" onclick="closePopup()">취소</button>
        </div>
    </div>
    <div class="modal-heart">
        <div class="follow">
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
            <div class="follow__item">
                <div class="follow__img"><img src="images/profile.jpeg" alt=""></div>
                <div class="follow__text">
                    <h2>아이디</h2>
                    <p>님이 회원을 팔로우하기 시작했습니다. <span>2주</span></p>
                </div>
                <div class="follow__btn"><button>팔로우</button></div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/gsap/2.1.3/TimelineMax.min.js'></script>
	<script src='https://cdnjs.cloudflare.com/ajax/libs/gsap/2.1.3/TweenMax.min.js'></script>
	<script src="/js/slide.js"></script>
	<script src="/js/jquery-3.6.0.js"></script>
    <script>
    
   
    function like(num){
    	var $i = $('#btn'+num).children();
    	var bno = $('#btn'+num).prev().val();
    	var username = $('#btn'+num).prev().prev().val();
    	console.log(bno);
    	console.log(username);
    	if($i.hasClass("far fa-heart") === true){
    		$i.removeClass('far fa-heart').addClass('fas fa-heart');
    		$i.css('color', 'red');
    	}else{
    		$i.removeClass('fas fa-heart').addClass('far fa-heart');
    		$i.css('color', 'black');
    	}
    	var $p = $('#likecount'+num);
    	console.log($p);

        $.ajax({
    		url : '/api/boardLike/' + bno+'/'+username,
    		method : 'POST',
    		success : function(data) {
    			console.log(data.likecount);
    			
    			if(data.likecount>0)
    				$p.html('좋아요 '+data.likecount+'개');
    			else
    				$p.html('');

    			
    		} // success
    	});
    }
    
    
    
    
    
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
    <script src="/js/follow.js"></script>
</body>

</html>