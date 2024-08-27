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
	        recordDto.setWorkerNo(rs.getInt("worker_no"));
	        recordDto.setAdminId(rs.getString("admin_id"));
	        recordDto.setWorkerIn(rs.getDate("worker_in"));
	        recordDto.setWorkerOut(rs.getDate("worker_out"));
	        return recordDto;
	}

}
