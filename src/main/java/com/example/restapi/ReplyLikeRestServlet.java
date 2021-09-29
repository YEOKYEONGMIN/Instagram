package com.example.restapi;

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

import com.example.domain.BoardLikeVO;
import com.example.domain.BoardVO;
import com.example.domain.ReplyLikeVO;
import com.example.repository.AttachDAO;
import com.example.repository.BoardDAO;
import com.example.repository.BoardLikeDAO;
import com.example.repository.ReplyDAO;
import com.example.repository.ReplyLikeDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
@WebServlet(urlPatterns = {"/api/ReplyLike/*"}, loadOnStartup = 1)
public class ReplyLikeRestServlet extends HttpServlet {
private static final String BASE_URI = "/api/ReplyLike";
	
	private ReplyLikeDAO replyLikeDAO = ReplyLikeDAO.getInstance();
	private ReplyDAO replyDAO = ReplyDAO.getInstance();
	private Gson gson;
	public ReplyLikeRestServlet() {
		GsonBuilder builder = new GsonBuilder();
		gson = builder.create();
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
	

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestURI = request.getRequestURI();
		String str = requestURI.substring(BASE_URI.length());
		str = str.substring(1);
		String[] strArr = str.split("/");
		String snum = strArr[0];
		int num = Integer.parseInt(snum); 
		String username = strArr[1];
		String sbno = strArr[2];
		int bno = Integer.parseInt(sbno);
		System.out.println("num : " + num);
		System.out.println("username : "+username);
		System.out.println("bno : "+bno);
		ReplyLikeVO replyLikeVO = new ReplyLikeVO();
		replyLikeVO.setReplylikeNum(num);
		replyLikeVO.setReplylikeUsername(username);
		replyLikeVO.setReplylikeRegDate(new Timestamp(System.currentTimeMillis()));
		replyLikeVO.setBno(bno);
		if(replyLikeDAO.getreplyUsernameCount(num, username)==1) {
			Timestamp date = (new Timestamp(System.currentTimeMillis()));
			if(replyLikeDAO.getLike(num, username)==0) 
				replyLikeDAO.replyLike(num,username,date);
			else
				replyLikeDAO.replyUnlike(num, username);
		}
		if(replyLikeDAO.getreplyUsernameCount(num, username)==0) {
			replyLikeDAO.replyLike(replyLikeVO);
		}
		
		int likecount = replyLikeDAO.getreplyLikeCount(num);
		replyDAO.updateLikecount(likecount, num);
		int like = replyLikeDAO.getLike(num, username);
		
		
		// 응답데이터 주기
		Map<String, Object> map = new HashMap<>();
		map.put("result", "success");
		map.put("likecount", likecount);
		String strResponse = gson.toJson(map);
		
		// 클라이언트 쪽으로 출력하기
		sendResponse(response, strResponse);
		
	}

	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
	}
	
	private void sendResponse(HttpServletResponse response, String json) throws IOException {
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
	} // sendResponse
	
}
