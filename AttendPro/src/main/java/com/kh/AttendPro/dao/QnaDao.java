package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.QnaDto;
import com.kh.AttendPro.mapper.QnaDetailMapper;
import com.kh.AttendPro.mapper.QnaListMapper;
import com.kh.AttendPro.vo.PageVO;

@Repository
public class QnaDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaListMapper qnaListMapper;
	
	@Autowired
	private QnaDetailMapper qnaDetailMapper;
	
		
		//페이징의 마지막 블록 번호를 위해 게시글 수를 구하는 메소드
		public int countByPaging () {
			String sql = "select count(*) from qna";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		
		public int countByPaging(PageVO pageVO) {
			if(pageVO.isSearch()) {//검색카운트
				String sql = "select count(*) from qna where instr(#1, ?) > 0";
				sql = sql.replace("#1", pageVO.getColumn());
				Object[] data = {pageVO.getKeyword()};
				return jdbcTemplate.queryForObject(sql, int.class, data);
			}
			else {//목록카운트
				String sql = "select count(*) from qna";
				return jdbcTemplate.queryForObject(sql, int.class);
			}
		}
		
		//페이징 적용 검색, 목록
		public Object selectListByPaging(PageVO pageVO) {
			if(pageVO.isSearch()) {//검색이라면
				String sql = "select * from ("
									+ "select rownum rn, TMP.* from ("
										+ "select "
											+ "qna_no, qna_title, qna_writer, qna_wtime, "
											+ "qna_utime, qna_replies, "
											+ "qna_group, qna_target, qna_depth "
										+ "from qna "
										+ " where instr(#1, ?) > 0 "
										//트리정렬
										+ "connect by prior qna_no=qna_target "
										+ "start with qna_target is null "
										+ "order siblings by qna_group desc, qna_no asc"
									+ ")TMP"
							+ ") where rn between ? and ?";
				sql = sql.replace("#1", pageVO.getColumn());
				Object[] data = {
						pageVO.getKeyword(), 
						pageVO.getBeginRow(), 
						pageVO.getEndRow() 
				};
				return jdbcTemplate.query(sql, qnaListMapper, data);
			}
			else {//목록이라면
				String sql = "select * from ("
						+ "select rownum rn, TMP.* from ("
						+ "select "
							+ "qna_no, qna_title, qna_writer, qna_wtime, "
							+ "qna_utime, qna_replies, "
							+ "qna_group, qna_target, qna_depth "
						+ "from qna "
						//트리정렬
						+ "connect by prior qna_no=qna_target "
						+ "start with qna_target is null "
						+ "order siblings by qna_group desc, qna_no asc"
					+ ")TMP"
			+ ") where rn between ? and ?";
				Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
				return jdbcTemplate.query(sql, qnaListMapper, data);
			}
		}
		
		public QnaDto selectOne(int qnaNo) {
		    String sql = "select * from qna where qna_no=?";
		    Object[] data = {qnaNo};
		    List<QnaDto> list = jdbcTemplate.query(sql, qnaDetailMapper, data);
		    return list.isEmpty() ? null : list.get(0);
		}

		public int sequence() {
			String sql = "select qna_seq.nextval from dual";
			
			return jdbcTemplate.queryForObject(sql, int.class);
		}

		public void insert(QnaDto qnaDto) {
			String sql = "insert into qna("
					+"qna_no, qna_title, qna_content, qna_writer, "
					+ "qna_group, qna_target, qna_depth"
					+") values(?, ?, ?, ?, ?, ?, ?)"
					;
			Object[] data = {
					qnaDto.getQnaNo(),
					qnaDto.getQnaTitle(), 
					qnaDto.getQnaContent(), 
					qnaDto.getQnaWriter(),
					qnaDto.getQnaGroup(),
					qnaDto.getQnaTarget(),
					qnaDto.getQnaDepth()
					};
			
			jdbcTemplate.update(sql, data);
		}
}
