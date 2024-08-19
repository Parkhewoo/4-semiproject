package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dto.WorkerDto;

@Service
public class WorkerMapper implements RowMapper<WorkerDto> {

	@Override
	public WorkerDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		WorkerDto workerDto = new WorkerDto();
		workerDto.setWorkerNo(rs.getInt("worker_no"));
		workerDto.setWorkerName(rs.getString("worker_name"));
		workerDto.setWorkerAttend(rs.getInt("worker_attend"));
		workerDto.setWorkerAbsent(rs.getInt("worker_absent"));
		workerDto.setWorkerLate(rs.getInt("worker_late"));
		workerDto.setWorkerLeave(rs.getInt("worker_leave"));
		workerDto.setWorkerJoinDate(rs.getString("worker_join_date"));
		return workerDto;
	}

}
