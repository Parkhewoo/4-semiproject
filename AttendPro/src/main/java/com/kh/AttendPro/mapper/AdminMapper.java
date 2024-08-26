package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dto.AdminDto;

@Service
public class AdminMapper implements RowMapper<AdminDto> {

	@Override
	public AdminDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AdminDto adminDto = new AdminDto();
		adminDto.setAdminId(rs.getString("admin_id"));
		adminDto.setAdminPw(rs.getString("admin_pw"));
		adminDto.setAdminNo(rs.getString("admin_no"));
		adminDto.setAdminRank(rs.getString("admin_rank"));
		adminDto.setAdminEmail(rs.getString("admin_email"));
		adminDto.setAdminLogin(rs.getDate("admin_login"));
		return adminDto; // null로 작성한 부분 adminDto로 수정
	}
	
}