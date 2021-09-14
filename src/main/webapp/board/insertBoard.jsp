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
<title>Insert title here</title>
<style>
span.file-delete{
	background-color: yellow;
	color: red;
	font-weight: bold;
	cursor: pointer;
	border: 1px solid black;
	border-radius: 5px;
	padding: 2px;
	margin-left: 10px;
	display: inline-block;
}
</style>
</head>
<body>
<h1>새글 등록</h1>
<hr>

<form id="frm" enctype="multipart/form-data">
<table border="1">
	<tr>
		<th>작성자 아아디</th>
		<td>
			<input type="text" name="username" id="username" value="<%=memberVO.getUsername() %>" readonly>
		</td>
	</tr>
	<tr>
		<th>위치</th>
		<td>
			<input type="text" name="location" id="location">
		</td>
	</tr>
	<tr>
		<th>글내용</th>
		<td>
			<textarea rows="13" cols="40" name="content" id="content"></textarea>
		</td>
	</tr>
	
	<tr>
		<th>파일</th>
		<td>
			<button type="button" id="btnAddFile">첨부파일 추가</button>
			<div id="fileBox">
				<div>
					<input type="file" name="file0">
					<span class="file-delete">X</span>
				</div>
			</div>
			<div id="uploadResult">
				<ul>
					
				</ul>
			</div>
		</td>
	</tr>
</table>
<br>
<button type="button" id="btnWrite">글쓰기</button>
</form>

<script src="/js/jquery-3.6.0.js"></script>
<script src="/js/jquery.serializeObject.min.js"></script>
<script>
	
	var fileCount = 1; // 파일 요소 갯수
	var fileIndex = 1;
	
	
	$('#btnAddFile').on('click', function(){
		if(fileCount >= 5){
			alert('첨부파일은 최대 5개 까지만 첨부할 수 있습니다.');
			return;
		}
		
		var str =`
			<div>
				<input type="file" name="file\${fileIndex}">
				<span class="file-delete">X</span>
			</div>
		`;
		$('#fileBox').append(str);
		fileIndex++;
		fileCount++;
	});
	
	// 동적 이벤트 연결 (이벤트 위임 방식)
	$('#fileBox').on('click','span.file-delete',function(){
		$(this).parent().remove();
		fileCount--;
	});
	
	var cloneObj = $('div#fileBox').clone();
	
	// 글쓰기 버튼 클릭했을 때
	$('#btnWrite').on('click',function(){
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
			success: function(data){
				console.log(data);
				
				if(data.result =='success'){
					alert('파일 업로드 완료');
				}
				
				$('form#frm')[0].reset();
				
				$('div#fileBox').html(cloneObj.html());
				showUploadedFile(data.attachList);
			}
		});
	});
	
	
	function showUploadedFile(attachList){
		
		var str = "";
		
		for(var attach of attachList){
			str += `
				<li>\${attach.filename}</li>
			`;
		}
		$('div#uploadResult > ul').html(str);
	}
</script>
</body>
</html>