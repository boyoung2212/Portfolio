package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MemberVO;
import org.zerock.domain.AuthVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Transactional
	@Override
	public void register(MemberVO member, AuthVO auth) {
		mapper.insertSelectKey(member);
		mapper.insertAuth(auth);
	}
	
//	@Override
//	public void registerAuth(AuthVO auth) {
//		mapper.insertAuth(auth);
//	}

	@Transactional
	@Override
	public MemberVO get(String userid) {
				
		return mapper.read(userid);
	}

	@Override
	public boolean modify(MemberVO member) {
		// TODO Auto-generated method stub
		return mapper.update(member) == 1;
	}

	@Override
	public boolean remove(String userid) {
		// TODO Auto-generated method stub
		return mapper.delete(userid)  == 1;
	}

	/*
	 * @Override public List<MemberVO> getList() { return mapper.getList(); }
	 */

	@Override
	public List<MemberVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

}
