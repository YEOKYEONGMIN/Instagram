package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.domain.MemberVO;

public class MemberDAO {
	// 싱글톤(singleton) 클래스 설계 : 객체 한개만 공유해서 사용하기
	private static MemberDAO instance;

	public static MemberDAO getInstance() {
		if (instance == null) {
			instance = new MemberDAO();
		}
		return instance;
	}

	// 생성자를 private로 외부로부터 숨김
	private MemberDAO() {
	}
	// ========= 싱글톤 설계 완료 =========

	public int insert(MemberVO memberVO) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null; // sql문장객체 타입

		try {
			con = JdbcUtils.getConnection(); // 1단계, 2단계 수행 후 커넥션 가져옴
			// con.setAutoCommit(true); // 기본 커밋은 자동커밋으로 설정되있음.

			// 3단계. sql 생성
			String sql = "";
			sql = "INSERT INTO member (id, passwd, username, name, birthday) ";
			sql += "VALUES (?, ?, ?, ?, ?) ";
			// sql문장객체 준비
			pstmt = con.prepareStatement(sql);

			// pstmt의 ? 자리에 값 설정
			pstmt.setString(1, memberVO.getId());
			pstmt.setString(2, memberVO.getPasswd());
			pstmt.setString(3, memberVO.getUsername());
			pstmt.setString(4, memberVO.getName());
			pstmt.setString(5, memberVO.getBirthday());

			// 4단계. sql문 실행
			count = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return count;
	} // insert

	public int deleteById(String id) {
		int count = 0;

		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입

		try {
			con = JdbcUtils.getConnection();

			String sql = "DELETE FROM member WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			count = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return count;
	} // deleteById
	
	public int getCountById(String id) {
		int count = 0;
		
		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "SELECT count(*) AS cnt FROM member WHERE id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1); // rs.getInt("cnt")
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountById
	public int getCountByUsername(String username) {
		int count = 0;
		
		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		ResultSet rs = null;
		
		try {
			con = JdbcUtils.getConnection();
			
			String sql = "SELECT count(*) AS cnt FROM member WHERE username = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt(1); // rs.getInt("cnt")
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return count;
	} // getCountById

	public MemberVO getMemberById(String id) {
		MemberVO memberVO = null;

		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT * FROM member WHERE id = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));
				memberVO.setUsername(rs.getString("username"));
				memberVO.setWeb(rs.getString("web"));
				memberVO.setMemo(rs.getString("memo"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setProfileImg(rs.getString("profileImg"));
				memberVO.setBirthday(rs.getString("birthday"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return memberVO;
	} // getMemberById
	
	public MemberVO getMemberByUsername(String username) {
		MemberVO memberVO = null;

		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT * FROM member WHERE username = ?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, username);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));
				memberVO.setUsername(rs.getString("username"));
				memberVO.setWeb(rs.getString("web"));
				memberVO.setMemo(rs.getString("memo"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setProfileImg(rs.getString("profileImg"));
				memberVO.setBirthday(rs.getString("birthday"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return memberVO;
	} // getMemberById

	public List<MemberVO> getMembers() {
		List<MemberVO> list = new ArrayList<>();

		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		ResultSet rs = null;

		try {
			con = JdbcUtils.getConnection();

			String sql = "SELECT * FROM member ORDER BY id";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberVO memberVO = new MemberVO();
				memberVO.setId(rs.getString("id"));
				memberVO.setPasswd(rs.getString("passwd"));
				memberVO.setName(rs.getString("name"));
				memberVO.setUsername(rs.getString("username"));
				memberVO.setWeb(rs.getString("web"));
				memberVO.setMemo(rs.getString("memo"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setProfileImg(rs.getString("profileImg"));
				memberVO.setBirthday(rs.getString("birthday"));

				list.add(memberVO);
			} // while
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	} // getMembers
	public void updateById(MemberVO memberVO) {
		
		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		
		try {
			con = JdbcUtils.getConnection();
			StringBuilder sb = new StringBuilder();
			if (memberVO.getProfileImg() == null) {
				
				sb.append("UPDATE member ");
				sb.append(
						"SET name = ?, username = ?, web = ?, memo = ?, email = ?, phone = ?, gender = ? ");
				sb.append("WHERE id = ? ");

				pstmt = con.prepareStatement(sb.toString());
				pstmt.setString(1, memberVO.getName());
				pstmt.setString(2, memberVO.getUsername());
				pstmt.setString(3, memberVO.getWeb());
				pstmt.setString(4, memberVO.getMemo());
				pstmt.setString(5, memberVO.getEmail());
				pstmt.setString(6, memberVO.getPhone());
				pstmt.setString(7, memberVO.getGender());
				pstmt.setString(8, memberVO.getId());
			}else {
				sb.append("UPDATE member ");
				sb.append(
						"SET name = ?, username = ?, web = ?, memo = ?, email = ?, phone = ?, gender = ?, profileImg = ? ");
				sb.append("WHERE id = ? ");

				pstmt = con.prepareStatement(sb.toString());
				pstmt.setString(1, memberVO.getName());
				pstmt.setString(2, memberVO.getUsername());
				pstmt.setString(3, memberVO.getWeb());
				pstmt.setString(4, memberVO.getMemo());
				pstmt.setString(5, memberVO.getEmail());
				pstmt.setString(6, memberVO.getPhone());
				pstmt.setString(7, memberVO.getGender());
				pstmt.setString(8, memberVO.getProfileImg());
				pstmt.setString(9, memberVO.getId());
			}
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // updateById
	public void passChange(String id, String pass) {
		
		Connection con = null; // 접속
		PreparedStatement pstmt = null; // sql문장객체 타입
		
		try {
			con = JdbcUtils.getConnection();
			String sql = "";
			sql = "UPDATE member ";
			sql += "SET passwd = ? ";
			sql += "WHERE id = ? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pass);
			pstmt.setString(2, id);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
	} // passChange
}
