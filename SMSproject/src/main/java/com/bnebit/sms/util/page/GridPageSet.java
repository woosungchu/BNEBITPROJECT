package com.bnebit.sms.util.page;

import java.util.Map;

public class GridPageSet extends PageSet {
	private static final long serialVersionUID = -7607982770013960488L;

	private long page;   // 현재 페이지
	private int rows;    // 페이지별 보여줄 데이터 수
	private long total;  // 전체 페이지 수
	private long record; // 전체 데이터 수
	private String searchField;
	private String searchString;
	private String sidx; // 정렬 컬럼
	private String sord; // 정렬 방법

	public long getPage() {
		return page;
	}

	public long getTotal() {
		total = super.getTotalPage();
		return total;
	}

	public long getRecord() {
		record = super.getTotalPost();
		return record;
	}

	public String getSidx() {
		return sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setPage(long page) {
		this.page = page;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public void setRecord(long record) {
		this.record = record;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

	public int getRows() {
		return rows;
	}

	public String getSearchField() {
		return searchField;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public void setGridPageInfo() {
		super.setCurrentPage(page);
		super.setSortName(sidx);
		super.setSortBy(sord);
		super.setSelectPostList(rows);
		super.setSearchKey(searchField);
		super.setSearchValue(searchString);
	}

	@Override
	public void setPageParamMap() {
		super.setPageParamMap();
		Map<String, Object> pageParamMap = super.getPageParamMap();
		pageParamMap.put("selectPostList", super.getSelectPostList());
		super.setPageParamMap(pageParamMap);
	}

	@Override
	public String toString() {
		return "GridPageSet [page=" + page + ", rows=" + rows + ", total=" + total + ", record=" + record
				+ ", searchField=" + searchField + ", searchString=" + searchString + ", sidx=" + sidx + ", sord="
				+ sord + "]";
	}

}
