package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.MemberVO;
import org.zerock.domain.AuthVO;
import org.zerock.domain.Criteria;

public interface MemberMapper {

	//@Select("select * from tbl_member where bno > 0")
	public List<MemberVO> getList();
	public List<MemberVO> getListWithPaging(Criteria cri);
	//insert만 처리되고 생성된 PK값을 알 필요가 없는 경우
	public void insert(MemberVO member);
	//insert만 처리되고 생성된 PK값을 알아야 하는 경우
	public void insertSelectKey(MemberVO member);
	public void insertAuth(AuthVO auth);
	//데이터를 조회할때는 PK를 이용한다.
	public MemberVO read(String userid);
	//데이터를 삭제할때는 PK를 이용한다.
	public int delete(String userid);
	//데이터를 수정할때는 PK를 이용한다.
	public int update(MemberVO member);
	
	public int getTotalCount(Criteria cri);
}
