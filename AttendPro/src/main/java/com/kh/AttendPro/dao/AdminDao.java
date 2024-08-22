package com.kh.AttendPro.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.AttendPro.dto.AdminDto;
import com.kh.AttendPro.mapper.AdminMapper;


@Repository
public class AdminDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private AdminMapper adminMapper;
	
	//회원등록
	public void join(AdminDto adminDto) {
		String sql = "insert into admin("
			    + "admin_id, admin_pw, admin_no, admin_rank, admin_email) "
			    + "values(?, ?, ?, ?, ?)";
		Object[] data = {
				adminDto.getAdminId(), adminDto.getAdminPw(), adminDto.getAdminNo(), adminDto.getAdminRank(),
				adminDto.getAdminEmail()//차후 dto에 adminNo추가후 수정예정
		};
		jdbcTemplate.update(sql,data);
	}
	
	// 목록 
	public List<AdminDto> selectList(){
		String sql = "select * from admin order by admin_id desc";
		return jdbcTemplate.query(sql, adminMapper);					
	}
	
	//검색
	public List<AdminDto> selectList(String column, String keyword){
		String sql = "select * from admin "
						+ "where instr(#1, ?) > 0 "
						+ "order by #1 asc, admin_id desc";
		
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, adminMapper, data);
	}

	//회원조회
	public AdminDto selectOne(String adminId) {
		String sql = "select * from admin where admin_id = ?";
		Object[] data = { adminId };
		List<AdminDto> list = jdbcTemplate.query(sql, adminMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	
}
