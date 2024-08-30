package com.kh.AttendPro.dao;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.NoticeDto;
import com.kh.AttendPro.mapper.NoticeMapper;
import com.kh.AttendPro.vo.PageVO;


@Repository
public class NoticeDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	
	public int sequence() { 
		String sql = "SELECT notice_seq.NEXTVAL FROM dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public int countByPaging() {
		String sql = "select count(*) from notice";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {
			String sql = "select count(*) from notice where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from notice";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
	
	public List<NoticeDto> selectListByPaging(PageVO pageVO) {
		String sql;
		Object[] data;
		
		if(pageVO.isSearch()) {
			sql = "SELECT * FROM ("
					+ "SELECT TMP.*, ROWNUM rn FROM ("
					+ "SELECT notice_no, notice_writer, notice_title, "
					+ "notice_content, notice_wtime, notice_utime "
					+ "FROM notice "
					+ "WHERE INSTR(" + pageVO.getColumn() + ", ?) > 0 "
					+ "ORDER BY notice_no DESC"
					+ ")TMP"
					+ ")WHERE rn BETWEEN ? AND ?";
			data = new Object[] {
				pageVO.getKeyword(),
				pageVO.getBeginRow(),
				pageVO.getEndRow()
			};
		}else {
			sql = "SELECT * FROM ("
					+ "SELECT TMP.*, ROWNUM rn FROM ("
					+ "SELECT notice_no, notice_writer, notice_title, "
					+ "notice_content, notice_wtime, notice_utime "
					+ "FROM notice "
					+ "ORDER BY notice_no DESC "
					+ ") TMP "
					+ ") WHERE rn BETWEEN ? AND ?";
			data = new Object[] {
					pageVO.getBeginRow(),
					pageVO.getEndRow()
			};
		}
		List<NoticeDto> result = jdbcTemplate.query(sql, noticeMapper, data);
		
		
		
		return result;
	}

	public NoticeDto selectOne(int noticeNo) {
		String sql = "select * from notice where notice_no=?";
		Object[] data = {noticeNo};
		List<NoticeDto> list = jdbcTemplate.query(sql, noticeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public void insert(NoticeDto noticeDto) {
		String sql = "insert into notice("
				+ "notice_no, notice_writer, notice_title, notice_content, "
				+ "notice_wtime, notice_utime "
				+ ") values(?, ?, ?, ?, SYSDATE, SYSDATE)";
		Object[] data = {
				noticeDto.getNoticeNo(), noticeDto.getNoticeWriter(),
				noticeDto.getNoticeTitle(), noticeDto.getNoticeContent()
		};
		jdbcTemplate.update(sql, data);
	}

	public boolean delete(int noticeNo) {
		String sql = "delete notice where notice_no = ?";
		Object[] data = {noticeNo};
		return jdbcTemplate.update(sql, data) > 0;
	}

	public boolean update(NoticeDto noticeDto) {
		String sql = "update notice set "
				+ "notice_title=?, notice_content=?, notice_utime=sysdate "
				+ "where notice_no=?";
		Object[] data = {
			noticeDto.getNoticeTitle(), noticeDto.getNoticeContent(), 
			noticeDto.getNoticeNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	
	
}
