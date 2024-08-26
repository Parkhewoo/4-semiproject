package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.mapper.WorkerMapper;
import com.kh.AttendPro.vo.PageVO;

@Repository
public class WorkerDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private WorkerMapper workerMapper;
	
	
	public void insert(WorkerDto workerDto) {
        // SQL 쿼리 정의
        String sql = "INSERT INTO worker ("
                + "worker_no, worker_pw, worker_name, worker_attend, worker_absent, "
                + "worker_late, worker_leave, worker_join, worker_rank, worker_birthday, "
                + "worker_contact, worker_email, worker_post, worker_address1, worker_address2"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // 데이터 설정
        Object[] data = {
            workerDto.getWorkerNo(),
            workerDto.getWorkerPw(),
            workerDto.getWorkerName(),
            workerDto.getWorkerAttend(),         // 기본값: 0
            workerDto.getWorkerAbsent(),         // 기본값: 0
            workerDto.getWorkerLate(),           // 기본값: 0
            workerDto.getWorkerLeave(),          // 기본값: 0
            workerDto.getWorkerJoin(), // 변환된 날짜 값
            workerDto.getWorkerRank(),
            workerDto.getWorkerBirthday(),
            workerDto.getWorkerContact(),
            workerDto.getWorkerEmail(),
            workerDto.getWorkerPost(),
            workerDto.getWorkerAddress1(),
            workerDto.getWorkerAddress2()
        };
        jdbcTemplate.update(sql, data);
	}
	
	// 목록 
		public List<WorkerDto> selectList(){
			String sql = "SELECT worker_no, worker_pw, worker_name, worker_attend, worker_absent, "
	                + "worker_late, worker_leave, worker_join, worker_rank, worker_birthday, "
	                + "worker_contact, worker_email, worker_post, worker_address1, worker_address2 "
	                + "FROM worker order by worker_no desc";
			return jdbcTemplate.query(sql, workerMapper);					
		}
		
		//검색
		public List<WorkerDto> selectList(String column, String keyword){
			String sql = "select * from worker "
							+ "where instr(#1, ?) > 0 "
							+ "order by #1 asc, worker_no desc";
			
			sql = sql.replace("#1", column);
			Object[] data = {keyword};
			return jdbcTemplate.query(sql, workerMapper, data);
		}
	
	//회원 상세
		public WorkerDto selectOne(int workerNo) {
		    String sql = "SELECT * FROM worker WHERE worker_no = ?";
		    Object[] data = {workerNo};
		    List<WorkerDto> list = jdbcTemplate.query(sql, workerMapper, data);
		    return list.isEmpty() ? null : list.get(0);
		}
		
	//회원정보 수정
		public boolean update(WorkerDto dto) {
		    String sql = "UPDATE worker SET "
		                + "worker_pw = ?, "
		                + "worker_name = ?, "
		                + "worker_attend = ?, "
		                + "worker_absent = ?, "
		                + "worker_late = ?, "
		                + "worker_leave = ?, "
		                + "worker_join = ?, "
		                + "worker_rank = ?, "
		                + "worker_birthday = ?, "
		                + "worker_contact = ?, "
		                + "worker_email = ?, "
		                + "worker_post = ?, "
		                + "worker_address1 = ?, "
		                + "worker_address2 = ? "
		                + "WHERE worker_no = ?";
		    Object[] data = {
		        dto.getWorkerPw(),dto.getWorkerName(),dto.getWorkerAttend(),
		        dto.getWorkerAbsent(),dto.getWorkerLate(),dto.getWorkerLeave(),
		        dto.getWorkerJoin(),dto.getWorkerRank(), dto.getWorkerBirthday(),
		        dto.getWorkerContact(),dto.getWorkerEmail(),dto.getWorkerPost(),
		        dto.getWorkerAddress1(),dto.getWorkerAddress2(),dto.getWorkerNo()
		    };
		    return jdbcTemplate.update(sql, data) > 0;
		}
		
	//worker 삭제
		public boolean delete(int workerNo) {
		    String sql = "DELETE FROM worker WHERE worker_no = ?";
		    Object[] data = {workerNo};
		    return jdbcTemplate.update(sql, data) > 0;
		}
		
	//worker 상세
		public WorkerDto selectOne(String workerNo) {
			String sql = "select * from worker where worker_no = ?";
			Object[] data = {workerNo};
			List<WorkerDto> list = jdbcTemplate.query(sql, workerMapper, data);
			return list.isEmpty() ? null : list.get(0);
		}
		
		//페이징
		public List<WorkerDto> selectListBypaging(PageVO pageVO) {
		    if (pageVO.isSearch()) {
		        String sql = "SELECT * FROM ("
		                + "SELECT TMP.*, ROWNUM rn FROM ("
		                + "SELECT * FROM worker "
		                + "WHERE instr(" + pageVO.getColumn() + ", ?) > 0 "
		                + "ORDER BY " + pageVO.getColumn() + " ASC, worker_no ASC"
		                + ") TMP "
		                + ") WHERE rn BETWEEN ? AND ?";
		        Object[] data = {
		            pageVO.getKeyword(),
		            pageVO.getBeginRow(),
		            pageVO.getEndRow()
		        };
		        return jdbcTemplate.query(sql, workerMapper, data);
		    } else { // 목록
		        String sql = "SELECT * FROM ("
		                + "SELECT TMP.*, ROWNUM rn FROM ("
		                + "SELECT * FROM worker ORDER BY worker_no ASC"
		                + ") TMP "
		                + ") WHERE rn BETWEEN ? AND ?";
		        Object[] data = { pageVO.getBeginRow(), pageVO.getEndRow() };
		        return jdbcTemplate.query(sql, workerMapper, data);
		    }
		}

		public int countByPaging(PageVO pageVO) {
		    if (pageVO.isSearch()) {
		        String sql = "SELECT count(*) FROM worker WHERE instr(" + pageVO.getColumn() + ", ?) > 0";
		        Object[] data = { pageVO.getKeyword() };
		        return jdbcTemplate.queryForObject(sql, Integer.class, data);
		    } else {
		        String sql = "SELECT count(*) FROM worker";
		        return jdbcTemplate.queryForObject(sql, Integer.class);
		    }
		}
		//사원 비밀번호 변경
		public boolean updateWorkerPw(int workerNo, String workerPw) {
			String sql = "update worker set worker_pw=? where worker_no=?";
			Object[] data = {workerPw, workerNo};
			return jdbcTemplate.update(sql, data) > 0;
			
		}

		
}
