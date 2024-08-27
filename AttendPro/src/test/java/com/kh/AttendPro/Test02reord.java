package com.kh.AttendPro;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.AttendPro.dao.CompanyDao;
import com.kh.AttendPro.dao.RecordDao;
import com.kh.AttendPro.dao.WorkerDao;
import com.kh.AttendPro.dto.RecordDto;
import com.kh.AttendPro.mapper.RecordMapper;

@SpringBootTest
public class Test02reord {
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	RecordMapper recordMapper;
	
	@Autowired
	WorkerDao workerDao;
	
	@Autowired 
	CompanyDao companyDao;
	
	@Test
	public RecordDto selectOne(int workerNo) {
		workerNo=1;
			
		String sql = "select * from record where worker_no = ?";
		Object[] data = {workerNo};
		List<RecordDto> list = 	jdbcTemplate.query(sql, recordMapper, data);
		System.out.println("ㅌㅅㅌ");
		return list.isEmpty() ? null : list.get(0);
		
	}
	
	public void checkIn(int workerNo) {
		workerNo = 1;
		RecordDto recordDto = selectOne(workerNo);
		LocalTime companyIn = recordDto.getCompanyIn();
        
		LocalTime now = LocalDateTime.now().toLocalTime();
		
		if(now.isAfter(companyIn)) {
			//지각
			String sql = "update record set "
					+"worker_late = worker_late+1, "
					+"worker_in = sysdate "
					+ "where worker_no = ?";
			Object[] data = {workerNo};
			jdbcTemplate.update(sql, data);
		}
		else if(now.isBefore(companyIn)) {
			//정시
			String sql = "update record set"
					+"record_in = sysdate "
					+"where record_no = ?";
			Object[] data = {workerNo};
		}
		
		System.out.println("ㅌㅅㅌ");
	}
}
