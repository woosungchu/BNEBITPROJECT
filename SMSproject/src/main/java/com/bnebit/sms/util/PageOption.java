package com.bnebit.sms.util;

import java.util.List;

public class PageOption<T> {
	private int page;
	private int rows;
	private String sidx;
	private String sord;
	private String fullSidx;
	private String searchField;
	private String searchString;
	private String searchOper;
	private String search;
	private int end;
	private int start;
	private int total;
	private int records;
	private List<T> dataList;

	@Override
	public String toString() {
		return "PageOption [page=" + page + ", rows=" + rows + ", sidx=" + sidx + ", sord=" + sord + ", fullSidx="
				+ fullSidx + ", searchField=" + searchField + ", searchString=" + searchString + ", searchOper="
				+ searchOper + ", search=" + search + ", end=" + end + ", start=" + start + ", total=" + total
				+ ", records=" + records + "]";
	}

	public List<T> getDataList() {
		return dataList;
	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

	public String getFullSidx() {
		return fullSidx;
	}

	public void setFullSidx(String fullSidx) {
		this.fullSidx = fullSidx;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getSearchOper() {
		return searchOper;
	}

	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}

}
