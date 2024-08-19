package com.kh.AttendPro.dao;

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
	public void regist(AdminDto adminDto) {
		String sql = "insert into admin("
				+ "admin_id, admin_pw, admin_no) "
				+ "values(?, ?, ?)";
		Object[] data = {
				adminDto.getAdminId(), adminDto.getAdminPw() //차후 dto에 adminNo추가후 수정예정
		};
		jdbcTemplate.update(sql,data);
	}
}
