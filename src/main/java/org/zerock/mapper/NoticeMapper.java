package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.NoticeVO;

public interface NoticeMapper {

	//@Select("select * from tbl_board where bno > 0")
	public List<NoticeVO> getList();
	public List<NoticeVO> getListWithPaging(Criteria cri);
	//insert만 처리되고 생성된 PK값을 알 필요가 없는 경우
	public void insert(NoticeVO board);
	//insert만 처리되고 생성된 PK값을 알아야 하는 경우
	public void insertSelectKey(NoticeVO board);
	//데이터를 조회할때는 PK를 이용한다.
	public NoticeVO read(long bno);
	//데이터를 삭제할때는 PK를 이용한다.
	public int delete(long bno);
	//데이터를 수정할때는 PK를 이용한다.
	public int update(NoticeVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	public void updateHitCnt(Long bno  );
	
	
	
}
