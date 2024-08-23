package com.kh.AttendPro.dao;

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
		
		//block 정보 상세조회 기능(서브쿼리 사용)
//		public BlockDto selectLastOne(String blockTarget) {
//			
//		}
				
	}

}
