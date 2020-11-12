package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface ReplyService {

	//mapper.insert()
	public abstract int register(ReplyVO vo);
	//mapper.read()
	public abstract ReplyVO get(Long rno);
	//mapper.update()
	public abstract int modify(ReplyVO vo);
	//mapper.delete()
	public abstract int remove(Long rno);
	//mapper.getListWithPaging()
	public abstract List<ReplyVO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
}
