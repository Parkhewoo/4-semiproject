package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.QnaDto;
import com.kh.AttendPro.mapper.QnaDetailMapper;
import com.kh.AttendPro.mapper.QnaListMapper;

@Repository
public class QnaDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaListMapper qnaListMapper;
	
	@Autowired
	private QnaDetailMapper qnaDetailMapper;
	
		//목록
		public List<QnaDto> selectList(){
			String sql = "select"
					+ " qna_no, qna_title, qna_writer,"
					+ " qna_wtime, qna_utime, qna_replies"
					+" from qna order by qna_no desc";
			return jdbcTemplate.query(sql, qnaListMapper);
		}
		//검색
		public List<QnaDto> selectList(String column, String keyword) {
			String sql = "select"
					+" qna_no, qna_title, qna_writer,"
					+" qna_wtime, qna_utime, qna_replies"
					+" from qna where instr(#1, ?) > 0 "
					+" order by #1 asc, qna_no desc";
			sql = sql.replace("#1", column);
			Object[] data = {keyword};
			return jdbcTemplate.query(sql, qnaListMapper, data);
		}
}
