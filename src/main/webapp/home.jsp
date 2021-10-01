<%@page import="com.example.repository.ReplyLikeDAO"%>
<%@page import="com.example.repository.ReplyDAO"%>
<%@page import="com.example.domain.ReplyVO"%>
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
ReplyDAO replyDAO = ReplyDAO.getInstance();
//board 테이블에서 전체글 리스트로 가져오기 

MemberDAO memberDAO = MemberDAO.getInstance();
BoardLikeDAO boardLikeDAO = BoardLikeDAO.getInstance();
ReplyLikeDAO replyLikeDAO = ReplyLikeDAO.getInstance();

//아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);
List<BoardVO> boardList = boardDAO.getBoards();
List<ReplyVO> replyList;
List<AttachVO> attachList;
int count;
String username;
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
    <link rel="stylesheet" href="/css/home.css">
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
                        <div><button onclick="popup(<%=boardVO.getNum()%>);"><i class="fas fa-ellipsis-h"></i></button></div>
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
                            <P id="likecount<%=num%>">좋아요 <%=boardVO.getLikecount() %>개</P>
                            <% } else { %>
      							<P id="likecount<%=num%>"></P>
                            <%} %>
                            <p><span><%=boardVO.getUsername()%></span>  <%=boardVO.getContent() %></p>
                            <% if(replyDAO.getReplyCount(num)>2){ %>
                            <button onclick="location.href = '/board/boardContent.jsp?num=<%=num%>';">댓글 <%=replyDAO.getReplyCount(num) %>개 모두 보기</button>
                            <%} %>
                            <ul class="comment">
                            <%replyList = replyDAO.getReply(num);
                           	 int i =0;
                             for(ReplyVO replyVO : replyList){
                            	 %>
                            	 
                            	 <li><span><%=replyVO.getReplyUsername() %></span><%=replyVO.getReplyComment() %>
                            	 <input type="hidden" value="<%=boardVO.getNum() %>">
                            	 <input type="hidden" value="<%=memberVO.getUsername() %>"/>
                            	 <button type="button" id="replylikeBtn<%=replyVO.getNum() %>" onclick="replylike(<%=replyVO.getNum()%>);">
                            	 <%if(replyLikeDAO.getLike(replyVO.getNum(), memberVO.getUsername())==0) {%>
                            	 	<i class="far fa-heart"></i>
                            	 <%}else{%>  
                            	 	<i class="fas fa-heart" style="color: red;"></i>
                            	 	<%} %>
                            	 	</button></li>
                            	 <% i++;
                            	 if(i==2)
                            		 break;
                             }
                            %>
                               
                            </ul>
                            <input type="hidden" id="date<%=num%>" value="<%=boardVO.getRegDate() %>">
                            <div class="sl__item__contents__timeline" id="date<%=num%>">2일 전</div>
                        </div>
                    </div>
                    <form id="frm<%=num%>">
                    <div class="sl__item__input">
						<input type="hidden" name="replyBno" value="<%=num%>">
						<input type="hidden" name="replyUsername" value="<%=memberVO.getUsername() %>" >                 
                        <input type="text" name="replyComment" onkeyup="replyInput(<%=num%>)" id="replyInput<%=num%>"placeholder="댓글 달기...">
                        <button type="button" id="replybtn<%=num%>" onclick="reply(<%=num%>)" disabled >게시</button>
                    </div>
                    </form>
                </div>
                
                
                 <div class="modal-container" id="modal-container<%=num%>">
        			<div class="modal">
            			<button onclick="delBoard(<%=num%>)">삭제</button>
            			<button onclick="location.href = '/board/boardContent.jsp?num=<%=num%>';">게시물로 이동</button>
            			<button>Share to...</button>
            			<button>링크복사</button>
           				<button>퍼가기</button>
            			<button id="cancel" onclick="closePopup(<%=num%>)">취소</button>
        			</div>
    			</div>
                
                
                    	<%
            }
                    %>
                    
             
            </article>
        </section>
    </main>
   
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
    <script src="/js/jquery.serializeObject.min.js"></script>
    <script>
    $('#profile').on('click',function(){
    	$ul = $('#profile').children();
    	if($ul.hasClass('drop')===true){
    		$ul.removeClass('drop')
    	}else{
    		$ul.addClass('drop');
    	}
    });
	
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
    
    function replylike(number){
    	var $i = $('#replylikeBtn'+number).children();
    	var username= $('#replylikeBtn'+number).prev().val();
    	var bno= $('#replylikeBtn'+number).prev().prev().val();
    	console.log(number);
    	console.log(username);
    	console.log(bno);
    	if($i.hasClass("far fa-heart") === true){
    		$i.removeClass('far fa-heart').addClass('fas fa-heart');
    		$i.css('color', 'red');
    	}else{
    		$i.removeClass('fas fa-heart').addClass('far fa-heart');
    		$i.css('color', 'black');
    	}

        $.ajax({
    		url : '/api/ReplyLike/' + number+'/'+username +'/'+bno,
    		method : 'POST',
    		success : function(data) {
    			console.log(data.likecount);
    			
    			
    		} // success
    	});
    }

	function replyInput(num){
		var str = "replybtn"+num;
		var btn = document.getElementById(str);
		var text =$('#replyInput'+num).val();
		var len = text.length;
		console.log(len);
		console.log(btn);
		if(len>0){
			btn.disabled = false;
			$("#replybtn"+num).css('cursor','pointer');
		}else if (len==0){
			btn.disabled = true;
			$("#replybtn"+num).css('cursor','auto');
		}
		
	}
    
	function delBoard(num){
		
		$.ajax({
			url: '/api/boards/' +num,
			method: 'DELETE',
			success: function(data){
				if(data.result == 'success'){
					location.href = '/home.jsp';
				}
			}
		});
	}
     
    function reply(num){
    	
    	
		var obj = $('form#frm'+num).serializeObject();
		console.log(obj);
		console.log(typeof obj);
		
		var strJson = JSON.stringify(obj);
		console.log(strJson);
		console.log(typeof strJson);
		
		
		// ajax 함수 호출
		$.ajax({
			url: '/api/reply',
			method: 'POST',
			data: strJson,
			contentType: 'application/json; charset=UTF-8',
			success: function (data) {
				console.log(data);
				location.href = '/home.jsp';
				
			}
		});
		
    }
    
    function popup(num) {
    	document.querySelector('#modal-container'+num).style.display = "flex";
    }
    function closePopup(num) {
        document.querySelector('#modal-container'+num).style.display = "none";
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