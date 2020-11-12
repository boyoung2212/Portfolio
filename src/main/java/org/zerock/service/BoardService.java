package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {

	//Create
	public abstract void register(BoardVO board);
	//Read
	public BoardVO get(Long bno);
	//Update
	public boolean modify(BoardVO board);
	//Delete
	public boolean remove(Long bno);
	//Read
	//public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno);
}
