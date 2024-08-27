package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dto.RecordDto;

@Service
public class RecordMapper implements RowMapper<RecordDto>{

	@Override
	public RecordDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		RecordDto recordDto = new RecordDto();
	        
	        recordDto.setCompanyId(rs.getString("company_id"));
	        recordDto.setCompanyName(rs.getString("company_name"));
	        
	        // Convert SQL Time to LocalTime
	        Time timeIn = rs.getTime("company_in");
	        if (timeIn != null) {
	        	recordDto.setCompanyIn(timeIn.toLocalTime());
	        }
	        
	        Time timeOut = rs.getTime("company_out");
	        if (timeOut != null) {
	        	recordDto.setCompanyOut(timeOut.toLocalTime());
	        }
	        
	        recordDto.setCompanyHoliday(rs.getDate("company_holiday"));
	        recordDto.setWorkerNo(rs.getInt("worker_no"));
	        recordDto.setWorkerAttend(rs.getInt("worker_attend"));
	        recordDto.setWorkerAbsent(rs.getInt("worker_absent"));
	        recordDto.setWorkerLate(rs.getInt("worker_late"));
	        recordDto.setWorkerLeave(rs.getInt("worker_leave"));
	        recordDto.setWorkerIn(rs.getDate("worker_in"));
	        recordDto.setWorkerOut(rs.getDate("worker_out"));
	   
	        return recordDto;
	}

}
