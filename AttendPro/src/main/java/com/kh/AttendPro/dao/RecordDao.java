package com.kh.AttendPro.dao;

import java.sql.Date;
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
		RecordDto recordDto = selectOne(workerNo);
		LocalTime companyIn = recordDto.getCompanyIn();
		//현재시각, db 이동을 최소화 하기 위해 workerIn 데이터 사용 x
		LocalTime now = LocalDateTime.now().toLocalTime(); 
		
		//지각
		if(now.isAfter(companyIn)) {
			String sql = "update record set "
					+"worker_late = worker_late+1, "
					+"worker_in = sysdate "
					+ "where worker_no = ?";
			Object[] data = {workerNo};
			jdbcTemplate.update(sql, data);
		}
		//정시
		else if(now.isBefore(companyIn)) {
			String sql = "update record set"
					+"record_in = sysdate "
					+"where record_no = ?";
			Object[] data = {workerNo};
		}
		else return;
	}
	
	//퇴근
	public void checkOut(int workerNo) {
		
		RecordDto recordDto = selectOne(workerNo);
		LocalTime companyOut = recordDto.getCompanyOut();
        
		LocalTime now = LocalDateTime.now().toLocalTime();
        
		Date workerIn = recordDto.getWorkerIn();
		boolean isCome = false;
		
        //당일에 찍힌 record_in기록이 있을경우 구문 시행
		//퇴근시간 보다 이를 경우 조퇴, 퇴근시간 이후일 경우 정시퇴근
		//결근 검사는 11시 59분마다 이루어져야 함 
		
//        if(){
//        	
//        }
//        else if(){
//        	
//        }
		String sql="update record set"
				+ "record_out = sysdate "
				+ "where record_no = ?";
		Object[] data = {1};
		jdbcTemplate.update(sql, data);
	}
		
//		public RecordDto selectRecordIn(String workerId) {
//			String sql = "select record_in from record "
//					+ " where worker_id = ?";
//			Object[] data = {workerId};
//			jdbcTemplate.update(sql, data);
//			return ;
//		}
	
}
