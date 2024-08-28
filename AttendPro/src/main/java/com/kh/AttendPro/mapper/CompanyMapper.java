package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import com.kh.AttendPro.dto.CompanyDto;

@Service
public class CompanyMapper implements RowMapper<CompanyDto> {

    @Override
    public CompanyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        CompanyDto companyDto = new CompanyDto();
        companyDto.setCompanyId(rs.getString("company_id"));
        companyDto.setCompanyName(rs.getString("company_name"));
        Time timeInSql = rs.getTime("company_in");
        companyDto.setCompanyIn(timeInSql.toLocalTime());
        Time timeOutSql = rs.getTime("company_out");
        companyDto.setCompanyOut(timeOutSql.toLocalTime());
        companyDto.setCompanyHoliday(rs.getDate("company_holiday")); // 수정된 부분
        return companyDto;
    }
}
