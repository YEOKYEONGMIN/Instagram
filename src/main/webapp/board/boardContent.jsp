<%@page import="com.example.repository.BoardLikeDAO"%>
<%@page import="com.example.repository.ReplyLikeDAO"%>
<%@page import="com.example.domain.AttachVO"%>
<%@page import="com.example.domain.ReplyVO"%>
<%@page import="com.example.domain.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@page import="com.example.repository.ReplyDAO"%>
<%@page import="com.example.repository.AttachDAO"%>
<%@page import="com.example.repository.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String str = request.getParameter("num");
int num = Integer.parseInt(str);
String id = (String) session.getAttribute("id");
System.out.println("id :" + id );

MemberDAO memberDAO = MemberDAO.getInstance();
BoardDAO boardDAO = BoardDAO.getInstance();
AttachDAO attachDAO = AttachDAO.getInstance();
ReplyDAO replyDAO = ReplyDAO.getInstance();

BoardLikeDAO boardLikeDAO = BoardLikeDAO.getInstance();
ReplyLikeDAO replyLikeDAO = ReplyLikeDAO.getInstance();

MemberVO memberVO = memberDAO.getMemberById(id);
BoardVO boardVO = boardDAO.getBoard(num);
List<ReplyVO> replyList;
List<AttachVO> attachList;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="/images/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="/css/boardContent.css">
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

	<section class="b_inner">

		<div class="contents_box">

			<article class="contents cont01">
				<%
				String username = boardVO.getUsername();
				MemberVO userVO = memberDAO.getMemberByUsername(username);
            	attachList = attachDAO.getAttachesByBno(num);
            	int count =0;
				%>
				<div class="img_section">
					<div class="flex">
                        <div class="carousel">
                            <div class="viewbox">
                                <div class="btn btn-back hidden">
                                    <i class="fas fa-chevron-left left-indicator"></i>
                                </div>
                                <div class="track">
                                <% for (AttachVO attach : attachList) {
                                	count ++;
                                	String fileCallPath = attach.getUploadpath() + "/" + attach.getFilename();
                                	System.out.println(attach.getUploadpath()+"\n"+attach.getFilename());
                                %>
                                    <div id="sl__item__img" class="slide active">
                                        <img class="images" src="/board/display.jsp?fileName=<%=fileCallPath %>"  alt="">
                                    </div>
                                <%
                    			}
                    			%>    
                                </div>
                                <div class="nav-indicator">
                                    <%if(count>1){ %>
                                <div class="dot active"></div>
                            	<%for(int i=0; i<count-1;i++){ %>    
                                <div class="dot"></div>
                                <%}
                                }%>
                                </div>
                                <div class="btn btn-next">
                                <%if(count>1){ %>
                                    <i class="fas fa-chevron-right right-indicator"></i>
                                 <%} %>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>


				<div class="detail--right_box">

					<header class="top">
						<div class="user_container">
							<div class="profile_img">
								 <%
                   	if (userVO.getProfileImg()==null ) { // 첨부파일이 없으면
                   		%>
                   		<img src="/images/profileImg.jpg" alt="">
                   			<%
                   	}else {
                   		%>
                       <img src="/member/display.jsp?fileName=<%=userVO.getProfileImg() %>" alt="">
                        <%
                        } 
                        %>
							</div>
							<div class="user_name">
								<div class="nick_name"><%=boardVO.getUsername() %></div>
								<div class="country"><%=boardVO.getLocation() %></div>
							</div>
						</div>
						<div class="sprite_more_icon" data-name="more">
						<button onclick="popup();"><i class="fas fa-ellipsis-h"></i></button>
						</div>

					</header>

					<section class="scroll_section">
						<div class="admin_container">
							<div class="admin">
								 <%
                   		if (userVO.getProfileImg()==null ) { // 첨부파일이 없으면
                   		%>
                   		<img src="/images/profileImg.jpg" alt="">
                   			<%
                   		}else {
                   		%>
                       <img src="/member/display.jsp?fileName=<%=userVO.getProfileImg() %>" alt="">
                        <%
                        } 
                        %>
							</div>
							<div class="content">
								<span class="user_id"><%=boardVO.getUsername()%></span><%=boardVO.getContent() %>
								<div class="time">2시간</div>
							</div>
						</div>
						<%replyList = replyDAO.getReply(num);
						for(ReplyVO replyVO : replyList){
						MemberVO replyUserVO = memberDAO.getMemberByUsername(replyVO.getReplyUsername());%>
						<div class="user_container-detail">
							<div class="user">
							<% if (replyUserVO.getProfileImg()==null ) { // 첨부파일이 없으면
                   			%>
                   			<img src="/images/profileImg.jpg" alt="">
                   				<%
	                   		}else {
	                   			%>
	                      	 <img src="/member/display.jsp?fileName=<%=replyUserVO.getProfileImg() %>" alt="">
	                        	<%
	                        } 
                        	%>
							</div>
							<div class="comment">
								<span class="user_id"><%=replyVO.getReplyUsername() %></span><%=replyVO.getReplyComment() %>
								<div class="time">
									2시간 
									<%if(replyVO.getReplyLikecount()>0) {%>
										<span class="replylike<%=replyVO.getNum()%>">좋아요 <%=replyVO.getReplyLikecount() %>개</span>
									<%} else{  %>
										<span class="replylike<%=replyVO.getNum()%>"></span>
									<%} %>	
										<button>답글 달기</botton>
								</div>
								<div class="icon_wrap">
									<div class="more_trigger">
										<div class="menu"><button onclick="replyPopup(<%=replyVO.getNum()%>)"><i class="fas fa-ellipsis-h"></i></button></div>
									</div>
									
									<div class="heart">
									<input type="hidden" value="<%=boardVO.getNum() %>">
									<input type="hidden" value="<%=memberVO.getUsername() %>"/>
									<button type="button" id="replylikeBtn<%=replyVO.getNum() %>" onclick="replylike(<%=replyVO.getNum()%>);">
									 <%if(replyLikeDAO.getLike(replyVO.getNum(), memberVO.getUsername())==0) {%>
                            	 	<i class="far fa-heart"></i>
                            	 <%}else{%>  
                            	 	<i class="fas fa-heart" style="color: red;"></i>
                            	 	<%} %></button></div>
									
								</div>
							</div>
						</div>
						<div class="modal-container1" id="modal-container<%=replyVO.getNum()%>">
       						<div class="modal1">
       							<button>신고</button>
           						<button onclick="delReply(<%=replyVO.getNum()%>,<%=boardVO.getNum()%>)">삭제</button>
           						<button id="cancel" onclick="closeReplyPopup(<%=replyVO.getNum()%>)">취소</button>
       						</div>
   						</div>
						<%}   %>
						
					</section>


					<div class="bottom_icons">
							<input type="hidden" value="<%=memberVO.getUsername() %>">
                        	<input type="hidden" value="<%=boardVO.getNum()%>">
                        	<%if(boardLikeDAO.getLike(boardVO.getNum(), memberVO.getUsername())==0){ %>
                            	<button type="button" id="btn<%=boardVO.getNum() %>" onclick="like(<%=boardVO.getNum()%>);" class="btn-like"><i class="far fa-heart"></i></button>
                            <%} else { %>
                            	<button type="button" id="btn<%=boardVO.getNum() %>" onclick="like(<%=boardVO.getNum()%>);" class="btn-like"><i class="fas fa-heart" style="color: red;"></i></button>
                            	<%} %>	  
                            <button><i class="far fa-comment"></i></button>
                            <button><i class="far fa-paper-plane"></i></button>
							<button><i class="far fa-bookmark"></i></button>
					
					</div>

					<div class="count_likes">
						<%if(boardVO.getLikecount()>0){ %>
						 <span class="count">좋아요 <%=boardVO.getLikecount() %>개</span> 
						<% } else { %>
      							<span class="count"></span>
                        <%} %>
					</div>
					<div class="timer">2시간</div>
					<form id="frm<%=num%>">
					<div class="commit_field">
						<input type="hidden" name="replyBno" value="<%=num%>">
						<input type="hidden" name="replyUsername" value="<%=memberVO.getUsername() %>" >      
						<input type="text" name="replyComment" onkeyup="replyInput(<%=num%>)" id="replyInput<%=num%>" placeholder="댓글달기..">
						<button type="button" id="replybtn<%=num%>" onclick="reply(<%=num%>)" disabled >게시</button>
					</div>
					</form>
				</div>
				<div class="modal-container">
       				<div class="modal">
           				<button onclick="delBoard(<%=num%>)">삭제</button>
           				<button>공유 대상</button>
           				<button>링크 복사</button>
       					<button>퍼가기</button>
           				<button id="cancel" onclick="closePopup()">취소</button>
       				</div>
   				</div>
   				
			</article>
		</div>
	</section>
	

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
    	var $span = $('span.count');
    	console.log($span);

        $.ajax({
    		url : '/api/boardLike/' + bno+'/'+username,
    		method : 'POST',
    		success : function(data) {
    			console.log(data.likecount);
    			
    			if(data.likecount>0)
    				$span.html('좋아요 '+data.likecount+'개');
    			else
    				$span.html('');

    			
    		} // success
    	});
    }
    
    function replylike(number){
    	var $i = $('#replylikeBtn'+number).children();
    	var username= $('#replylikeBtn'+number).prev().val();
    	var bno= $('#replylikeBtn'+number).prev().prev().val();
    	var $span = $('.replylike'+number);
    	console.log(number);
    	console.log(username);
    	console.log(bno);
    	console.log($span);
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
    			
    			if(data.likecount>0)
    				$span.html('좋아요 '+data.likecount+'개');
    			else
    				$span.html('');
    			
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
    
    
    function reply(num){
    	console.log('reply실행');
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
				
				location.href = '/board/boardContent.jsp?num='+num;
			}
		});
		
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
	function delReply(num,bno){
		
		$.ajax({
			url: '/api/reply/' +num,
			method: 'DELETE',
			success: function(data){
				if(data.result == 'success'){
					location.href = '/board/boardContent.jsp?num='+bno;
				}
			}
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
    function replyPopup(num) {
    	document.querySelector('#modal-container'+num).style.display = "flex";
    }
    function closeReplyPopup(num) {
        document.querySelector('#modal-container'+num).style.display = "none";
    }
    document.querySelector('.modal-container').addEventListener('click', (e) => {
        if (e.target.tagName === "DIV") {
            document.querySelector('.modal-container').style.display = "none";
        }
    });

   
    </script>
</body>
</html>