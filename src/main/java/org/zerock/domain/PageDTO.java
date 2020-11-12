package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	private int startPage;//시작페이지번호
	private int endPage;//마지막페이지 번호
	private boolean prev, next;//이전, 이후 여부
	
	private int total;//전체 레코드 수
	private Criteria cri;//pageNum, amount

	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		//마지막페이지 처리
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		
		this.startPage = this.endPage - 9;
		//실제 마지막 페이지값
		int realEnd = (int)(Math.ceil((total * 1.0)/cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
