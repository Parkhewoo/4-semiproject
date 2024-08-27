package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.BlockDto;
import com.kh.AttendPro.mapper.BlockMapper;

@Repository
public class BlockDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BlockMapper blockmapper;
	
	//차단 등록
	public void insertBlock(BlockDto blockDto) {
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

}
