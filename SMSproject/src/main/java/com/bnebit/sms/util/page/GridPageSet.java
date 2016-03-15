package com.bnebit.sms.util.page;

public class GridPageSet extends PageSet {
	private static final long serialVersionUID = -7607982770013960488L;

	private long page; // page = currentPage
	private long total; // total = pageTotalCount
	private long record; // record = datasize
	private String sidx; // = sort column
	private String sord; // = sort order

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

	@Override
	public void setPageInfo() {
		super.setCurrentPage(page);
		super.setSortName(sidx);
		super.setSortBy(sord);
		super.setPageInfo();
	}

}
