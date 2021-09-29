<%@page import="com.example.domain.MemberVO"%>
<%@page import="com.example.repository.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% String id = (String) session.getAttribute("id"); 
MemberDAO memberDAO = MemberDAO.getInstance();

//아이디에 해당하는 자신의 정보를 DB에서 가져오기
MemberVO memberVO = memberDAO.getMemberById(id);

%>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="/images/insta.svg">
    <!-- Style -->
    <link rel="stylesheet" href="/css/insertBoard.css">
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
				<li class="navi-item"><a href="/message.jsp"><i
						class="far fa-paper-plane"></i></a></li>
				<li class="navi-item"><a href="/popular.jsp"><i
						class="far fa-compass"></i></a></li>
				<li class="navi-item"><a href="" id="followBtn"><i
						class="far fa-heart"></i></a></li>
				<li class="navi-item" id="profile"><a href="#"><span
						class="my-account"><img src="/images/profile.jpeg"></span></a>
					<ul>
                        <li><a href="/member/profile.jsp"><i class="far fa-user-circle"></i> 프로필</a></li>
                        <li><a href="/member/logout.jsp">로그아웃</a></li>
                    </ul>		
				</li>
			</ul>
		</nav>
	</div>
	</header>
<div id="main_container">

        <div class="post_form_container">
            <form action="#" class="post_form" id="frm" enctype="multipart/form-data">
            <input type="hidden" name="username" value="<%=memberVO.getUsername()%>">
                <div class="title">
                    NEW POST
                </div>
                <div class="preview">
                    <div class="upload">
                        <div class="post_btn">
                            <div class="plus_icon">
                                <span></span>
                                <span></span>
                            </div>
                            <p>포스트 이미지 추가</p>
                            <canvas id="imageCanvas"></canvas>
                            <!--<p><img id="img_id" src="#" style="width: 300px; height: 300px; object-fit: cover" alt="thumbnail"></p>-->
                        </div>
                    </div>
                </div>
                <p>
                    <input type="text" name="location" id="location" placeholder="위치를 입력하세요">
                </p>
                <p>
                    <button type="button" id="btnAddFile">첨부파일 추가</button>
                <div id="fileBox">
                    <div class="flex">
                        <input type="file" name="file0" id="id_photo" required>
                    </div>
                </div>
                </p>
                <p>
                    <textarea name="content" id="text_field" cols="50" rows="5" placeholder="140자 까지 등록 가능합니다.
#태그명 을 통해서 검색 태그를 등록할 수 있습니다.
예시 : I # love # insta!"></textarea>

                </p>
                <button class="submit_btn" id="btnWrite" type="button">저장</button>
            </form>

        </div>

    </div>


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
        var fileCount = 1; // 파일 요소 갯수
        var fileIndex = 1;


        $('#btnAddFile').on('click', function () {
            if (fileCount >= 5) {
                alert('첨부파일은 최대 5개 까지만 첨부할 수 있습니다.');
                return;
            }

            var str = `
			<div class="flex">
				<input type="file" name="file\${fileIndex}" id="id_photo">
				<span class="file-delete">X</span>
			</div>
		`;
            $('#fileBox').append(str);
            fileIndex++;
            fileCount++;
        });

        // 동적 이벤트 연결 (이벤트 위임 방식)
        $('#fileBox').on('click', 'span.file-delete', function () {
            $(this).parent().remove();
            fileCount--;
        });

        var cloneObj = $('div#fileBox').clone();

        // 글쓰기 버튼 클릭했을 때
        $('#btnWrite').on('click', function () {
        	var fileCheck = document.getElementById("id_photo").value;
            if(!fileCheck){
                alert("파일을 첨부해 주세요");
                return false;
            }
            var form = $('form#frm')[0];
            // 		console.log(form);
            // 		console.log(typeof form);

            var formData = new FormData(form);
            console.log(formData);
            console.log(typeof formData);

            $.ajax({
                url: '/api/boards/new',
                //enctype: 'multipart/form-data',
                method: 'POST',
                data: formData,
                processData: false, //파일전송시 false 설정 필수
                contentType: false, //파일전송시 false 설정 필수
                success: function (data) {
                    console.log(data);

                    if (data.result == 'success') {
                        alert('파일 업로드 완료');
                        location.href = '/home.jsp';
                    }

                    $('form#frm')[0].reset();

                    $('div#fileBox').html(cloneObj.html());
                    showUploadedFile(data.attachList);
                }
            });
        });


        function showUploadedFile(attachList) {

            var str = "";

            for (var attach of attachList) {
                str += `
				<li>\${attach.filename}</li>
			`;
            }
            $('div#uploadResult > ul').html(str);
        }

        var fileInput = document.querySelector("#id_photo"),
            button = document.querySelector(".input-file-trigger"),
            the_return = document.querySelector(".file-return");

        // Show image
        fileInput.addEventListener('change', handleImage, false);
        var canvas = document.getElementById('imageCanvas');
        var ctx = canvas.getContext('2d');


        function handleImage(e) {
            var reader = new FileReader();
            reader.onload = function (event) {
                var img = new Image();
                // var imgWidth =
                img.onload = function () {
                    canvas.width = 300;
                    canvas.height = 300;
                    ctx.drawImage(img, 0, 0, 300, 300);
                };
                img.src = event.target.result;
                // img.width = img.width*0.5
                // canvas.height = img.height;
            };
            reader.readAsDataURL(e.target.files[0]);
        }
    </script>
</body>

</html>