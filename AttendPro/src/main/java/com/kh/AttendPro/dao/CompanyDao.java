package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.CompanyDto;
import com.kh.AttendPro.mapper.CompanyMapper;

@Repository
public class CompanyDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private CompanyMapper companyMapper;
	
	//
	public void insert(CompanyDto companyDto) {
			String sql = "insert into company("
					+ "company_id,company_name,company_in_time,company_out_time,company_holiday"
					+ ") values(?,?,?,?,?)";
			Object[] data = {
					companyDto.getCompanyId(),companyDto.getCompanyName(),companyDto.getCompanyInTime(),
					companyDto.getCompanyOutTime(),companyDto.getCompanyHolidayDate()
			};
			jdbcTemplate.update(sql,data);
	}

	//상세
	public CompanyDto selectOne(String companyId) {
		String sql = "select * from compnay where company_id = ?";
		Object[] data = {companyId};
		List<CompanyDto> list = jdbcTemplate.query(sql,companyMapper,data);
		return list.isEmpty() ? null:list.get(0);
	}
	//수정
	public boolean update(CompanyDto companyDto) {
		String sql = "update company set"
				+ "company_name=?,company_in_time=?,"
				+ "company_out_time=?,company_holiday=?"
				+ "where company_id=?";
		Object[] data = {
				companyDto.getCompanyName(),companyDto.getCompanyInTime(),
				companyDto.getCompanyOutTime(),companyDto.getCompanyHolidayDate()
		};
		return jdbcTemplate.update(sql,data)>0;
	}
	
}
