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
		public List<QnaDto> selectListByPaging(PageVO pageVO) {
		    String sql;
		    Object[] data;

		    if (pageVO.isSearch()) {
		        // 검색 쿼리
		        sql = "SELECT * FROM ("
		                + "SELECT TMP.*, ROWNUM rn FROM ("
		                + "SELECT qna_no, qna_title, qna_writer, qna_wtime, "
		                + "qna_utime, qna_reply, qna_group, qna_target, qna_depth "
		                + "FROM qna "
		                + "WHERE INSTR(" + pageVO.getColumn() + ", ?) > 0 "
		                + "CONNECT BY PRIOR qna_no = qna_target "
		                + "START WITH qna_target IS NULL "
		                + "ORDER SIBLINGS BY qna_group DESC, qna_no ASC"
		                + ") TMP "
		                + ") WHERE rn BETWEEN ? AND ?";
		        
		        data = new Object[]{
		            pageVO.getKeyword(),
		            pageVO.getBeginRow(),
		            pageVO.getEndRow()
		        };
		    } else {
		        // 목록 쿼리
		        sql = "SELECT * FROM ("
		                + "SELECT TMP.*, ROWNUM rn FROM ("
		                + "SELECT qna_no, qna_title, qna_writer, qna_wtime, "
		                + "qna_utime, qna_reply, qna_group, qna_target, qna_depth "
		                + "FROM qna "
		                + "CONNECT BY PRIOR qna_no = qna_target "
		                + "START WITH qna_target IS NULL "
		                + "ORDER SIBLINGS BY qna_group DESC, qna_no ASC"
		                + ") TMP "
		                + ") WHERE rn BETWEEN ? AND ?";
		        
		        data = new Object[]{
		            pageVO.getBeginRow(),
		            pageVO.getEndRow()
		        };
		    }

		    // 데이터베이스에서 조회
		    List<QnaDto> result = jdbcTemplate.query(sql, qnaListMapper, data);

		    // 결과를 콘솔에 출력
		    System.out.println("결과 수 : " + result.size());
		    System.out.println("Query Result:");
		    for (QnaDto qna : result) {
		        System.out.println(qna);
		    }

		    return result;
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
					+ "qna_reply, qna_group, qna_target, qna_depth"
					+") values(?, ?, ?, ?, ?, ?, ?, ?)"
					;
			Object[] data = {
					qnaDto.getQnaNo(),
					qnaDto.getQnaTitle(), 
					qnaDto.getQnaContent(), 
					qnaDto.getQnaWriter(),
					qnaDto.getQnaReply(),
					qnaDto.getQnaGroup(),
					qnaDto.getQnaTarget(),
					qnaDto.getQnaDepth()
					};
			
			jdbcTemplate.update(sql, data);
			
		}

		// 부모 글의 reply 필드를 업데이트하는 메서드
		public void updateReply(int qnaTarget, String reply) {
			String sql = "update qna set qna_reply = ? where qna_no = ?";
			Object[] data = { reply, qnaTarget };
			jdbcTemplate.update(sql, data);
		}
		
		//삭제
		public boolean delete(int qnaNo) {
			String sql = "delete qna where qna_no = ?";
			Object[] data = {qnaNo};
			return jdbcTemplate.update(sql, data) > 0;
		}
		
		//수정
				public boolean update(QnaDto qnaDto) {
					String sql = "update qna set "
									+ "qna_title=?, qna_content=?, qna_utime=sysdate "
									+ "where qna_no=?";
					Object[] data = {
						qnaDto.getQnaTitle(), qnaDto.getQnaContent(),
						qnaDto.getQnaNo()
					};
					return jdbcTemplate.update(sql, data) > 0;
				}

		//특정 사용자의 qna 작성 목록을 조회
		public List<QnaDto> selectListByQnaWriter(String qnaWriter) {
			String sql ="select * from qna "
							+ "where qna_writer = ? "
							+ "order by qna_no desc";
			Object[] data = {qnaWriter};										
			return jdbcTemplate.query(sql, qnaListMapper, data);
		}
	}