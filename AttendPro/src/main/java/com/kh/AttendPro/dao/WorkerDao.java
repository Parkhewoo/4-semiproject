package com.kh.AttendPro.dao;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.mapper.StatusMapper;
import com.kh.AttendPro.mapper.WorkerMapper;
import com.kh.AttendPro.vo.PageVO;
import com.kh.AttendPro.vo.StatusVO;

@Repository
public class WorkerDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private WorkerMapper workerMapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	//사원 등록 (암호화 추가)
	public void insert(WorkerDto workerDto) {
	    // 암호화
	    String rawPw = workerDto.getWorkerPw();
	    String encPw = encoder.encode(rawPw);
	    workerDto.setWorkerPw(encPw);

	    // SQL 쿼리 정의
	    String sql = "INSERT INTO worker ("
	            + "admin_id, worker_no, worker_pw, worker_name, worker_attend, worker_absent, "
	            + "worker_late, worker_leave, worker_rank, worker_birthday, "
	            + "worker_contact, worker_email, worker_post, worker_address1, worker_address2"
	            + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    // 데이터 설정
	    Object[] data = {
	        workerDto.getAdminId(),
	        workerDto.getWorkerNo(),
	        workerDto.getWorkerPw(),
	        workerDto.getWorkerName(),
	        workerDto.getWorkerAttend(),         // 기본값: 0
	        workerDto.getWorkerAbsent(),         // 기본값: 0
	        workerDto.getWorkerLate(),           // 기본값: 0
	        workerDto.getWorkerLeave(),          // 기본값: 0
	        workerDto.getWorkerRank(),
	        workerDto.getWorkerBirthday(),
	        workerDto.getWorkerContact(),
	        workerDto.getWorkerEmail(),
	        workerDto.getWorkerPost(),
	        workerDto.getWorkerAddress1(),
	        workerDto.getWorkerAddress2()
	    };

	    // 데이터베이스 업데이트
	    jdbcTemplate.update(sql, data);
	}

	
//	// 목록 
//		public List<WorkerDto> selectList(){
//			String sql = "SELECT admin_id,worker_no, worker_pw, worker_name, worker_attend, worker_absent, "
//	                + "worker_late, worker_leave, worker_join, worker_rank, worker_birthday, "
//	                + "worker_contact, worker_email, worker_post, worker_address1, worker_address2 "
//	                + "FROM worker order by worker_no desc";
//			return jdbcTemplate.query(sql, workerMapper);					
//		}
//		
//		//검색
//		public List<WorkerDto> selectList(String column, String keyword){
//			String sql = "select * from worker "
//							+ "where instr(#1, ?) > 0 "
//							+ "order by #1 asc, worker_no desc";
//			
//			sql = sql.replace("#1", column);
//			Object[] data = {keyword};
//			return jdbcTemplate.query(sql, workerMapper, data);
//		}
	
	//회원 상세
		public WorkerDto selectOne(int workerNo) {
		    String sql = "SELECT * FROM worker WHERE worker_no = ?";
		    Object[] data = {workerNo};
		    List<WorkerDto> list = jdbcTemplate.query(sql, workerMapper, data);
		    return list.isEmpty() ? null : list.get(0);
		}
	//로그인 전용 상세조회
	public WorkerDto selectOneWithPassword(int workerNo, String workerPw) {
		String sql = "select * from worker where worker_no = ?";
		Object[] data = {workerNo};
		List<WorkerDto> list = jdbcTemplate.query(sql, workerMapper, data);
		if(list.isEmpty()) return null;
		
		WorkerDto workerDto = list.get(0);
		boolean isValid = encoder.matches(workerPw, workerDto.getWorkerPw());
		return isValid ? workerDto : null;
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
		
		//페이징
//		public List<WorkerDto> selectListByPaging(PageVO pageVO) {
//		    String sql;
//		    Object[] data;
//
//		    if (pageVO.isSearch()) {
//		        // 검색 쿼리
//		    	sql = "SELECT * FROM ("
//		    		      + "SELECT TMP.*, ROWNUM rn FROM ("
//		    		      + "SELECT * FROM worker "
//		    		      + "WHERE INSTR(worker_name, ?) > 0 "
//		    		      + "ORDER BY " + pageVO.getColumn() + " ASC, worker_no ASC"
//		    		      + ") TMP "
//		    		      + ") WHERE rn BETWEEN ? AND ?";
//		    
//		        data= new Object[]{
//		            pageVO.getKeyword(),
//		            pageVO.getEndRow(),
//		            pageVO.getBeginRow()
//		        };
//		        return jdbcTemplate.query(sql, workerMapper, data);
//		    } 
//		    else {
//		        // 목록 쿼리
//		        sql = "SELECT * FROM ("
//		                + "SELECT TMP.*, ROWNUM rn FROM ("
//		                + "SELECT * FROM worker "
//		                + "ORDER BY worker_no desc"
//		                + ") TMP "
//		                + ") where rn between ? and ?";
//
//		        data = new Object[]{
//		            pageVO.getBeginRow(),
//		            pageVO.getEndRow()
//		        };
//		        //System.out.println(Arrays.toString(data));
//		    }
//		    List<WorkerDto> result = jdbcTemplate.query(sql, workerMapper, data);
////		    System.out.println("결과 수 : " + result.size());
//	        // Print the result to the console
////	        System.out.println("Query Result:");
////	        for (WorkerDto worker : result) {
////	            System.out.println(worker);
////	        }
//
//	        return result;
//	    }
	

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
			String encPw = encoder.encode(workerPw);
			String sql = "update worker set worker_pw=? where worker_no=?";
			Object[] data = {encPw, workerNo};
			return jdbcTemplate.update(sql, data) > 0;
			
		}

		// 사원 이미지 연결
			public void connect(int workerNo, int attachmentNo) {
				String sql = "insert into worker_image(worker, attachment) values(?, ?)"; 
				Object[] data = {workerNo, attachmentNo};
				jdbcTemplate.update(sql, data);
			}
				

				public int findImage(int workerNo) {
					String sql = "select attachment from worker_image where worker=?";
					//String sql = "select max(attachment) from worker_image where worker=?";
					Object[] data = {workerNo};
					return jdbcTemplate.queryForObject(sql, int.class, data);
				}	
				public boolean deleteImage(int workerNo) {
				    String sql = "DELETE FROM worker_image WHERE worker = ?";
				    return jdbcTemplate.update(sql, workerNo) > 0;
				}
				
		@Autowired
		private StatusMapper statusMapper;
		
		//(시스템관리자용) 직급별 사원 수 스테이터스
		public List<StatusVO> statusByWorkerRank() {
		    String sql = "select worker_rank title, count(*) cnt" + " from worker " + "group by worker_rank "
		            + "order by cnt desc, title asc";
		    return jdbcTemplate.query(sql, statusMapper);
		}

		 //adminid로 목록조회
		public List<WorkerDto> selectListByAdminPaging(PageVO pageVO, String adminId) {
		    String sql;
		    Object[] data;

		    if (pageVO.isSearch()) {
		        // 검색 쿼리
		    	String column=pageVO.getColumn();
		        sql = "SELECT * FROM ("
		                + "SELECT TMP.*, ROWNUM rn FROM ("
		                + "SELECT * FROM worker "
		                +  "WHERE INSTR(" + column + ", ?) > 0 "
		                + "AND admin_id = ? " // admin_id 추가
		                + "ORDER BY " + pageVO.getColumn() + " ASC, worker_no ASC"
		                + ") TMP "
		                + ") WHERE rn BETWEEN ? AND ?";

		        data = new Object[]{
		            pageVO.getKeyword(),
		            adminId,
		            pageVO.getBeginRow(),
		            pageVO.getEndRow()
		        };
		    } else {
		        // 목록 쿼리
		        sql = "SELECT * FROM ("
		                + "SELECT TMP.*, ROWNUM rn FROM ("
		                + "SELECT * FROM worker "
		                + "WHERE admin_id = ? " // admin_id 추가
		                + "ORDER BY worker_no DESC"
		                + ") TMP "
		                + ") WHERE rn BETWEEN ? AND ?";

		        data = new Object[]{
		            adminId,
		            pageVO.getBeginRow(),
		            pageVO.getEndRow()
		        };
		    }

		    return jdbcTemplate.query(sql, workerMapper, data);
		}
				
		//adminId로 페이징
		public int countListByAdminPaging(PageVO pageVO, String adminId) {
		    String sql;
		    Object[] data;

		    if (pageVO.isSearch()) {
		        sql = "SELECT COUNT(*) FROM worker WHERE instr(" + pageVO.getColumn() + ", ?) > 0 AND admin_id = ?";
		        data = new Object[]{pageVO.getKeyword(), adminId};
		    } else {
		        sql = "SELECT COUNT(*) FROM worker WHERE admin_id = ?";
		        data = new Object[]{adminId};
		    }

		    return jdbcTemplate.queryForObject(sql, Integer.class, data);
		}

}
