package org.zerock.service;

import java.util.List;

import org.zerock.domain.NoticeAttachVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;

public interface NoticeService {

	//Create
	public abstract void register(NoticeVO board);
	//Read
	public NoticeVO get(Long bno);
	//Update
	public boolean modify(NoticeVO board);
	//Delete
	public boolean remove(Long bno);
	//Read
	//public List<NoticeVO> getList();
	
	public List<NoticeVO> getList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<NoticeAttachVO> getAttachList(Long bno);
}
