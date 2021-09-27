package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import com.example.domain.ReplyLikeVO;

public class ReplyLikeDAO {
	private static ReplyLikeDAO instance;
	
	public static ReplyLikeDAO getInstance() {
		if (instance == null) {
			instance = new ReplyLikeDAO();
		}
		return instance;
	}
	
	private ReplyLikeDAO() {
	}
	
	public void replyLike(ReplyLikeVO replyLikeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "INSERT INTO replylike (replylike_username, replylike_num, replylike_like, replylike_regDate, bno) ";
			sql += "VALUES (?, ?, 1, ?, ?) ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, replyLikeVO.getReplylikeUsername());
			pstmt.setInt(2, replyLikeVO.getReplylikeNum());
			pstmt.setTimestamp(3, replyLikeVO.getReplylikeRegDate());
			pstmt.setInt(4, replyLikeVO.getBno());

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	public void replyLike(int num, String username,Timestamp date) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "UPDATE replyLike ";
			sql += "SET replylike_like = 1 , replylike_regDate = ? ";
			sql += "WHERE replylike_num = ? AND replylike_username = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setTimestamp(1, date);
			pstmt.setInt(2, num);
			pstmt.setString(3, username);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	
	public void replyUnlike(int num, String username) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "UPDATE replyLike ";
			sql += "SET replylike_like = 0 ";
			sql += "WHERE replylike_num = ? AND replylike_username = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, username);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	public int getreplyLikeCount(int num) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			String sql = "";
			sql = "SELECT count(*) as cnt ";
			sql += "FROM replyLike ";
			sql += "where replylike_like = 1 ";
			sql += "group by replylike_num ";
			sql += "having replylike_num = ? ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

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
	public int getreplyUsernameCount(int num, String username) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "select count(*) as cnt ";
			sql += "from replyLike ";
			sql += "where replylike_num= ? and replylike_username = ? ";
			
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
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
	public int getLike(int num, String username) {
		int like = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "select replylike_like ";
			sql += "from replyLike ";
			sql += "where replylike_num= ? and replylike_username = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, username);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				like = rs.getInt("replylike_like");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		
		return like;
	}
	
	public void deleteReplyLikeByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM replylike WHERE bno = ?";

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
