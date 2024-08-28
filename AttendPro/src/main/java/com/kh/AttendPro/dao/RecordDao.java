package com.kh.AttendPro.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.RecordDto;
import com.kh.AttendPro.mapper.RecordMapper;

@Repository
public class RecordDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	RecordMapper recordMapper;
	
	//workerNo를 통해서 RecordDto를 반환
	public RecordDto selectOne(int workerNo) {
		String sql = "select * from record where worker_no = ?";
		Object[] data = {workerNo};
		List<RecordDto> list = 	jdbcTemplate.query(sql, recordMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//출근
	public void checkIn(int workerNo) {
		String sql = "insert into record("
				+"worker_no, worker_in, admin_id"
				+") values"
				+"(?, sysdate, "
				+ "(SELECT admin_id FROM worker WHERE WORKER_NO = ?))";
		Object[] data = {workerNo, workerNo};
		jdbcTemplate.update(sql, data);
	}
	
	//퇴근
		public void checkOut(int workerNo) {
			//당일 출근기록이 있을때만 시행 - > update 
			boolean isCome = getIsCome(workerNo);
			if(isCome) {
				String sql = "update record "
						+ "set worker_out = sysdate "
						+"where worker_no = ? "
						+"and worker_in = 오늘날짜"; 
				Object[] data = {workerNo};
				jdbcTemplate.update(sql, data);
			}
			else return;
		}
	
	//당일 출근 기록 검사 메소드
	public boolean getIsCome(int workerNo) {
		RecordDto recordDto = selectOne(workerNo);
		Date workerIn = recordDto.getWorkerIn();
		Date today = new Date(System.currentTimeMillis());
		
		// LocalDate로 변환하여 년-월-일만 비교
	    LocalDate workerInDate = workerIn.toLocalDate();
	    LocalDate todayDate = today.toLocalDate();
	    boolean isCome = workerInDate.equals(todayDate);

	    return isCome;
	}
	
	public void getStatus(int workerNo) {
		//vo로 세팅
		String sqlForLate = "SELECT "
				+ "COUNT(*) AS late_count "
				+ "FROM "
				+ "record_company_view "
				+ "WHERE "
				+ "r.worker_no = ? "
				+ "AND r.company_in < r.worker_in";
		
		String sqlForLeave = "SELECT "
				+ "COUNT(*) AS leave_count "
				+ "FROM "
				+ "record_company_view "
				+ "WHERE "
				+ "r.worker_no = ? "
				+ "AND r.company_out > r.worker_out";
		
		Object[] data = {workerNo};
		
		int late = jdbcTemplate.queryForObject(sqlForLate, int.class,data);
		int leave = jdbcTemplate.update(sqlForLeave, int.class, data);
	}
	
	

	
}
