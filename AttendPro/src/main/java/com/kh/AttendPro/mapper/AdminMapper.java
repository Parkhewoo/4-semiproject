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
		adminDto.setAdminPw(rs.getString("admin_password"));
		return null;
	}

}
