package com.kh.AttendPro.dao;

import java.util.Iterator;
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
		
		//관리자전용 qna 목록
		public List<QnaDto> adminSelectList(String qnaWriter){
		String sql ="SELECT qna_no, qna_title, qna_writer, qna_wtime,"
			       +"qna_utime, qna_reply, qna_group, qna_target, qna_depth "
			      +" FROM qna"
			      + " CONNECT BY PRIOR qna_no = qna_target"
			      + " START WITH qna_target IS NULL"
			       +" ORDER SIBLINGS BY qna_group DESC, qna_no ASC";
		
		List<QnaDto> qnaList = jdbcTemplate.query(sql, qnaListMapper);

		 // 내 글의 답글이 아닌 경우 삭제
	    for (Iterator<QnaDto> iterator = qnaList.iterator(); iterator.hasNext();) {
	        QnaDto qnaDto = iterator.next();
	        
	        // qnaWriter가 null인 경우 예외 처리
	        if (qnaDto.getQnaWriter() == null) {
	            iterator.remove(); // qnaWriter가 null이면 해당 요소 제거
	            continue;
	        }
	        boolean isWriter = qnaDto.getQnaWriter().equals(qnaWriter);
	        Integer t = qnaDto.getQnaTarget();
	        // 타겟이 null이거나 0인 경우 다음 루프로 넘어감
	        if (t == null || t == 0) {
	            if (!isWriter) {
	                iterator.remove();
	            }
	            continue;
	        }
	        QnaDto targetQna = selectOne(t);
	        // 타겟 글이 null이거나 타겟 글의 작성자가 null인 경우 예외 처리
	        if (targetQna == null || targetQna.getQnaWriter() == null) {
	            iterator.remove(); // 문제가 있는 데이터는 제거
	            continue;
	        }
	        String tWriter = targetQna.getQnaWriter(); // 타겟 글의 작성자
	        // 내 글이 아니거나 내 글에 달린 답글이 아닌 경우 목록에서 제거
	        if (!tWriter.equals(qnaWriter)) {
	            iterator.remove(); // 안전하게 요소 제거
	        }
	    }

			return qnaList;
		}
		
		public List<QnaDto> adminSelectList(String column, String keyword, String qnaWriter) {
			String sql = "SELECT qna_no, qna_title, qna_writer, qna_wtime, "
			           + "qna_utime, qna_reply, qna_group, qna_target, qna_depth "
			           + "FROM qna "
			           + "WHERE INSTR(#1, ?) > 0 "
			           + "CONNECT BY PRIOR qna_no = qna_target "
			           + "START WITH qna_target IS NULL "
			           + "ORDER SIBLINGS BY qna_group DESC, qna_no ASC";
			sql = sql.replace("#1", column);
			Object[] data = {keyword};
			List<QnaDto> qnaList = jdbcTemplate.query(sql, qnaListMapper, data);
			
			 // 내 글의 답글이 아닌 경우 삭제
		    for (Iterator<QnaDto> iterator = qnaList.iterator(); iterator.hasNext();) {
		        QnaDto qnaDto = iterator.next();
		        
		        // qnaWriter가 null인 경우 예외 처리
		        if (qnaDto.getQnaWriter() == null) {
		            iterator.remove(); // qnaWriter가 null이면 해당 요소 제거
		            continue;
		        }
		        boolean isWriter = qnaDto.getQnaWriter().equals(qnaWriter);
		        Integer t = qnaDto.getQnaTarget();
		        // 타겟이 null이거나 0인 경우 다음 루프로 넘어감
		        if (t == null || t == 0) {
		            if (!isWriter) {
		                iterator.remove();
		            }
		            continue;
		        }
		        QnaDto targetQna = selectOne(t);
		        // 타겟 글이 null이거나 타겟 글의 작성자가 null인 경우 예외 처리
		        if (targetQna == null || targetQna.getQnaWriter() == null) {
		            iterator.remove(); // 문제가 있는 데이터는 제거
		            continue;
		        }
		        String tWriter = targetQna.getQnaWriter(); // 타겟 글의 작성자
		        // 내 글이 아니거나 내 글에 달린 답글이 아닌 경우 목록에서 제거
		        if (!tWriter.equals(qnaWriter)) {
		            iterator.remove(); // 안전하게 요소 제거
		        }
		    }

				return qnaList;
		}
	}