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
	    String sql = "INSERT INTO company("
	            + "company_id, company_ceo, company_name, "
	            + "company_in, company_out, "
	            + "company_post, company_address1, company_address2"
	            + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	    
	    Object[] data = {
	        companyDto.getCompanyId(),
	        companyDto.getCompanyCeo(),
	        companyDto.getCompanyName(),
	        java.sql.Time.valueOf(companyDto.getCompanyIn()),  // LocalTime to Time
	        java.sql.Time.valueOf(companyDto.getCompanyOut()), // LocalTime to Time
	        companyDto.getCompanyPost(),
	        companyDto.getCompanyAddress1(),
	        companyDto.getCompanyAddress2()
	    };
	    jdbcTemplate.update(sql, data);
	}

	//상세
	public CompanyDto selectOne(String companyId) {
	    String sql = "select * from company where company_id = ?";
	    Object[] data = {companyId};
	    List<CompanyDto> list = jdbcTemplate.query(sql, companyMapper, data);
	    return list.isEmpty() ? null : list.get(0);
	}

	//수정
	public boolean update(CompanyDto companyDto) {
	    String sql = "UPDATE company SET company_ceo=?,"
	    		+ "company_name=?, company_in=?,"
	    		+ "company_out=?,"
	    		+ "company_post=?, company_address1=?,"
	    		+ "company_address2=? WHERE company_id=?";
	    Object[] data = {
	    	companyDto.getCompanyCeo(),
	        companyDto.getCompanyName(),
	        companyDto.getCompanyIn(),
	        companyDto.getCompanyOut(),
	        companyDto.getCompanyPost(),
	        companyDto.getCompanyAddress1(),
	        companyDto.getCompanyAddress2(),
	        companyDto.getCompanyId()
	    };
	    return jdbcTemplate.update(sql, data) > 0;
	}

	
}
