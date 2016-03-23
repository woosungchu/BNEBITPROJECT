package com.bnebit.sms.util.page;

public class PageUtil {
	private int totalCount; // 전체 게시물 개수
	private int totalPageCount; // 전체 페이지 개수
	private int totalBlockCount; // 전체 블록 개수
	public static int currentPage; // 현재 페이지 번호
	public static int currentBlock; // 현재 블록 번호
	public static final int PAGESIZE = 10; // 1페이지당 게시물 수
	public static final int BLOCKSIZE = 5; // 1블록당 페이지 수
	private int startNum; // 페이지 시작 게시물 번호 rownum
	private int endNum; // 페이지 끝 게시물 번호 rownum

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getTotalBlockCount() {
		return totalBlockCount;
	}

	public void setTotalBlockCount(int totalBlockCount) {
		this.totalBlockCount = totalBlockCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getCurrentBlock() {
		return currentBlock;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	@Override
	public String toString() {
		return "PageUtil [totalCount=" + totalCount + ", totalPageCount=" + totalPageCount + ", currentPage="
				+ currentPage + ", currentBlock=" + currentBlock + "]";
	}

	// 페이지 개수 구하기
	public int pageCountSize(int totalCount) {
		int mod = totalCount % PAGESIZE;
		if(mod != 0) {
			totalPageCount = totalCount / PAGESIZE + 1;
		} else {
			totalPageCount = totalCount / PAGESIZE;
		}
		return totalPageCount;
	}

	// 블록 개수 구하기
	public int blockCountSize(int totalCount) {
		int totalPageCount = pageCountSize(totalCount);
		int mod = totalPageCount % BLOCKSIZE;
		if(mod != 0) {
			totalBlockCount = totalPageCount / BLOCKSIZE + 1;
		} else {
			totalBlockCount = totalPageCount / BLOCKSIZE;
		}
		return totalBlockCount;
	}

	//첫번째 블록과 마지막 블록 구하기
	public boolean isFirstBlock() {
		if(currentBlock == 1) { return true; }
		return false;

	}

	public boolean isLastBlock() {
		if(currentBlock == totalBlockCount) { return true; }
		if(totalBlockCount == 1) { return true; }
		return false;
	}

	// startNum, endNum
	public int startNum(int totalCount) {
		int startNum = (PAGESIZE * (currentPage - 1)) +1;
		if(startNum < 1) {
			startNum = 1;
		} else if(startNum > totalCount ) {
			startNum = totalCount;
		}
		return startNum;
	}

	public int endNum(int totalCount) {
		int endNum = (PAGESIZE * currentPage);
		if(endNum < 1) {
			endNum = 1;
		} else if(endNum > totalCount ) {
			endNum = totalCount;
		}
		return endNum;
	}

	// 블록 이동
	public int moveBlock(int currentPage) {
		if(currentPage > (BLOCKSIZE * currentBlock)) {
			currentBlock = currentBlock +1;
		} else if(currentPage < (BLOCKSIZE * (currentBlock-1) + 1)) {
			currentBlock = currentBlock -1;
		}
		return currentBlock;
	}

}
