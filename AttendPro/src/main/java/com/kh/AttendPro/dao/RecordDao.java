package com.kh.AttendPro.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.RecordDto;
import com.kh.AttendPro.mapper.RecordMapper;
import com.kh.AttendPro.mapper.StatusMapper;
import com.kh.AttendPro.vo.StatusVO;

@Repository
public class RecordDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	RecordMapper recordMapper;
	
	@Autowired
	StatusMapper statusMapper;
	
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
	
	
	
	public void getStatus(int workerNo) {
		//vo로 세팅
		String sqlForLate = "SELECT "
				+ "COUNT(*) AS late_count "
				+ "FROM "
				+ "status "
				+ "WHERE "
				+ "r.worker_no = ? "
				+ "AND r.company_in < r.worker_in";
		
		String sqlForLeave = "SELECT "
				+ "COUNT(*) AS leave_count "
				+ "FROM "
				+ "status "
				+ "WHERE "
				+ "r.worker_no = ? "
				+ "AND r.company_out > r.worker_out";
		
		Object[] data = {workerNo};
		
		int late = jdbcTemplate.queryForObject(sqlForLate, int.class,data);
		int leave = jdbcTemplate.update(sqlForLeave, int.class, data);
	}
	
//근태기록(누적)
	public List<StatusVO> selectListByAttendance(int workerNo) {
	    List<StatusVO> statusList = new ArrayList<>();
	    //
	    //지각 횟수를 조회하는 sql
	    String sqlForLate = "SELECT COUNT(*) "
	            + "FROM status "
	            + "WHERE worker_no = ? "
	            + "AND to_char(company_in, 'HH24:MI:SS') < to_char(worker_in, 'HH24:MI:SS')";

//	  //조퇴 횟수를 조회하는 sql
	    String sqlForLeave = "SELECT COUNT(*) "
	    		+"FROM status "
	    		+"WHERE worker_no = ? "
	    		+"AND TO_CHAR(company_out, 'HH24:MI:SS') "
	    		+ "> TO_CHAR(worker_out, 'HH24:MI:SS') ";
	    
	  
	  //출근 횟수를 조회하는 sql
	    String sqlForAttend = "SELECT count(*) "
	    		+ "FROM status "
	    		+ "WHERE worker_no = ? "
	    		+ "AND worker_out IS NOT NULL";
	    
	  //결근 횟수를 조회하는 sql
	    
	    //평일이면서 공휴일이 아니면서 worker_out = null
	    //holidayStatus 회사 공휴일, 지정 출퇴근 시각, worker_out 여부 
//	    String sqlForAbsent = "select count(*) "
//	    		+ "from status "
//	    		+ "where worker_no = ?"
//	    		+"AND ";
	    
	    //List에 각 StatusVO 추가
	    statusList.add(getStatusVO("출근", sqlForAttend, workerNo));
	    statusList.add(getStatusVO("지각", sqlForLate, workerNo));
	    statusList.add(getStatusVO("조퇴", sqlForLeave, workerNo));
//	    statusList.add(getStatusVO("결근", sqlForAbsent, workerNo)); (구현 예정)
	    
	    return statusList;
	}
	
	//구문과 키워드에 따라 달별 statusVO를 출력하는 메소드
	public StatusVO getStatusVO(String title, String sql, int workerNo){
		StatusVO statusVO = new StatusVO();
		
		Object[] data = {workerNo, };
		int cnt = jdbcTemplate.queryForObject(sql, int.class, data);
		statusVO.setTitle(title);
		statusVO.setCnt(cnt);
		return statusVO;
	}
	
	

	
}
