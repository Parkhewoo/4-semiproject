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
	public void join(AdminDto adminDto) {
		String sql = "insert into admin("
				+ "admin_id, admin_pw, admin_no) "
				+ "values(?, ?, ?)";
		Object[] data = {
				adminDto.getAdminId(), adminDto.getAdminPw() //차후 dto에 adminNo추가후 수정예정
		};
		jdbcTemplate.update(sql,data);
	}
	
	// 목록 
	public List<AdminDto> selectList(){
		String sql = "select "
						+ "admin_id, admin_pw, admin_no "
						+ "from admin order by admin_id desc";
		
		return jdbcTemplate.query(sql, adminMapper);					
	}
	
	//검색
	public List<AdminDto> selectList(String column, String keyword){
		String sql = "select "
						+ "admin_id, admin_pw, admin_no "
						+ "from admin where instr(#1, ?) > 0 "
						+ "order by admin_id desc";
		
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, adminMapper, data);
	}
}
