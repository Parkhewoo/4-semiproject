package com.kh.AttendPro;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.AttendPro.mapper.QnaDetailMapper;
import com.kh.AttendPro.mapper.QnaListMapper;
import com.kh.AttendPro.vo.PageVO;

@SpringBootTest
public class Test01qna {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private QnaListMapper qnaListMapper;
	
	@Autowired
	private QnaDetailMapper qnaDetailMapper;
	
	@Test
	//페이징 적용 검색, 목록
			public Object selectListByPaging(PageVO pageVO) {
				if(pageVO.isSearch()) {//검색이라면
					String sql = "select * from ("
										+ "select rownum rn, TMP.* from ("
											+ "select "
												+ "qna_no, qna_title, qna_writer, qna_wtime, "
												+ "qna_utime, qna_replies "
											+ "from qna "
											+ " where instr(#1, ?) > 0 "
										+ ")TMP"
								+ ") where rn between ? and ?";
					sql = sql.replace("#1", "qna_title");
					Object[] data = {
							"project", 
							1, 5
					};
					return jdbcTemplate.query(sql, qnaListMapper, data);
				}
				else {//목록이라면
					String sql = "select * from ("
										+ "select rownum rn, TMP.* from ("
											+ "select "
												+ "qna_no, qna_title, qna_writer, qna_wtime, "
												+ "qna_utime, qna_replies "
											+ "from qna"
										+ ")TMP"
								+ ") where rn between ? and ?";
					Object[] data = {1, 5};
					return jdbcTemplate.query(sql, qnaListMapper, data);
				}
			}
}
