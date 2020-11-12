package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.MyLocVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.MemberMapper;
import org.zerock.mapper.MyLocMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
	
@Service
@AllArgsConstructor
@Repository
public  class  MyLocServiceImpl implements MyLocService  {
	
	@Setter(onMethod_ = @Autowired)
	private MyLocMapper mapper;

	@Override
	public List<MyLocVO> read() {
		// TODO Auto-generated method stub
		return mapper.read();
		
	}

	
}
