package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;
import com.kh.AttendPro.dto.WorkerDto;

@Component
public class WorkerMapper implements RowMapper<WorkerDto> {

    @Override
    public WorkerDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        WorkerDto workerDto = new WorkerDto();
        workerDto.setWorkerNo(rs.getInt("worker_no"));
        workerDto.setWorkerPw(rs.getString("worker_pw"));
        workerDto.setWorkerName(rs.getString("worker_name"));
        workerDto.setWorkerAttend(rs.getInt("worker_attend"));
        workerDto.setWorkerAbsent(rs.getInt("worker_absent"));
        workerDto.setWorkerLate(rs.getInt("worker_late"));
        workerDto.setWorkerLeave(rs.getInt("worker_leave"));
        workerDto.setWorkerJoin(rs.getDate("worker_join"));  // DATE 타입
        workerDto.setWorkerRank(rs.getString("worker_rank"));
        workerDto.setWorkerBirthday(rs.getDate("worker_birthday"));  // DATE 타입
        workerDto.setWorkerContact(rs.getString("worker_contact"));
        workerDto.setWorkerEmail(rs.getString("worker_email"));
        workerDto.setWorkerPost(rs.getString("worker_post"));
        workerDto.setWorkerAddress1(rs.getString("worker_address1"));
        workerDto.setWorkerAddress2(rs.getString("worker_address2"));
        return workerDto;
    }
}
