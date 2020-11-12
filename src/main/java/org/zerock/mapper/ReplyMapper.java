package org.zerock.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;
public interface ReplyMapper {
	
	public abstract int insert(ReplyVO vo);
	
	public abstract ReplyVO read(Long bno);
	
	public abstract int delete(Long rno);
	
	public abstract void deleteAll(Long bno);
	
	public abstract int update(ReplyVO vo);
	
	public abstract List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,	@Param("bno") Long bno	);
	
	public abstract int getCountByBno(Long rno);

}
