package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class BoardServiceimpl implements BoardService {

	// Spring 4.3 이상에서 자동처리
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		System.out.println("한글깨짐 확인: " + board.getContent());
		System.out.println("한글깨짐 확인: " + board.getTitle());
		log.info("register...." + board);
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get......" + bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify......");
		return mapper.update(board) == 1;
	}
	
	@Override
	public boolean remove(Long bno) {
		log.info("remove.......");
		return mapper.delete(bno) == 1;
	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with Criteria: " + cri.getPageNum());	
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
}
