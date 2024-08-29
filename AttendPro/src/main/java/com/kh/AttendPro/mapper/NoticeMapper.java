package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.dto.NoticeDto;

@Service
public class NoticeMapper implements RowMapper<NoticeDto>{

	@Override
	public NoticeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setNoticeNo(rs.getInt("notice_no"));
		noticeDto.setNoticeWriter(rs.getString("notice_writer"));
		noticeDto.setNoticeTitle(rs.getString("notice_title"));
		noticeDto.setNoticeContent(rs.getString("notice_content"));
		noticeDto.setNoticeWtime(rs.getDate("notice_wtime"));
		noticeDto.setNoticeUtime(rs.getDate("notice_utime"));
		return noticeDto;
	}

}
