package com.example.restapi;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.domain.AttachVO;
import com.example.domain.BoardVO;
import com.example.repository.AttachDAO;
import com.example.repository.BoardDAO;
import com.example.repository.BoardLikeDAO;
import com.example.repository.ReplyDAO;
import com.example.repository.ReplyLikeDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.coobird.thumbnailator.Thumbnailator;

@WebServlet(urlPatterns = {"/api/boards/*"}, loadOnStartup = 1)
public class BoardRestServlet extends HttpServlet {
	
	private static final String BASE_URI = "/api/boards";
	
	private BoardDAO boardDAO = BoardDAO.getInstance();
	private AttachDAO attachDAO = AttachDAO.getInstance();
	private BoardLikeDAO boardLikeDAO = BoardLikeDAO.getInstance();
	private ReplyDAO replyDAO = ReplyDAO.getInstance();
	private ReplyLikeDAO replyLikeDAO = ReplyLikeDAO.getInstance();
	
	
	private Gson gson;
	
	public BoardRestServlet() {
		GsonBuilder builder = new GsonBuilder();
		gson = builder.create();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// GET 조회
		// "/api/boards/{bno}" -> 상세글보기
		// "/api/boards/pages/{page}" -> 페이지버호에 해당하는 글목록 가져오기

		String requestURI = request.getRequestURI();
		String str = requestURI.substring(BASE_URI.length() + 1);
		
		String strJson ="";
		if(str.startsWith("pages")) {// 페이징 글목록 조회

			int beginIndex = str.indexOf("/") + 1;
			String strPage = str.substring(beginIndex); // "2"
			int page = Integer.parseInt(strPage);  // 2
			
		
			List<BoardVO> boardList = boardDAO.getBoards();
			
			strJson = gson.toJson(boardList); // [{}, {}, {}, ...]
		}else {// 글번호 해당하는 상세글보기
			
			int bno = Integer.parseInt(str);
			
			BoardVO boardVO = boardDAO.getBoard(bno);
			List<AttachVO> attachList = attachDAO.getAttachesByBno(bno);
			
			Map<String, Object> map = new HashMap<>();
			map.put("board", boardVO);
			map.put("attachList", attachList);
			
			strJson = gson.toJson(map);
			
		}
		sendResponse(response, strJson);
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// POST 등록
		// "/api/boards/new" -> 주글 등록
		// "/api/boards/reply" -> 답글 등록
		
		String requestURI = request.getRequestURI();
		String type = requestURI.substring(BASE_URI.length() + 1);
		
		if(type.equals("new")) {
			WriteNewBoard(request, response);
		}else if(type.equals("reply")) {
			//WriteReplyBoard(request, response);
		}
		
	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// PUT 수정
		// "/api/boards/{bno}" + 수정내용 -> 특정 글 수정하기
		

		String requestURI = request.getRequestURI();
		String bno = requestURI.substring(BASE_URI.length() + 1);
		int num = Integer.parseInt(bno); // 수정할 게시글 번호
		
		
		String uploadFolder = "C:/Javastudy/upload"; // 업로드 기준경로

		File uploadPath = new File(uploadFolder, getFolder()); // "C:/ksw/upload/2021/08/03"
		System.out.println("uploadPath : " + uploadPath.getPath());

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}


		// MultipartRequest 인자값
		// 1. request
		// 2. 업로드할 물리적 경로.  "C:/Javastudy/upload"
		// 3. 업로드 최대크기 바이트 단위로 제한. 1024Byte * 1024Byte = 1MB 
		// 4. request의 텍스트 데이터, 파일명 인코딩 "utf-8"
		// 5. 파일명 변경 정책. 파일명 중복시 이름변경규칙 가진 객체를 전달

		// 파일 업로드하기
		MultipartRequest multi = new MultipartRequest(
				request
				, uploadPath.getPath()
				, 1024 * 1024 * 50
				, "utf-8"
				, new DefaultFileRenamePolicy());
		// ===== 파일 업로드 완료됨. =====





		// AttachDAO 객체 준비
		AttachDAO attachDAO = AttachDAO.getInstance();
		// BoardDAO 객체 준비
		BoardDAO boardDAO = BoardDAO.getInstance();
		
		
		
		
		// =============== 신규 첨부파일 정보를 테이블에 insert하기 ===============

		// input type="file" 태그들의 name 속성들을 가져오기
		Enumeration<String> enu = multi.getFileNames(); // Iterator, Enumeration 반복자 객체

		while (enu.hasMoreElements()) { // 파일이 있으면
			String fname = enu.nextElement(); // name 속성값 : file0  file1  file2 ...
			
			// 저장된 파일명 가져오기
			String filename = multi.getFilesystemName(fname); // fname이 file0일때
			System.out.println("FilesystemName : " + filename);
			
			// 원본 파일명 가져오기
			String original = multi.getOriginalFileName(fname);
			System.out.println("OriginalFileName : " + original);
			
			if (filename == null) { // 파일정보가 없으면
				continue; // 그다음 반복으로 건너뛰기
			}
			
			// AttachVO 객체 준비
			AttachVO attachVO = new AttachVO();
			
			attachVO.setFilename(filename);
			attachVO.setUploadpath(getFolder());
			attachVO.setBno(num); // 첨부파일이 포함될 게시글 번호 저장
			
			UUID uuid = UUID.randomUUID();
			attachVO.setUuid(uuid.toString()); // 기본키 uuid 저장
			
			File file = new File(uploadPath, filename); // 년월일 경로에 실제 파일명의 파일객체
			
		
			
			// 첨부파일 attach 테이블에 attachVO를 insert하기
			attachDAO.addAttach(attachVO);
		} // while

		//=============== 신규 첨부파일 정보를 테이블에 insert하기 완료 ===============
			
			
			

		//=============== 삭제할 첨부파일 정보를 삭제하기 ===============

		String[] delFileUuids = multi.getParameterValues("delfile");

		for (String uuid : delFileUuids) {
			// 첨부파일 uuid에 해당하는 첨부파일객체를 VO로 가져오기
			AttachVO attach = attachDAO.getAttachByUuid(uuid);
			
			String path = uploadFolder + "/" + attach.getUploadpath() + "/" + attach.getFilename();
			File deleteFile = new File(path);
			
			if (deleteFile.exists()) { // 삭제할 파일이 해당경로에 존재하면
				deleteFile.delete();   // 파일 삭제하기
			} // if
			
			

			// DB에서 uuid에 해당하는 첨부파일정보를 삭제하기
			attachDAO.deleteAttachByUuid(uuid);
		} // for
		//=============== 삭제할 첨부파일 정보를 삭제하기 완료 ===============





		//=============== 게시글 수정하기 ===============
		// 수정에 사용할 게시글 VO 객체 준비
		BoardVO boardVO = new BoardVO();
				
		// 파라미터값 가져와서 VO에 저장
		boardVO.setNum(num);
		boardVO.setContent(multi.getParameter("content"));
		boardVO.setIpaddr(request.getRemoteAddr());
		boardVO.setLocation(multi.getParameter("location"));

		// DB에 게시글 수정하기
		boardDAO.updateBoard(boardVO);
		//=============== 게시글 수정하기 완료 ===============
		
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		String strJson = gson.toJson(map);
		
		sendResponse(response, strJson);
		
		
		
	}

	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// DELETE 삭제
		// "/api/boards/{bno}" -> 특정 글 삭제하기
		
		String requestURI = request.getRequestURI();
		String bno = requestURI.substring(BASE_URI.length() + 1);
		int num = Integer.parseInt(bno);
		
		// 게시글번호에 첨부된 첨부파일 리스트 가져오기
		List<AttachVO> attachList = attachDAO.getAttachesByBno(num);

		//업로드 기준경로
		String uploadFolder = "C:/Javastudy/upload";

		// 첨부파일 삭제하기
		for (AttachVO attach : attachList) {
			String path = uploadFolder + "/" + attach.getUploadpath() + "/" + attach.getFilename();
			File deleteFile = new File(path);
			
			if (deleteFile.exists()) { // 삭제할 파일이 해당경로에 존재하면
				deleteFile.delete();   // 파일 삭제하기
			} // if
			
			
		} // for
		
		// DB 첨부파일 정보 삭제하기
		attachDAO.deleteAttachesByBno(num);
		// DB 게시글 정보 삭제하기
		boardDAO.deleteBoardByNum(num);
		boardLikeDAO.deleteBoardLikeByNum(num);
		replyDAO.deleteReplyByNum(num);
		replyLikeDAO.deleteReplyLikeByNum(num);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		String strJson = gson.toJson(map);
		
		sendResponse(response, strJson);
	} // doDelete
	
	
	private void sendResponse(HttpServletResponse response, String json) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	} // sendResponse
	
	private void WriteNewBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uploadFolder = "C:/Javastudy/upload"; // 업로드 기준경로

		File uploadPath = new File(uploadFolder, getFolder()); // "C:/Javastudy/upload/2021/08/03"
		System.out.println("uploadPath : " + uploadPath.getPath());

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}


		// MultipartRequest 인자값
		// 1. request
		// 2. 업로드할 물리적 경로.  "C:/ksw/upload"
		// 3. 업로드 최대크기 바이트 단위로 제한. 1024Byte * 1024Byte = 1MB 
		// 4. request의 텍스트 데이터, 파일명 인코딩 "utf-8"
		// 5. 파일명 변경 정책. 파일명 중복시 이름변경규칙 가진 객체를 전달

		// 파일 업로드하기
		MultipartRequest multi = new MultipartRequest(
				request
				, uploadPath.getPath()
				, 1024 * 1024 * 50
				, "utf-8"
				, new DefaultFileRenamePolicy());
		// ===== 파일 업로드 완료됨. =====
		
		// AttachDAO 객체 준비
		AttachDAO attachDAO = AttachDAO.getInstance();
		// BoardDAO 객체 준비
		BoardDAO boardDAO = BoardDAO.getInstance();

		// insert할 새 게시글 번호 가져오기
		int num = boardDAO.getNextnum(); // attach 레코드의 bno 컬럼값에 해당함


		// input type="file" 태그들의 name 속성들을 가져오기
		Enumeration<String> enu = multi.getFileNames(); // Iterator, Enumeration 반복자 객체

		while (enu.hasMoreElements()) { // 파일이 있으면
			String fname = enu.nextElement(); // name 속성값 : file0  file1  file2 ...
			
			// 저장된 파일명 가져오기
			String filename = multi.getFilesystemName(fname); // fname이 file0일때
			System.out.println("FilesystemName : " + filename);
			
			// 원본 파일명 가져오기
			String original = multi.getOriginalFileName(fname);
			System.out.println("OriginalFileName : " + original);
			
			if (filename == null) { // 파일정보가 없으면
				continue; // 그다음 반복으로 건너뛰기
			}
			
			
			// AttachVO 객체 준비
			AttachVO attachVO = new AttachVO();
			
			attachVO.setFilename(filename);
			attachVO.setUploadpath(getFolder());
			attachVO.setBno(num); // 첨부파일이 포함될 게시글 번호 저장
			
			UUID uuid = UUID.randomUUID();
			attachVO.setUuid(uuid.toString()); // 기본키 uuid 저장
			
			File file = new File(uploadPath, filename); // 년월일 경로에 실제 파일명의 파일객체
			
			

			// 첨부파일 attach 테이블에 attachVO를 insert하기
			attachDAO.addAttach(attachVO);
		} // while


		// BoardVO 객체 준비
		BoardVO boardVO = new BoardVO();

		// 파라미터값 가져와서 VO에 저장. MultipartRequest 로부터 가져옴.
		boardVO.setUsername(multi.getParameter("username"));
		boardVO.setContent(multi.getParameter("content"));

		// 글번호 설정
		boardVO.setNum(num);
		// ipaddr  regDate  readcount
		boardVO.setIpaddr(request.getRemoteAddr()); // 127.0.0.1  localhost
		boardVO.setRegDate(new Timestamp(System.currentTimeMillis()));
		boardVO.setLikecount(0); // 좋아요
		boardVO.setLocation(multi.getParameter("location"));
	

		// 주글 등록하기
		boardDAO.addBoard(boardVO);
		
		// ==================================================
		
		BoardVO dbBoard = boardDAO.getBoard(num);
		List<AttachVO> attachList = attachDAO.getAttachesByBno(num);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("board", dbBoard);
		map.put("attachList", attachList);
		
		String strJson = gson.toJson(map);
		
		sendResponse(response, strJson);
		
	} // WriteNewBoard
	
	// 년/월/일 폴더명 생성하는 메소드
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); // "yyyy-MM-dd"
		Date date = new Date();
		String str = sdf.format(date);
		//str = str.replace("-", File.separator);
		return str;
	}

	// 이미지 파일인지 여부 리턴하는 메소드
	private boolean checkImageType(File file) {
		boolean isImage = false;
		try {
			String contentType = Files.probeContentType(file.toPath());
			System.out.println("contentType : " + contentType); // "image/jpg"
			
			isImage = contentType.startsWith("image");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		return isImage;
	}
}
