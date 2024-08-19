package com.kh.AttendPro.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.mapper.AdminMapper;

@Repository
public class RegistDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AdminMapper adminMapper;
	
	//회원등록
	public void regist(AdminDto adminDto) {
		String sql = "insert into admin("
				+ "admin_id, admin_pw) "
				+ "values(?,?)";
		Object[] data = {
				adminDto.getAdminId(),adminDto.getAdminPw()
		};
		jdbcTemplate.update(sql,data);
	}
}
