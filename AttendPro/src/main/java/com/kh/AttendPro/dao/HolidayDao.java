package com.kh.AttendPro.dao;

import com.kh.AttendPro.dto.HolidayDto;
import com.kh.AttendPro.mapper.HolidayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date; // 데이터베이스와의 호환성을 위한 import
import java.util.List;

@Repository
public class HolidayDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private HolidayMapper holidayMapper; // 매퍼 주입

    // 공휴일 추가
    public void insert(HolidayDto holidayDto) {
        String sql = "INSERT INTO holiday (holiday_id, company_id, holiday_date) VALUES (holiday_seq.nextval, ?, ?)";
        Object[] data = {
            holidayDto.getCompanyId(),
            holidayDto.getHolidayDate()
        };
        jdbcTemplate.update(sql, data);
    }

    public void addHoliday(String companyId, Date holidayDate) {
        String sql = "INSERT INTO holiday (holiday_id, company_id, holiday_date) VALUES (holiday_seq.nextval, ?, ?)";
        jdbcTemplate.update(sql, companyId, holidayDate);
    }

    public void deleteHoliday(String companyId, java.sql.Date holidayDate) {
        String sql = "DELETE FROM holiday WHERE company_id = ? AND holiday_date = ?";
        jdbcTemplate.update(sql, companyId, holidayDate);
    }

 // 회사 ID에 따른 공휴일 조회
    public List<HolidayDto> selectByCompanyId(String companyId) {
        String sql = "SELECT * FROM holiday WHERE company_id = ?";
        Object[] data = {companyId};
        return jdbcTemplate.query(sql, holidayMapper, data);
    }
    
    //휴일만 조회
    public List<Date> selectHolidayDatesByCompanyId(String companyId) {
        String sql = "SELECT holiday_date FROM holiday WHERE company_id = ?";
        return jdbcTemplate.queryForList(sql, Date.class, companyId);
    }

}
