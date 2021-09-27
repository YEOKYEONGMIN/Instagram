package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.domain.BoardLikeVO;

public class BoardLikeDAO {
	private static BoardLikeDAO instance;
	
	public static BoardLikeDAO getInstance() {
		if (instance == null) {
			instance = new BoardLikeDAO();
		}
		return instance;
	}
	
	private BoardLikeDAO() {
	}
	
	public void boardLike(BoardLikeVO boardLikeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "INSERT INTO boardlike (username, bno, isLike) ";
			sql += "VALUES (?, ?, 1) ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, boardLikeVO.getUsername());
			pstmt.setInt(2, boardLikeVO.getBno());

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	public void boardLike(int bno, String username) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "UPDATE boardlike ";
			sql += "SET isLike = 1 ";
			sql += "WHERE bno = ? AND username = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, username);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	
	public void boardUnlike(int bno, String username) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "UPDATE boardlike ";
			sql += "SET isLike = 0 ";
			sql += "WHERE bno = ? AND username = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, username);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	public int getboardLikeCount(int bno) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			String sql = "";
			sql = "SELECT count(bno) as cnt ";
			sql += "FROM boardlike ";
			sql += "where isLike = 1 ";
			sql += "group by bno ";
			sql += "having bno = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("cnt");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	}
	public int getboradUsernameCount(int bno, String username) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "select count(*) as cnt ";
			sql += "from boardlike ";
			sql += "where bno= ? and username = ? ";
			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, username);

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
	}
	public int getLike(int bno, String username) {
		int like = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "select isLike ";
			sql += "from boardlike ";
			sql += "where bno= ? and username = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setString(2, username);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				like = rs.getInt("isLike");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		
		return like;
	}
	public void deleteBoardLikeByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM boardlike WHERE bno = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteBoardByNum
	
}
