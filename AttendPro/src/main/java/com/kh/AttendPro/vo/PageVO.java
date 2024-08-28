package com.kh.AttendPro.vo;

import lombok.Data;

//페이지작업 모듈화

@Data
public class PageVO {	
	//페이징에 필요한 정보들을 필드로 선언 
	private String column;//검색항목
	private String keyword;//검색 키워드
	private int page=1;//페이지 번호
	private int size=10; //1페이지 크기
	private int count; //총 데이터 개수
	private int blockSize = 10; //한 블럭의 크기
	
	//계산 메소드(가상의 Getter 메소드) 추가
	public boolean isSearch() {
		return this.column != null && this.keyword != null;
	}
	
	//시작행 종료행 계산 메소드
	public int getBeginRow() {
		return this.page * this.size-(this.size-1);
	}
	public int getEndRow() {
		return this.page * this.size;	
	}
	
	public int getStartBlock() {
		return (this.page-1) / this.blockSize * this.blockSize + 1;
	}
	//네비게이터를 위한 메소드
	public boolean isFirst() {
		return this.getStartBlock() <= 1;
	}
	public boolean hasPrev() {
		return !isFirst();
	}
	public int getPrevBlock() {//이전 누르면 나올 페이지 번호
		return this.getStartBlock()-1;
	}
	public int getLastBlock() {
		return (this.count-1) / this.size+1;
	}
	public int getFinishBlock() {
		int finishBlock = this.getStartBlock()+ this.blockSize-1;
		return Math.min(finishBlock, this.getLastBlock());
	}
	public boolean isLast() {
		return this.getFinishBlock() >= this.getLastBlock();
	}
	public boolean hasNext() {
		return this.isLast() == false;
	}
	public int getNextBlock() {
		return this.getFinishBlock()+1;
	}
    // 총 페이지 수 계산 메소드
    public int getTotalPages() {
        return (int) Math.ceil((double) this.count / this.size);
    }
}





