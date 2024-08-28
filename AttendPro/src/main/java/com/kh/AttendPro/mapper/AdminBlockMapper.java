package com.kh.AttendPro.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.AttendPro.vo.AdminBlockVO;

@Service
public class AdminBlockMapper implements RowMapper<AdminBlockVO> {
	@Override
	public AdminBlockVO mapRow(ResultSet rs, int rowNum) throws SQLException{
	AdminBlockVO adminBlockVO = new AdminBlockVO();
	adminBlockVO.setAdminId(rs.getString("adminId"));
	adminBlockVO.setAdminPw(rs.getString("adminPw"));
	adminBlockVO.setAdminNo(rs.getString("adminNo"));
	adminBlockVO.setAdminRank(rs.getString("adminRank"));
	adminBlockVO.setAdminEmail(rs.getString("adminEmail"));
	adminBlockVO.setAdminLogin(rs.getDate("adminLogin"));
	
	adminBlockVO.setBlockNo(rs.getInt("block_no"));
	adminBlockVO.setBlockType(rs.getString("block_type"));
	adminBlockVO.setBlockMemo(rs.getString("block_memo"));
	adminBlockVO.setBlockTime(rs.getDate("blockTime"));
	adminBlockVO.setBlockTarget(rs.getString("block_target"));
	return adminBlockVO;
	}
}
