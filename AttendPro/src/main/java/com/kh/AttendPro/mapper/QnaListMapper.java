package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dto.QnaDto;

	@Service
	public class QnaListMapper implements RowMapper<QnaDto>{

		@Override
		public QnaDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			QnaDto qnaDto = new QnaDto();
			qnaDto.setQnaNo(rs.getInt("qna_no"));
			qnaDto.setQnaTitle(rs.getString("qna_title"));
//			qnaDto.setQnaContent(rs.getString("qna_content"));
			qnaDto.setQnaWriter(rs.getString("qna_writer"));
			qnaDto.setQnaWTime(rs.getDate("qna_wtime"));
			qnaDto.setQnaUTime(rs.getDate("qna_utime"));
			qnaDto.setQnaReply(rs.getString("qna_reply"));
			
			//3개 항목 추가
			 qnaDto.setQnaGroup(rs.getInt("qna_group"));
	         qnaDto.setQnaTarget(rs.getObject("qna_target", Integer.class));
	         qnaDto.setQnaDepth(rs.getInt("qna_depth"));
			
			return qnaDto;
		}
		
	}
