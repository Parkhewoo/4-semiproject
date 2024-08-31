package com.kh.AttendPro.dao;

import java.time.YearMonth;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.RecordDto;
import com.kh.AttendPro.mapper.RecordMapper;
import com.kh.AttendPro.vo.AttendanceVO;

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
				String sql ="UPDATE record "
						+"SET worker_out = SYSDATE "
						+"WHERE worker_no = ? "
						+"AND worker_in = ( "
						+"SELECT MAX(worker_in) "
						+"FROM record "
						+"WHERE worker_no = ?)";
				Object[] data = {workerNo, workerNo};
				jdbcTemplate.update(sql, data);			
		}
	
	//당일 출근 기록 검사 메소드
	public boolean getIsCome(int workerNo) {
		//sql 구문과 jdbc를 통해 당일 출근 기록이 있는지 검사 후 값을 반환
		//int값을 반환 후 그 값을 통해 판단
		String sql = "select count(*) from record "
				+ "where worker_no= ? and "
				+ "TRUNC(worker_in) = TRUNC(SYSDATE)";
	
		Object[] data = {workerNo};
	    boolean isCome = jdbcTemplate.queryForObject(sql, int.class, data) > 0;
	    return isCome;
	}
	
	//근태 기록 조회 (누적)
	public AttendanceVO selectAttendance(int workerNo) {
		AttendanceVO attendanceVO = new AttendanceVO();
		Object[] data = {workerNo};
		
		//출근 횟수를 조회하는 sql
	    String sqlForAttend = "SELECT count(worker_out)"
				 +" FROM attendance WHERE worker_no = ?";
	    int attend = jdbcTemplate.queryForObject(sqlForAttend, int.class, data);
	  	attendanceVO.setAttend(attend);
		
	    //지각 횟수를 조회하는 sql
	    String sqlForLate = "SELECT COUNT(*) "
	            + "FROM attendance "
	            + "WHERE worker_no = ? "
	            + "AND to_char(company_in, 'HH24:MI:SS') < to_char(worker_in, 'HH24:MI:SS')";
	    int late = jdbcTemplate.queryForObject(sqlForLate, int.class, data);
	  	attendanceVO.setLate(late);

//	  //조퇴 횟수를 조회하는 sql
	    String sqlForLeave = "SELECT COUNT(*) "
	    		+"FROM attendance "
	    		+"WHERE worker_no = ? "
	    		+"AND TO_CHAR(company_out, 'HH24:MI:SS') "
	    		+ "> TO_CHAR(worker_out, 'HH24:MI:SS') ";
	   int leave = jdbcTemplate.queryForObject(sqlForLeave, int.class, data);
	   attendanceVO.setLeave(leave);
	   
	  //결근 횟수를 조회하는 sql
	    //평일이면서 공휴일이 아니면서 worker_out = null
	    //holidayStatus 회사 공휴일, 지정 출퇴근 시각, worker_out 여부 
//	    String sqlForAbsent = "select count(*) "
//	    		+ "from status "
//	    		+ "where worker_no = ?"
//	    		+"AND ";

	    
	    return attendanceVO;
	}
	
	
	//근태기록 조회(달별)
	public AttendanceVO selectAttendanceMonthly(int workerNo,  YearMonth month) {
		AttendanceVO attendanceVO = new AttendanceVO();

	    // 연도와 월을 'YYYY-MM' 형식으로 변환
	    String monthString = month.toString(); // "2024-08" 형식

	    Object[] data = {workerNo, monthString};
		
		String sqlForAttend = "SELECT count(worker_out)"
				 +" FROM attendance WHERE worker_no = ?"
				 +" AND TO_CHAR(worker_out, 'YYYY-MM') = ?";
		int attend = jdbcTemplate.queryForObject(sqlForAttend, int.class, data);
		attendanceVO.setAttend(attend);
		
		String sqlForLate = "SELECT COUNT(*)"
				+" FROM attendance"
				+" WHERE worker_no = ?"
				+" AND TO_CHAR(company_in, 'HH24:MI:SS') < TO_CHAR(worker_in, 'HH24:MI:SS')"
				+" AND TO_CHAR(worker_out, 'YYYY-MM') = ?";
		int late = jdbcTemplate.queryForObject(sqlForLate, int.class, data);
		attendanceVO.setLate(late);
		
		String sqlForLeave = "SELECT COUNT(*)"
				+" FROM attendance"
				+" WHERE worker_no = ?"
				+" AND TO_CHAR(company_out, 'HH24:MI:SS') > TO_CHAR(worker_out, 'HH24:MI:SS')"
				+" AND TO_CHAR(worker_out, 'YYYY-MM') = ?";
		int leave = jdbcTemplate.queryForObject(sqlForLeave, int.class, data);
		attendanceVO.setLeave(leave);
		
		
		String sqlForAbsent = "";
		int absent = jdbcTemplate.queryForObject(sqlForAbsent, int.class, data);
		attendanceVO.setAbsent(absent);
		
		return attendanceVO;
	}

	public AttendanceVO selectAttendanceVOYearly(int workerNo, int year) {
		AttendanceVO attendanceVO = new AttendanceVO();
		Object[] data = {workerNo, year};
		
		String sqlForAttend = "SELECT count(worker_out)"
				 +" FROM attendance WHERE worker_no = ?"
				 +" AND TO_CHAR(worker_out, 'YYYY') = ?";
		int attend = jdbcTemplate.queryForObject(sqlForAttend, int.class, data);
		attendanceVO.setAttend(attend);
		
		String sqlForLate = "SELECT COUNT(*)"
				+" FROM attendance"
				+" WHERE worker_no = ?"
				+" AND TO_CHAR(company_in, 'HH24:MI:SS') < TO_CHAR(worker_in, 'HH24:MI:SS')"
				+" AND TO_CHAR(worker_out, 'YYYY') = ?";
		int late = jdbcTemplate.queryForObject(sqlForLate, int.class, data);
		attendanceVO.setLate(late);
		
		String sqlForLeave = "SELECT COUNT(*)"
				+" FROM attendance"
				+" WHERE worker_no = ?"
				+" AND TO_CHAR(company_out, 'HH24:MI:SS') > TO_CHAR(worker_out, 'HH24:MI:SS')"
				+" AND TO_CHAR(worker_out, 'YYYY') = ?";
		int leave = jdbcTemplate.queryForObject(sqlForLeave, int.class, data);
		attendanceVO.setLeave(leave);
		
		
		String sqlForAbsent = "";
		int absent = jdbcTemplate.queryForObject(sqlForAbsent, int.class, data);
		attendanceVO.setAbsent(absent);
		
		
		return attendanceVO;
	}
	
	//구문과 키워드에 따라 달별 statusVO를 출력하는 메소드
//	public AttendanceVO getStatusVO(String title, String sql, int workerNo){
//		AttendanceVO attendanceVO = new AttendanceVO();
//		
//		Object[] data = {workerNo, };
//		int cnt = jdbcTemplate.queryForObject(sql, int.class, data);
//		attendanceVO.setTitle(title);
//		attendanceVO.setCnt(cnt);
//		return statusVO;
//	}
//	
	

	
}
