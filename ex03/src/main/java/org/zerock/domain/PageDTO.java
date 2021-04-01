package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;
	
	public PageDTO(int total, Criteria cri) {
		System.out.println("--------------pageDto-------------");
		System.out.println("total: " + total + ", cri.getPageNum(): " + cri.getPageNum() + ", cri.getAmount(): " + cri.getAmount());
		
		this.total = total;
		this.cri = cri;
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		System.out.println("endPage: " + endPage);
		
		this.startPage = this.endPage - 9;
		System.out.println("startPage: " + startPage);
		
		int realEnd = (int)(Math.ceil(total * 1.0 / cri.getAmount()));
		System.out.println("realEnd: " + realEnd);
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
			System.out.println("realEnd가 endPage보다 작았을 경우의 새로운 endPage: " + endPage);
		}	
		
		this.prev = this.startPage > 1;
		System.out.println("prev: " + prev);
		this.next = this.endPage < realEnd;
		System.out.println("next: " + next);
		System.out.println("--------------/pageDto-------------");
	}
}
