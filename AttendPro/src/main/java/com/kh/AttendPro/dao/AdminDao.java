package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.mapper.AdminMapper;
import com.kh.AttendPro.mapper.StatusMapper;
import com.kh.AttendPro.vo.PageVO;
import com.kh.AttendPro.vo.StatusVO;

@Repository
public class AdminDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private AdminMapper adminMapper;

	@Autowired
	private PasswordEncoder encoder;

	// 회원등록(암호화 추가)
	public boolean join(AdminDto adminDto) {
		// 암호화
		String rawPw = adminDto.getAdminPw();
		String encPw = encoder.encode(rawPw);
		adminDto.setAdminPw(encPw);
		
	    
		// JDBC
		String sql = "insert into admin(" + "admin_id, admin_pw, admin_no, admin_rank, admin_email"
				+ ") values(?, ?, ?, '일반 관리자', ?)";
		Object[] data = { adminDto.getAdminId(), adminDto.getAdminPw(), adminDto.getAdminNo(),
			adminDto.getAdminEmail() };
		 int rowsAffected = jdbcTemplate.update(sql, data);
		    return rowsAffected > 0;
	}
	// 목록
	public List<AdminDto> selectList() {
		String sql = "select * from admin order by admin_id desc";
		return jdbcTemplate.query(sql, adminMapper);
	}

	// 검색
	public List<AdminDto> selectList(String column, String keyword) {
		String sql = "select * from admin " + "where instr(#1, ?) > 0 " + "order by #1 asc, admin_id desc";

		sql = sql.replace("#1", column);
		Object[] data = { keyword };
		return jdbcTemplate.query(sql, adminMapper, data);
	}


	// 회원조회
	public AdminDto selectOne(String adminId) {
		String sql = "select * from admin where admin_id = ?";
		Object[] data = { adminId };
		List<AdminDto> list = jdbcTemplate.query(sql, adminMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	
	// 로그인 전용 상세조회
	public AdminDto selectOneWithPassword(String adminId, String adminPw) {
		String sql = "select * from admin where admin_id = ?";
		Object[] data = { adminId };
		List<AdminDto> list = jdbcTemplate.query(sql, adminMapper, data);
		if (list.isEmpty())
			return null;

		AdminDto adminDto = list.get(0);
		String storedEncPw = adminDto.getAdminPw();
		
		boolean isValid = encoder.matches(adminPw, /*adminDto.getAdminPw()*/storedEncPw);
		return isValid ? adminDto : null;
	}

	// 최종 로그인 시각 갱신
	public boolean updateAdminLogin(String adminId) {
		String sql = "update admin set admin_login=sysdate " + "where admin_id = ?";
		Object[] data = { adminId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 비밀번호 변경
	public boolean updateAdminPw(String adminId, String adminPw) {
		   String encPw = encoder.encode(adminPw);
		    String sql = "update admin set admin_pw=? where admin_id=?";
		Object[] data = { encPw, adminId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public List<AdminDto> selectListBypaging(PageVO pageVO) {
		if (pageVO.isSearch()) {
			String sql = "SELECT * FROM (" + "SELECT TMP.*, ROWNUM rn FROM (" + "SELECT * FROM admin " + "WHERE instr("
					+ pageVO.getColumn() + ", ?) > 0 " + "ORDER BY " + pageVO.getColumn() + " ASC" + ") TMP "
					+ ") WHERE rn BETWEEN ? AND ?";
			Object[] data = { pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, adminMapper, data);
		} else { // 목록
			String sql = "SELECT * FROM (" + "SELECT TMP.*, ROWNUM rn FROM (" + "SELECT * FROM admin" + ") TMP "
					+ ") WHERE rn BETWEEN ? AND ?";
			Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
			return jdbcTemplate.query(sql, adminMapper, data);
		}
	}

	public int countByPaging(PageVO pageVO) {
		if (pageVO.isSearch()) {
			String sql = "SELECT count(*) FROM admin WHERE instr(" + pageVO.getColumn() + ", ?) > 0";
			Object[] data = { pageVO.getKeyword() };
			return jdbcTemplate.queryForObject(sql, Integer.class, data);
		} else {
			String sql = "SELECT count(*) FROM admin";
			return jdbcTemplate.queryForObject(sql, Integer.class);
		}
	}

//	public boolean updateAdminBySysadmin(AdminDto adminDto) {
//		String sql = "update admin set" + "admin_no=?" + "admin_rank=?" + "admin_email=?" + "admin_login=?";
//		Object[] data = { adminDto.getAdminNo(), adminDto.getAdminRank(), adminDto.getAdminEmail(),
//				adminDto.getAdminLogin() };
//		return jdbcTemplate.update(sql, data) > 0;
//	}
	
	//(시스템관리자용) 관리자 정보수정
	public boolean updateAdminBySysadmin(AdminDto adminDto) {
	    String sql = "UPDATE admin SET "
	            + "admin_no=?, admin_rank=?, "
	            + "admin_email=? "
	            + "WHERE admin_id=?";
	    Object[] data = {
	        adminDto.getAdminNo(), 
	        adminDto.getAdminRank(), 
	        adminDto.getAdminEmail(), 
	        adminDto.getAdminId()
	    };
	    return jdbcTemplate.update(sql, data) > 0;
	}

	//(시스템관리자 전용) 관리자 정보삭제
	public boolean delete(String adminId) {
		String sql = "delete admin where admin_id = ?";
		Object[] data = { adminId };
		return jdbcTemplate.update(sql, data) > 0;
	}

	@Autowired
	private StatusMapper statusMapper;

	// 시스템관리자 데이터베이스현황 조회 status
	public List<StatusVO> statusByAdminRank() {
		// 쿼리 문자열에 각 절 사이에 공백 추가
		String sql = "SELECT admin_rank title, COUNT(*) cnt " + "FROM admin " + "GROUP BY admin_rank "
				+ "ORDER BY cnt DESC, title ASC";

		// 쿼리 실행 및 결과 반환
		return jdbcTemplate.query(sql, statusMapper);
	}
	
	//관리자 개인 정보 변경
	public boolean updateAdmin(AdminDto adminDto) {
		String sql = "update admin set "
							+ "admin_no=?,admin_email=? "
							+ "WHERE admin_id=?";
	    Object[] data = {
	        adminDto.getAdminNo(), 	       
	        adminDto.getAdminEmail(), 
	        adminDto.getAdminId()
	    };
		return jdbcTemplate.update(sql, data) > 0;
	}
}
