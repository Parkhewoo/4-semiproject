package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AttachmentDto;
import com.kh.AttendPro.mapper.AttachmentMapper;

@Repository
public class AttachmentDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AttachmentMapper attachmentMapper;
	
	//Attachment 시퀀스 지정
	public int sequence() {
		String sql = "select attachment_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//Attachment 생성
	public void insert(AttachmentDto attachmentDto) {
		String sql = "insert into attachment("
				+ "attachment_no, attachment_name, attachment_type, attachment_size"
				+ ") values(?, ?, ?, ?)";
		Object[] data = {
				attachmentDto.getAttachmentNo(), attachmentDto.getAttachmentName(),
				attachmentDto.getAttachmentType(), attachmentDto.getAttachmentSize()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//Attachment 상세
	public AttachmentDto selectOne(int attachmentNo) {
		String sql = "select * from attachment where attachment_no = ?";
		Object[] data = {attachmentNo};
		List<AttachmentDto> list =
				jdbcTemplate.query(sql, attachmentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//Attachment 삭제
	public boolean delete(int attachmentNo) {
		String sql = "delete attachment where attachment_no = ?";
		Object[] data = {attachmentNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
}
