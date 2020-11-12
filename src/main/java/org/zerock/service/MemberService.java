package org.zerock.service;

import java.util.List;

import org.zerock.domain.MemberVO;
import org.zerock.domain.AuthVO;
import org.zerock.domain.Criteria;

public interface MemberService {

	//Create
	public abstract void register(MemberVO member, AuthVO auth);
	//public abstract void registerAuth(AuthVO auth);
	//Read
	public MemberVO get(String userid);
	//Update
	public boolean modify(MemberVO member);
	//Delete
	public boolean remove(String userid);
	//Read
	//public List<MemberVO> getList();
	
	public List<MemberVO> getList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
}
