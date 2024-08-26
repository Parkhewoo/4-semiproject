package com.kh.AttendPro.dao;

import java.time.Instant;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.CompanyDto;
import com.kh.AttendPro.dto.WorkerDto;

@Repository
public class RecordDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	WorkerDao workerDao;
	
	@Autowired 
	CompanyDao companyDao;
	

	
	public void checkIn(String workerId) {
		
		LocalDateTime now = LocalDateTime.now();
		//workerDao 에서 select one method를 통해 company_in 
		WorkerDto workerDto = workerDao.selectOne(workerId);
//		adminId = workerDto.getAdminId();
		CompanyDto companyDto = companyDao.selectOne("");
		//java.util.Date를 Instant로 변환
        Instant instant = companyDto.getCompanyInTime().toInstant();
        // 3. Instant를 LocalDateTime으로 변환 (특정 타임존 사용)
        LocalDateTime companyIn = LocalDateTime.ofInstant(instant, null);
        
		//출퇴근으로 구별할지 in 시간으로 구별할지
		if(now.isAfter(companyIn)) {
			//지각
			String sql = "update record set "
					+"record_late = record_late+1, "
					+"record_in = sysdate "
					+ "where record_no = ?";
			Object[] data = {1};
			jdbcTemplate.update(sql, data);
		}
		else if(now.isBefore(companyIn)) {
			//정시
			String sql = "update record set"
					+"record_in = sysdate "
					+"where record_no = ?";
			Object[] data = {1};
		}
		
	}
	
	public void checkOut(String workerId) {
		
		LocalDateTime now = LocalDateTime.now();
		//workerDao 에서 select one method를 통해 company_in 
		WorkerDto workerDto = workerDao.selectOne(workerId);
//		adminId = workerDto.getAdminId();
		CompanyDto companyDto = companyDao.selectOne("");
		//java.util.Date를 Instant로 변환
        Instant instant = companyDto.getCompanyOutTime().toInstant();
        // Instant를 LocalDateTime으로 변환 
        LocalDateTime companyIn = LocalDateTime.ofInstant(instant, null);
        
        //당일에 찍힌 record_in기록이 있을경우
//        boolean isCome = 
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
