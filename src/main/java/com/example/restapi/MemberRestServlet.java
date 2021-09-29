package com.example.restapi;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.domain.MemberVO;
import com.example.repository.MemberDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.annotations.JsonAdapter;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.coobird.thumbnailator.Thumbnailator;

@WebServlet("/api/members/*")
public class MemberRestServlet extends HttpServlet {
		
	private MemberDAO memberDAO = MemberDAO.getInstance();
	private static final String BASE_URI = "/api/members";
	private Gson gson = new Gson();
	public MemberRestServlet() {
		GsonBuilder builder = new GsonBuilder();
		gson = builder.create();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		System.out.println("requestURI : " +requestURI);
		
		
		String text = requestURI.substring(BASE_URI.length());
		System.out.println(text);
		
		String strJson = "";
		
		if(text.length()==0) {// "/api/members"
			 List<MemberVO> memberList = memberDAO.getMembers();
			 
			 strJson = gson.toJson(memberList);
			
		}else {// "/api/members/aaa"
			text = text.substring(1); // 맨앞에 "/" 문자제거
			
			MemberVO memberVO = memberDAO.getMemberById(text);
			int idCount = memberDAO.getCountById(text);
			int usernameCount = memberDAO.getCountByUsername(text);
			Map<String, Object> map = new HashMap<>();
			map.put("member",memberVO);
			map.put("idCount",idCount);
			map.put("usernameCount",usernameCount);
			
			strJson = gson.toJson(map);
		}
		
		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strJson);
		
	} // doGet

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// "api/members"
		HttpSession session = request.getSession();
		System.out.println("doPost 호출됨");
		
		// application/json 형식의 데이터를 받을때
		// HTTP 메시지 바디를 직접 읽어와야 함
		BufferedReader reader = request.getReader();
		
		// HTTP 
		String strJson = readMessageBody(reader);
		System.out.println("JSON 문자열 : " + strJson);
		
		// JSON 문자열 -> 자바객체로 변환
		MemberVO memberVO = gson.fromJson(strJson, MemberVO.class);
		System.out.println(memberVO);
		
		// insert 회원등록하기
		if(memberVO.getUsername() !=null) {
		memberDAO.insert(memberVO);
		}
		Boolean idChk = false;
		Boolean passChk = false;
		int count = memberDAO.getCountById(memberVO.getId());
		if (count == 1) {
			MemberVO chkMemberVO = memberDAO.getMemberById(memberVO.getId());
			idChk = true;

			if (chkMemberVO.getPasswd().equals(memberVO.getPasswd())) {
				passChk = true;

				String id = memberVO.getId();
				String username = chkMemberVO.getUsername();
				String profileImg = chkMemberVO.getProfileImg();

				System.out.println("id :" + id);

				session.setAttribute("id", id);
				// 쿠키 생성
				Cookie cookie = new Cookie("loginId", id);
				// 쿠키 유효시간(유통기한) 설정
				// cookie.setMaxAge(60 * 10); // 초단위로 설정. 10분 = 60초 * 10
				cookie.setMaxAge(60 * 60); // 1주일 설정.

				// 쿠키 경로설정
				cookie.setPath("/"); // 프로젝트 모든 경로에서 쿠키 받도록 설정

				// 클라이언트로 보낼 쿠키를 response 응답객체에 추가하기. -> 응답시 쿠키도 함께 보냄.
				response.addCookie(cookie);

			}
		}
		
		// 응답데이터 주기
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("member", memberVO);
		map.put("idChk", idChk);
		map.put("passChk", passChk);
		// 자바객체 -> JSON 문자열로 반환
		String strResponse = gson.toJson(map);
		
		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strResponse);
	} // doPost

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String str = requestURI.substring(BASE_URI.length());
		str = str.substring(1);
		if (str.equals("pass")) {
			System.out.println("pass 호출됨");

			BufferedReader reader = request.getReader();

			// HTTP
			String strJson = readMessageBody(reader);
			String[] array = strJson.split("\"");
			System.out.println("JSON 문자열 : " + strJson);
			String id = array[3];
			String oldPass = array[7];
			String pass = array[11];
			String passChk = array[15];
			System.out.print(id + " " + oldPass + " " + pass + " " + passChk + "\n");

			MemberVO chkMemberVO = memberDAO.getMemberById(id);
			Boolean BpassChk = false;
			if (chkMemberVO.getPasswd().equals(oldPass)) {
				memberDAO.passChange(id, pass);
				BpassChk = true;
			}

			Map<String, Object> map = new HashMap<>();
			map.put("result", "success");
			map.put("BpassChk", BpassChk);
			// 자바객체 -> JSON 문자열로 반환
			String strResponse = gson.toJson(map);

			// 클라이언트 쪽으로 출력하기
			sendResponse(response, strResponse);
		} else {
			String id = str;
			System.out.println("업데이트 호출됨 ");
			System.out.println("id : " + id);
			MemberVO memberVO = new MemberVO();

			String uploadFolder = "C:/Javastudy/upload"; // 업로드 기준경로

			File uploadPath = new File(uploadFolder, getFolder()); // "C:/Javastudy/upload/2021/08/03"\
			System.out.println("uploadPath : " + uploadPath.getPath());

			if (uploadPath.exists() == false) {
				uploadPath.mkdirs();
			}

			// MultipartRequest 인자값
			// 1. request
			// 2. 업로드할 물리적 경로. "C:/Javastudy/upload"
			// 3. 업로드 최대크기 바이트 단위로 제한. 1024Byte * 1024Byte = 1MB
			// 4. request의 텍스트 데이터, 파일명 인코딩 "utf-8"
			// 5. 파일명 변경 정책. 파일명 중복시 이름변경규칙 가진 객체를 전달

			// 파일 업로드하기
			MultipartRequest multi = new MultipartRequest(request, uploadPath.getPath(), 1024 * 1024 * 50, "utf-8",
					new DefaultFileRenamePolicy());
			// ===== 파일 업로드 완료됨. =====

			// input type="file" 태그들의 name 속성들을 가져오기
			Enumeration<String> enu = multi.getFileNames(); // Iterator, Enumeration 반복자 객체

			while (enu.hasMoreElements()) { // 파일이 있으면
				String fname = enu.nextElement(); // name 속성값 : file0 file1 file2 ...

				// 저장된 파일명 가져오기
				String filename = multi.getFilesystemName(fname); // fname이 file0일때
				System.out.println("FilesystemName : " + filename);

				// 원본 파일명 가져오기
				String original = multi.getOriginalFileName(fname);
				System.out.println("OriginalFileName : " + original);

				if (filename == null) { // 파일정보가 없으면
					continue; // 그다음 반복으로 건너뛰기
				}

				File file = new File(uploadPath, filename); // 년월일 경로에 실제 파일명의 파일객체

				if (filename != "null") {
					memberVO.setProfileImg(uploadPath + "/" + filename);
					str = memberVO.getProfileImg().replace("\\", "/");
					memberVO.setProfileImg(str);
				}
			} // while

			memberVO.setId(id); // 수정할 아이디 기준
			memberVO.setName(multi.getParameter("name"));
			memberVO.setUsername(multi.getParameter("username"));
			memberVO.setWeb(multi.getParameter("web"));
			memberVO.setMemo(multi.getParameter("memo"));
			memberVO.setEmail(multi.getParameter("email"));
			memberVO.setPhone(multi.getParameter("phone"));
			memberVO.setGender(multi.getParameter("gender"));

			System.out.println(memberVO.toString());

			// 회원정보 수정하기
			memberDAO.updateById(memberVO);
			// 응답정보로 보낼 수정된 회원정보 가져오기
			MemberVO updateMember = memberDAO.getMemberById(id);

			// 응답데이터 준비
			Map<String, Object> map = new HashMap<>();
			map.put("result", "success");
			map.put("member", updateMember);
			// 자바객체 -> JSON 문자열로 반환
			String strResponse = gson.toJson(map);

			// 클라이언트 쪽으로 출력하기
			sendResponse(response, strResponse);
		}
	} // doPut

	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// "api/members/aaa"
		String requestURI = request.getRequestURI();
		String id = requestURI.substring(BASE_URI.length());
		id = id.substring(1);
		System.out.println("id : " + id);
		
		MemberVO delMember = memberDAO.getMemberById(id);
		// 응답데이터 준비
		Map<String, Object> map = new HashMap<>();
		if(delMember != null) {
			memberDAO.deleteById(id); // 회원삭제하기
			map.put("isDeleted", true);
			map.put("member", delMember);
		}else {
			map.put("isDeleted", false);
		}
		
		
		// 자바객체 -> JSON 문자열로 반환
		String strResponse = gson.toJson(map);
						
		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strResponse);
		
		
		
	} // doDelete
	
	private String readMessageBody(BufferedReader reader) throws IOException {
		
		StringBuilder sb = new StringBuilder();
		String line = "";
		while ((line = reader.readLine()) != null) {
			sb.append(line);
		} // while
		
		return sb.toString();
	} // readMessageBody
	
	private void sendResponse(HttpServletResponse response, String json) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	} // sendResponse
	

		
	//년/월/일 폴더명 생성하는 메소드
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); // "yyyy-MM-dd"
		Date date = new Date();
		String str = sdf.format(date);
		//str = str.replace("-", File.separator);
		return str;
	}
}
