package com.marketdongnae.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.marketdongnae.domain.member.AllDTO;
import com.marketdongnae.domain.member.Deal_viewDTO;
import com.marketdongnae.domain.member.Do_areaDTO;
import com.marketdongnae.domain.member.MemberDTO;
import com.marketdongnae.domain.member.PasswordDTO;
import com.marketdongnae.domain.member.PointDTO;
import com.marketdongnae.domain.member.Si_areaDTO;
import com.marketdongnae.security.CustomUserDetails;

public interface MemberMapper {
	public CustomUserDetails loginID(String m_id);
	

	public List<Do_areaDTO> getDoList();
	
	public List<Si_areaDTO> getSiList(int do_id);
	
	public Si_areaDTO getSi_area(int si_id);
	
	public MemberDTO getMember(int m_number);
	
	public Integer updateMember(MemberDTO memberDTO);
	
	
	public String changePassword(@Param ("m_number") int m_number
								,@Param ("newEncodePwd") String newEncodePwd);
	
	
	public Integer regist(MemberDTO memberDTO);
	
	public MemberDTO checkId(String m_id);

	
	public int getListCnt(@Param ("m_number") int m_number, @Param ("table_id") String table_id, @Param ("table") String table);
	
	public List<AllDTO> getPageList(@Param ("m_number") int m_number
										, @Param ("table") String table
										,@Param ("displayStart") int displayStart);

	
	public int getDealCnt(@Param ("m_number") int m_number, @Param ("d_type") String d_type);
	
	public List<Deal_viewDTO> getDealPageList(@Param ("m_number") int m_number
											, @Param ("d_type") String d_type
											,@Param ("displayStart") int displayStart );
	

	
	public List<Deal_viewDTO> getSoldList(int m_number);

	
	public void deleteWish(int wish_id);


	public void updatePoint(MemberDTO memberDTO);

	public void insertPointList(PointDTO pointDTO);


}
