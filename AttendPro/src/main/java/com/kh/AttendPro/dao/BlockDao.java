package com.kh.AttendPro.dao;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.BlockDto;
import com.kh.AttendPro.dto.WorkerDto;
import com.kh.AttendPro.error.TargetNotFoundException;
import com.kh.AttendPro.mapper.BlockMapper;
import com.kh.AttendPro.vo.PageVO;

import jakarta.security.auth.message.MessagePolicy.Target;

@Repository
public class BlockDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BlockMapper blockmapper;
	
//	//차단 등록
//	public void insertBlock(BlockDto blockDto) {
//		 BlockDto lastBlock = selectLastOne(blockDto.getBlockTarget());
//	        
//	     if (lastBlock != null && "차단".equals(lastBlock.getBlockType())) {
//	            // 이미 차단된 상태이므로 새 차단을 등록하지 않음
//	        throw new TargetNotFoundException("회원이 이미 차단된 상태입니다.");
//	     }
//	     
//		String sql = "insert into block("
//							+ "block_no, block_type, "
//							+ "block_memo, block_target"
//							+ ") "
//							+ "values(block_seq.nextval, '차단', ?, ?)";
//		Object[] data = {blockDto.getBlockMemo(), blockDto.getBlockTarget()};
//		jdbcTemplate.update(sql, data);
//	}
//	
	//차단 등록
	public void insertBlock(BlockDto blockDto) {
	      BlockDto lastBlock = selectLastOne(blockDto.getBlockTarget());
	      
	      if (lastBlock != null && "차단".equals(lastBlock.getBlockType())) {
	         // 이미 차단된 상태이므로 새 차단을 등록하지 않음
	          throw new TargetNotFoundException("회원이 이미 차단된 상태입니다.");
	      }
	        
	      String sql = "insert into block("
	                      + "block_no, block_type, "
	                      + "block_memo, block_target"
	                      + ") "
	                      + "values(block_seq.nextval, '차단', ?, ?)";
	      Object[] data = {blockDto.getBlockMemo(), blockDto.getBlockTarget()};
	      jdbcTemplate.update(sql, data);
	  }
	
	
	//해제 등록
		public void insertCancle(BlockDto blockDto) {
			String sql = "insert into block("
								+ "block_no, block_type, "
								+ "block_memo, block_target"
							+ ") "
							+ "values(block_seq.nextval, '해제', ?, ?)";
			Object[] data = {blockDto.getBlockMemo(), blockDto.getBlockTarget()};
			jdbcTemplate.update(sql, data);
		}
		
	//block 정보 상세조회 기능(서브쿼리 사용)
	public BlockDto selectLastOne(String blockTarget) { 
		String sql = "select * from block where block_no = ("
						+ "select max(block_no) from block where block_target = ?"
						+ ")";
		Object[] data = {blockTarget};
		List<BlockDto> list = jdbcTemplate.query(sql, blockmapper, data);
		return list.isEmpty() ? null : list.get(0);						
	}
	
	//admin의 차단 히스토리 조회
	public List<BlockDto> selectList(String blockTarget){
		String sql = "select * from block where block_target=? "
						+ "order by block_no desc";
		Object[] data = {blockTarget};
		return jdbcTemplate.query(sql, blockmapper, data);
	}
	
//	public int countByAdmin(String blockTarget) {
//        String sql = "SELECT COUNT(*) FROM block WHERE block_target = ?";
//        return jdbcTemplate.queryForObject(sql, Integer.class, blockTarget);
//    }
//	
//
//    // 특정 관리자의 차단 기록을 페이징하여 조회하는 메서드
//    public List<BlockDto> selectListByAdmin(String blockTarget, PageVO pageVO) {
//        String sql = "SELECT * FROM ("
//                   + "    SELECT TMP.*, ROWNUM rn FROM ("
//                   + "        SELECT * FROM block"
//                   + "        WHERE block_target = ?"
//                   + "        ORDER BY block_date DESC"
//                   + "    ) TMP"
//                   + ") WHERE rn BETWEEN ? AND ?";
//        
//        Object[] data = {blockTarget, pageVO.getBeginRow(), pageVO.getEndRow()};
//        return jdbcTemplate.query(sql, blockmapper, data);
//    }
//    
    

    public int countByAdmin(String blockTarget) {
        String sql = "SELECT COUNT(*) FROM block WHERE block_target = ?";
        return jdbcTemplate.queryForObject(sql, Integer.class, blockTarget);
    }

    public List<BlockDto> selectListByAdmin(String blockTarget, PageVO pageVO) {
        String sql = "SELECT * FROM ("
                   + "    SELECT b.*, ROWNUM rn FROM ("
                   + "        SELECT * FROM block"
                   + "        WHERE block_target = ?"
                   + "        ORDER BY block_no DESC"  // block_date 대신 block_no 사용
                   + "    ) b"
                   + ") WHERE rn BETWEEN ? AND ?";
        
        Object[] data = {blockTarget, pageVO.getBeginRow(), pageVO.getEndRow()};
        return jdbcTemplate.query(sql, blockmapper, data);
    }
	    
    public List<BlockDto> selectListByPaging(PageVO pageVO) {
	    String sql;
	    Object[] data;

	    if (pageVO.isSearch()) {
	        // 검색 쿼리
	    	sql = "SELECT * FROM ("
	    		      + "SELECT TMP.*, ROWNUM rn FROM ("
	    		      + "SELECT * FROM block "
	    		      + "WHERE INSTR(block_no, ?) > 0 "
	    		      + "ORDER BY " + pageVO.getColumn() + " ASC, block_no ASC"
	    		      + ") TMP "
	    		      + ") WHERE rn BETWEEN ? AND ?";
	    
	        data = new Object[]{
	            pageVO.getKeyword(),
	            pageVO.getEndRow(),
	            pageVO.getBeginRow()
	        };
	        return jdbcTemplate.query(sql, blockmapper, data);
	    } 
	    else {
	        // 목록 쿼리
	        sql = "SELECT * FROM ("
	                + "SELECT TMP.*, ROWNUM rn FROM ("
	                + "SELECT * FROM worker "
	                + "ORDER BY worker_no desc"
	                + ") TMP "
	                + ") where rn between ? and ?";

	        data = new Object[]{
	            pageVO.getBeginRow(),
	            pageVO.getEndRow()
	        };
	        System.out.println(Arrays.toString(data));
	    }
	    List<BlockDto> result = jdbcTemplate.query(sql, blockmapper, data);
	    System.out.println("결과 수 : " + result.size());
        // Print the result to the console
        System.out.println("Query Result:");
        for (BlockDto worker : result) {
            System.out.println(worker);
        }

        return result;
    }
}
