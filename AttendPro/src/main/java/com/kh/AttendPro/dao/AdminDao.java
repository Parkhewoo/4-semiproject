package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.mapper.AdminMapper;


@Repository
public class AdminDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AdminMapper adminMapper;
	
	//회원등록
	   public boolean join(AdminDto adminDto) {
	        String sql = "INSERT INTO admin (admin_id, admin_pw, admin_no, admin_rank, admin_email) "
	                   + "VALUES (?, ?, ?, '일반사원', ?)"; // '일반사원'으로 기본값 설정

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

	
}
