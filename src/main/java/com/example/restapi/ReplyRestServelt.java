package com.example.restapi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.domain.MemberVO;
import com.example.domain.ReplyVO;
import com.example.repository.BoardDAO;
import com.example.repository.BoardLikeDAO;
import com.example.repository.ReplyDAO;
import com.example.repository.ReplyLikeDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet(urlPatterns = {"/api/reply/*"}, loadOnStartup = 1)
public class ReplyRestServelt extends HttpServlet {
	
	private static final String BASE_URI = "/api/reply";
	
	private ReplyDAO replyDAO = ReplyDAO.getInstance();
	private BoardDAO boardDAO = BoardDAO.getInstance();
	private ReplyLikeDAO replyLikeDAO = ReplyLikeDAO.getInstance();
	private Gson gson;
	public ReplyRestServelt() {
		GsonBuilder builder = new GsonBuilder();
		gson = builder.create();
	}
	
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String bno = requestURI.substring(BASE_URI.length() + 1);
		int num = Integer.parseInt(bno);
		
		replyDAO.deleteReplyByNum(num);
		replyLikeDAO.deleteReplyLikeBynum(num);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		
		String strJson = gson.toJson(map);
		
		sendResponse(response, strJson);
		
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// HTTP 메시지 바디를 직접 읽어와야 함
		BufferedReader reader = request.getReader();
				
				// HTTP 
		String strJson = readMessageBody(reader);
		System.out.println("JSON 문자열 : " + strJson);
				
		// JSON 문자열 -> 자바객체로 변환
		ReplyVO replyVO = gson.fromJson(strJson, ReplyVO.class);
		
		int num = replyDAO.getNextnum();
		replyVO.setNum(num);
		replyVO.setReplyLikecount(0);
		replyVO.setReplyRegDate(new Timestamp(System.currentTimeMillis()));
		System.out.println(replyVO);
		
		replyDAO.insertReply(replyVO);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("reply", replyVO);
		// 자바객체 -> JSON 문자열로 반환
		String strResponse = gson.toJson(map);
		
		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strResponse);
		
		
	}	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
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
}
