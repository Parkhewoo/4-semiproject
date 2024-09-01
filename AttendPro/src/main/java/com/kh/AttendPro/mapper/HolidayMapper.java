package com.kh.AttendPro.mapper;

import com.kh.AttendPro.dto.HolidayDto;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;

@Service
public class HolidayMapper implements RowMapper<HolidayDto> {

    @Override
    public HolidayDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        HolidayDto holidayDto = new HolidayDto();
        holidayDto.setHolidayDate(rs.getDate("holiday_date")); // 날짜를 가져오는 부분
        holidayDto.setCompanyId(rs.getString("company_id")); // 회사 ID를 가져오는 부분
        holidayDto.setHolidayId(rs.getInt("holiday_id")); // 휴일 ID를 가져오는 부분
        
        return holidayDto;
    }

}
