package com.kh.AttendPro.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
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
	
	@Autowired
	WorkerDao workerDao;
	
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
	            + "AND to_char(company_in, 'HH24:MI:SS') < to_char(worker_in, 'HH24:MI:SS')"
	            +" AND worker_out is not null";
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
		
		
//		String sqlForAbsent = "";
//		int absent = jdbcTemplate.queryForObject(sqlForAbsent, int.class, data);
//		attendanceVO.setAbsent(absent);
//		
		return attendanceVO;
	}

	public AttendanceVO selectAttendanceYearly(int workerNo, int year) {
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
		HashSet<LocalDate> weekdaySet = getWeekdaySet(workerNo, year);
		weekdaySet.removeAll(getHolidaySet(workerNo, year));
		attendanceVO.setWorkday(weekdaySet.size());
		attendanceVO.setAbsent(getAbsent(workerNo, year));
		return attendanceVO;
	}
	
	//해당년도의 모든 지정 휴일
	public HashSet<LocalDate> getHolidaySet(int workerNo, int year){
		//record 에서 companyNo 가져오기
				String companyId = selectOne(workerNo).getAdminId();
				//해당 연도의 지정 휴일 날짜 조회
				String sql = "SELECT holiday_date"
						+ " FROM holiday"
						+ " WHERE company_id = ?"
						+" AND TO_CHAR(holiday_date, 'YYYY') = ?";
				
				Object[] data = {companyId, year};

				// RowMapper 구현
		        RowMapper<LocalDate> holiMapper = new RowMapper<LocalDate>() {
		            @Override
		            public LocalDate mapRow(ResultSet rs, int rowNum) throws SQLException {
		                return rs.getDate("holiday_date").toLocalDate();
		            }
		        };
		        
				List<LocalDate> list = jdbcTemplate.query(
					    sql, holiMapper, data
					);
				
				HashSet holidaySet = new HashSet<>(list);
				return holidaySet;
	}
	
	//해당 년도의 모든 평일 날짜
	public HashSet<LocalDate> getWeekdaySet(int workerNo, int year){
		HashSet weekdaySet = new HashSet<>();
		
		LocalDate start = LocalDate.of(year, 1, 1);
		
		LocalDate workerJoin = workerDao.selectOne(workerNo).getWorkerJoin().toLocalDate();
			
			// 사원이 기준년도에 입사
			if (year == workerJoin.getYear()) {
				start = workerJoin;
			}
		//사원이 기준년도 이전 입사한 경우
		LocalDate end = LocalDate.of(year, 12, 31);
		LocalDate date = start;
	        while (!date.isAfter(end)) {
	            // 현재 날짜가 평일인지 확인
	            DayOfWeek dayOfWeek = date.getDayOfWeek();
	            if (dayOfWeek != DayOfWeek.SATURDAY && dayOfWeek != DayOfWeek.SUNDAY) {
	            	weekdaySet.add(date); // 평일인 경우 HashSet에 추가
	            }
	            // 다음 날짜로 이동
	            date = date.plusDays(1);
	        }
		return weekdaySet;
	}
	
	//결근 횟수 조회
	public int getAbsent(int workerNo, int year) {
		LocalDate workerJoin = workerDao.selectOne(workerNo).getWorkerJoin().toLocalDate();
		//사원이 기준년도 이후 입사한 경우
		if (year < workerJoin.getYear()) {
			return  0;
		}
		//해당년도의 모든 평일 날짜 데이터
		HashSet<LocalDate> weekdaySet = 
				getWeekdaySet(workerNo, year);
		
		//해당년도의 모든 지정휴일 데이터
		HashSet<LocalDate> holidaySet = 
				getHolidaySet(workerNo, year);
		
		//평일 - 지정휴일 = 출근해야 하는 날짜 
		weekdaySet.removeAll(holidaySet);
		
		//해당 연도의 모든 사원출근 날짜 조회
		String sqlForRecord = "SELECT worker_out FROM record"
								+" WHERE worker_no = ?"
								+" AND TO_CHAR(worker_out, 'YYYY') = ?";
		
		Object[] recordData = {workerNo, year};
		
		List<LocalDate> workerOutList = jdbcTemplate.query(
				sqlForRecord,
			    new RowMapper<LocalDate>() {
			        @Override
			        public LocalDate mapRow(ResultSet rs, int rowNum) throws SQLException {
			            return rs.getDate("worker_out").toLocalDate(); // SQL 날짜를 LocalDate로 변환
			        }
			    },
			    recordData
			);
		 HashSet recordSet = new HashSet<>(workerOutList);
		 //출근해야 하는 날짜 - 출근한 날짜 = 결근일
		 weekdaySet.removeAll(recordSet);
		 int absent = weekdaySet.size();
		 return absent;
	}
	
}
