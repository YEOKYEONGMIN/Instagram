package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.example.domain.BoardVO;

public class BoardDAO {

	private static BoardDAO instance;

	public static BoardDAO getInstance() {
		if (instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	private BoardDAO() {
	}

	// board 테이블 모든 레코드 삭제
	public void deleteAll() {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM board";

			pstmt = con.prepareStatement(sql);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteAll

	public void deleteBoardByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM board WHERE num = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteBoardByNum

	// 전체글개수 가져오기
	public int getCountAll() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT COUNT(*) AS cnt FROM board";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountAll
	
	

	// SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM board
	public int getNextnum() {
		int num = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM board";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				num = rs.getInt("nextnum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return num;
	} // getNextnum

	// 주글쓰기
	public void addBoard(BoardVO boardVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "INSERT INTO board (num, username,  content, like, regDate, ipaddr, location) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, boardVO.getNum());
			pstmt.setString(2, boardVO.getUsername());
			pstmt.setString(3, boardVO.getContent());
			pstmt.setInt(4, boardVO.getLike());
			pstmt.setTimestamp(5, boardVO.getRegDate());
			pstmt.setString(6, boardVO.getIpaddr());
			pstmt.setString(7, boardVO.getLocation());
			// 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // addBoard

	public List<BoardVO> getBoards() {
		List<BoardVO> list = new ArrayList<>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM board ";
			sql += "ORDER BY num DESC ";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardVO boardVO = new BoardVO();
				boardVO.setNum(rs.getInt("num"));
				boardVO.setUsername(rs.getString("username"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setLike(rs.getInt("like"));
				boardVO.setRegDate(rs.getTimestamp("regDate"));
				boardVO.setIpaddr(rs.getString("ipaddr"));
				boardVO.setLocation(rs.getString("location"));
				list.add(boardVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getBoards

	

	public BoardVO getBoard(int num) {
		BoardVO boardVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM board ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				boardVO = new BoardVO();
				boardVO.setNum(rs.getInt("num"));
				boardVO.setUsername(rs.getString("username"));
				boardVO.setContent(rs.getString("content"));
				boardVO.setLike(rs.getInt("like"));
				boardVO.setRegDate(rs.getTimestamp("regDate"));
				boardVO.setIpaddr(rs.getString("ipaddr"));
				boardVO.setLocation(rs.getString("location"));
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return boardVO;
	} // getBoard

	// 조회수 1 증가시키는 메소드
	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE board ";
			sql += "SET readcount = readcount + 1 ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateReadcount

	// 게시글 수정하기
	public void updateBoard(BoardVO boardVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "UPDATE board ";
			sql += "SET subject = ?, content = ?, ipaddr = ?, location = ? ";
			sql += "WHERE num = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(2, boardVO.getContent());
			pstmt.setString(3, boardVO.getIpaddr());
			pstmt.setString(4, boardVO.getLocation());
			pstmt.setInt(5, boardVO.getNum());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateBoard

	
	
	
	
	
	
	
}
