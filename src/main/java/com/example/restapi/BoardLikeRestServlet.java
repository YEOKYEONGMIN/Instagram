package com.example.restapi;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.domain.BoardLikeVO;
import com.example.domain.BoardVO;
import com.example.repository.AttachDAO;
import com.example.repository.BoardDAO;
import com.example.repository.BoardLikeDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
@WebServlet(urlPatterns = {"/api/boardLike/*"}, loadOnStartup = 1)
public class BoardLikeRestServlet extends HttpServlet {
private static final String BASE_URI = "/api/boardLike";
	
	private BoardLikeDAO boardLikeDAO = BoardLikeDAO.getInstance();
	private BoardDAO boardDAO = BoardDAO.getInstance();
	private Gson gson;
	public BoardLikeRestServlet() {
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
		String sbno = strArr[0];
		int bno = Integer.parseInt(sbno); 
		String username = strArr[1];
		System.out.println("bno : " + bno);
		System.out.println("username : "+username);
		BoardLikeVO boardLikeVO = new BoardLikeVO();
		boardLikeVO.setBno(bno);
		boardLikeVO.setUsername(username);
		if(boardLikeDAO.getboradUsernameCount(bno, username)==0) {
			boardLikeDAO.boardLike(boardLikeVO);
		}
		else if(boardLikeDAO.getboradUsernameCount(bno, username)==1) {
			if(boardLikeDAO.getLike(bno, username)==0) 
				boardLikeDAO.boardLike(bno,username);
			else
				boardLikeDAO.boardUnlike(bno, username);
		}
		int likecount = boardLikeDAO.getboardLikeCount(bno);
		boardDAO.updateLikecount(likecount, bno);
		int like = boardLikeDAO.getLike(bno, username);
		
		
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
