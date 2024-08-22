package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dto.CompanyDto;

@Service
public class CompanyMapper implements RowMapper<CompanyDto> {

	@Override
	public CompanyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CompanyDto companyDto = new CompanyDto();
		companyDto.setCompanyName(rs.getString("company_name"));
		companyDto.setCompanyInTime(rs.getDate("company_in_time"));
		companyDto.setCompanyOutTime(rs.getDate("company_out_time"));
		companyDto.setCompanyHolidayDate(rs.getDate("company_holiday_date"));
		return companyDto;//null 로 작성한 부분 companyDto로 수정
	}

}
