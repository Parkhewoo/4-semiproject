package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
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
	
	//회원등록
	   public boolean join(AdminDto adminDto) {
	        String sql = "INSERT INTO admin (admin_id, admin_pw, admin_no, admin_rank, admin_email) "
	                   + "VALUES (?, ?, ?, '일반 관리자', ?)"; // '일반사원'으로 기본값 설정

	        Object[] data = {
	            adminDto.getAdminId(),
	            adminDto.getAdminPw(),
	            adminDto.getAdminNo(),
	            adminDto.getAdminEmail()
	        };

	        // 쿼리 실행 후 성공 여부 반환
	        return jdbcTemplate.update(sql, data) > 0;
	    }

	
	// 목록 
	public List<AdminDto> selectList(){
		String sql = "select * from admin order by admin_id desc";
		return jdbcTemplate.query(sql, adminMapper);					
	}
	
	//검색
	public List<AdminDto> selectList(String column, String keyword){
		String sql = "select * from admin "
						+ "where instr(#1, ?) > 0 "
						+ "order by #1 asc, admin_id desc";
		
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, adminMapper, data);
	}

	//회원조회
	public AdminDto selectOne(String adminId) {
		String sql = "select * from admin where admin_id = ?";
		Object[] data = {adminId};
		List<AdminDto> list = jdbcTemplate.query(sql, adminMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//최종 로그인 시각 갱신
	public boolean updateAdminLogin(String adminId) {
		String sql = "update admin set admin_login=sysdate "
						+ "where admin_id = ?";
		Object[] data = {adminId};
		return jdbcTemplate.update(sql, data) > 0;
	}
	//비밀번호 변경
	public boolean updateAdminPw(String adminId, String adminPw) {
	    String sql = "update admin set admin_pw=? where admin_id=?";
	    Object[] data = {adminPw, adminId};
	    return jdbcTemplate.update(sql, data) > 0;
	}


	public List<AdminDto> selectListBypaging(PageVO pageVO) {
	    if (pageVO.isSearch()) {
	        String sql = "SELECT * FROM ("
	                + "SELECT TMP.*, ROWNUM rn FROM ("
	                + "SELECT * FROM admin "
	                + "WHERE instr(" + pageVO.getColumn() + ", ?) > 0 "
	                + "ORDER BY " + pageVO.getColumn() + " ASC"
	                + ") TMP "
	                + ") WHERE rn BETWEEN ? AND ?";
	        Object[] data = {
	            pageVO.getKeyword(),
	            pageVO.getBeginRow(),
	            pageVO.getEndRow()
	        };
	        return jdbcTemplate.query(sql, adminMapper, data);
	    } else { // 목록
	        String sql = "SELECT * FROM ("
	                + "SELECT TMP.*, ROWNUM rn FROM ("
	                + "SELECT * FROM admin"
	                + ") TMP "
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
	

	public boolean updateAdminBySysadmin(AdminDto adminDto) {
		String sql = "update admin set"
				+ "admin_no=?"
				+ "admin_rank=?"
				+ "admin_email=?"
				+ "admin_login=?";
		Object[] data = {
				adminDto.getAdminNo(),
				adminDto.getAdminRank(),
				adminDto.getAdminEmail(),
				adminDto.getAdminLogin()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}



	public boolean delete(String adminId) {
		String sql = "delete admin where admin_id = ?";
		Object[] data = {adminId};
		return jdbcTemplate.update(sql, data)>0;
	}

	
	
	@Autowired
	private StatusMapper statusMapper;
	
	//시스템관리자 데이터베이스현황 조회 status
	public List<StatusVO> statusByAdminRank() {
	    // 쿼리 문자열에 각 절 사이에 공백 추가
	    String sql = "SELECT admin_rank title, COUNT(*) cnt "
	               + "FROM admin "
	               + "GROUP BY admin_rank "
	               + "ORDER BY cnt DESC, title ASC";

	    // 쿼리 실행 및 결과 반환
	    return jdbcTemplate.query(sql, statusMapper);
	}
}
