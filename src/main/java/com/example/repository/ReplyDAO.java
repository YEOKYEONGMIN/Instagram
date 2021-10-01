package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.BoardVO;
import com.example.domain.ReplyVO;

public class ReplyDAO {
	private static ReplyDAO instance;
	
	public static ReplyDAO getInstance() {
		if (instance == null) {
			instance = new ReplyDAO();
		}
		return instance;
	}
	private ReplyDAO() {
	}
	// SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM reply
		public int getNextnum() {
			int num = 0;

			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				con = JdbcUtils.getConnection();

				String sql = "SELECT IFNULL(MAX(num), 0) + 1 AS nextnum FROM reply";

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
	public void insertReply(ReplyVO replyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "INSERT INTO reply (num, reply_bno, reply_username, reply_comment, reply_likecount, reply_regDate) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?) ";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyVO.getNum());
			pstmt.setInt(2,replyVO.getReplyBno());
			pstmt.setString(3,replyVO.getReplyUsername());
			pstmt.setString(4,replyVO.getReplyComment());
			pstmt.setInt(5,replyVO.getReplyLikecount());
			pstmt.setTimestamp(6,replyVO.getReplyRegDate());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	}
	public List<ReplyVO> getReply(int replyBno) {
		List<ReplyVO> list = new ArrayList<>();
		ReplyVO replyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "";
			sql = "SELECT * ";
			sql += "FROM reply ";
			sql += "WHERE reply_bno = ? ";
			sql += "order by num ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyBno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				replyVO = new ReplyVO();
				replyVO.setNum(rs.getInt("num"));
				replyVO.setReplyBno(rs.getInt("reply_bno"));;
				replyVO.setReplyUsername(rs.getString("reply_username"));
				replyVO.setReplyComment(rs.getString("reply_comment"));
				replyVO.setReplyLikecount(rs.getInt("reply_likecount"));
				replyVO.setReplyRegDate(rs.getTimestamp("reply_regDate"));
				list.add(replyVO);
			} // if
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getBoard
	public int getReplyCount(int replyBno) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			String sql = "";
			sql = "select count(*) as cnt ";
			sql += "FROM reply ";
			sql += "group by reply_bno ";
			sql += "having reply_bno = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyBno);

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
	
	public void updateLikecount(int like, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "";
			sql = "UPDATE reply ";
			sql += "SET reply_likecount = ? ";
			sql += "WHERE num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, like);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		
	}
	public void deleteReplyByBno(int Bno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM reply WHERE reply_bno = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Bno);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteBoardByBno
	
	public void deleteReplyByNum(int Num) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM reply WHERE num = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // deleteBoardByNum
	
}
