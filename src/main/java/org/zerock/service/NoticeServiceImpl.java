package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.NoticeAttachVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.NoticeAttachMapper;
import org.zerock.mapper.NoticeMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class NoticeServiceImpl implements NoticeService {

	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeAttachMapper attachMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	
	
	@Override
	public void register(NoticeVO board) {
		mapper.insertSelectKey(board);
		if(board.getAttachList() == null || board.getAttachList().size()  <=0) {
			return;
		}
		board.getAttachList().forEach(attach ->{
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
			
		});
	}

	@Transactional
	@Override
	public NoticeVO get(Long bno) {
		
		mapper.updateHitCnt(bno);
		
		return mapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(NoticeVO board) {
		// TODO Auto-generated method stub
		log.info("modify............."+board);
		attachMapper.deleteAll(board.getBno());
		
		boolean modifyResult = mapper.update(board) == 1;
		
		if(modifyResult && board.getAttachList() != null && board.getAttachList().size() > 0) {
			board.getAttachList().forEach(attach -> {
				
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		log.info("remove..."+ bno);
		attachMapper.deleteAll(bno);
		replyMapper.deleteAll(bno);
		return mapper.delete(bno)  == 1;
	}

	/*
	 * @Override public List<NoticeVO> getList() { return mapper.getList(); }
	 */

	@Override
	public List<NoticeVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<NoticeAttachVO> getAttachList(Long bno) {
		
		log.info("get Attach list by bno"+bno);
		
		return attachMapper.findByBno(bno);
	}

}
