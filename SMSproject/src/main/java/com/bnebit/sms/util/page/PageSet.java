package com.bnebit.sms.util.page;

import java.io.Serializable;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

public class PageSet implements Serializable {
	private static final long serialVersionUID = 6619528787989740354L;
	private static Logger LOGGER = Logger.getLogger(PageSet.class);
	private long currentPage = 1;
	private int selectPostList = 10;
	private String searchKey;
	private String searchValue;
	private String startDate;
	private String endDate;
	private String sortName;
	private String sortBy;
	private String sortOrder;

	private Map<String, Object> pageParamMap;

	private long totalPost;
	private long totalPage;
	private int pageGroup = 10;
	private long pageGroupStartPage;
	private long pageGroupEndPage;
	private long listStartNum;
	private long listEndNum;

	private String previousLabel = "<<";
	private String nextLabel = ">>";
	private String currentPageClass = "btn btn-primary btn-sm active";
	private String pageClass = "btn btn-d btn-sm";




	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getSortName() {
		return sortName;
	}

	public String getSortBy() {
		return sortBy;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public void setSortBy(String sortBy) {
		this.sortBy = sortBy;
	}

	public long getCurrentPage() {
		return currentPage;
	}

	public int getSelectPostList() {
		return selectPostList;
	}

	public String getSearchKey() {
		return searchKey;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public String getStartDate() {
		return startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public Map<String, Object> getPageParamMap() {
		return pageParamMap;
	}

	public long getTotalPost() {
		return totalPost;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public int getPageGroup() {
		return pageGroup;
	}

	public long getPageGroupStartPage() {
		return pageGroupStartPage;
	}

	public long getPageGroupEndPage() {
		return pageGroupEndPage;
	}

	public long getListStartNum() {
		return listStartNum;
	}

	public long getListEndNum() {
		return listEndNum;
	}

	public String getPreviousLabel() {
		return previousLabel;
	}

	public String getNextLabel() {
		return nextLabel;
	}

	public String getCurrentPageClass() {
		return currentPageClass;
	}

	public String getPageClass() {
		return pageClass;
	}

	public void setCurrentPage(long currentPage) {
		this.currentPage = currentPage;
	}

	public void setSelectPostList(int selectPostList) {
		this.selectPostList = selectPostList;
	}

	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public void setPageParamMap(Map<String, Object> pageParamMap) {
		this.pageParamMap = pageParamMap;
	}

	public void setTotalPost(long totalPost) {
		this.totalPost = totalPost;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public void setPageGroup(int pageGroup) {
		this.pageGroup = pageGroup;
	}

	public void setPageGroupStartPage(long pageGroupStartPage) {
		this.pageGroupStartPage = pageGroupStartPage;
	}

	public void setPageGroupEndPage(long pageGroupEndPage) {
		this.pageGroupEndPage = pageGroupEndPage;
	}

	public void setListStartNum(long listStartNum) {
		this.listStartNum = listStartNum;
	}

	public void setListEndNum(long listEndNum) {
		this.listEndNum = listEndNum;
	}

	public void setPreviousLabel(String previousLabel) {
		this.previousLabel = previousLabel;
	}

	public void setNextLabel(String nextLabel) {
		this.nextLabel = nextLabel;
	}

	public void setCurrentPageClass(String currentPageClass) {
		this.currentPageClass = currentPageClass;
	}

	public void setPageClass(String pageClass) {
		this.pageClass = pageClass;
	}

	/**
	 * @Method Name  : hasPreviousPageGroup
	 * @작성일   : 2016. 3. 14.
	 * @작성자   : Man Seop Lee
	 * @Method 설명 : 이전 페이지 그룹이 존재하는지에 따라 prev 버튼을 추가.
	 * @return
	 */
	public boolean hasPreviousPageGroup() {
		return pageGroupStartPage == 1 ? false : true;
	}

	/**
	 * @Method Name  : hasNextPageGroup
	 * @작성일   : 2016. 3. 14.
	 * @작성자   : Man Seop Lee
	 * @Method 설명 :다음 페이지 그룹이 존재하는지에 따라 next 버튼을 추가. + 1을 해야 다음 페이지 있는지 확인 가능
	 * @return
	 */
	public boolean hasNextPageGroup() {
		return pageGroupEndPage + 1 <= totalPage ? true : false;
	}

	public void setPageInfo() {
	    listStartNum = (currentPage - 1) * selectPostList;
	    listEndNum = currentPage * selectPostList;
	    totalPage = (totalPost - 1) / selectPostList + 1;
	    pageGroupStartPage = (currentPage - 1) / pageGroup * pageGroup + 1;
	    pageGroupEndPage = pageGroupStartPage + pageGroup - 1;
	    LOGGER.info("totalPost: " + totalPost);
	    LOGGER.info("postList: " + selectPostList);
	    LOGGER.info("totalPage: " + totalPage);
	    if ( pageGroupEndPage > totalPage ) {
	      pageGroupEndPage = totalPage;
	    }
	  }

	public void setPageParamMap() {
		pageParamMap = new ConcurrentHashMap<>();
		pageParamMap.put("selectPostList", selectPostList);

		if (StringUtils.isNotEmpty(searchKey)) {
			pageParamMap.put("searchKey", searchKey);
		}
		if (StringUtils.isNotEmpty(searchValue)) {
			pageParamMap.put("searchValue", searchValue);
		}
		if (StringUtils.isNotEmpty(startDate)) {
			pageParamMap.put("startDate", startDate);
		}
		if (StringUtils.isNotEmpty(endDate)) {
			pageParamMap.put("endDate", endDate);
		}
		if (StringUtils.isNotEmpty(sortName)) {
			pageParamMap.put("sortName", sortName);
		}
		if (StringUtils.isNotEmpty(sortBy)) {
			pageParamMap.put("sortBy", sortBy);
		}

	}

	public String getParamString() {
		if (pageParamMap == null || pageParamMap.isEmpty()) {
			return "";
		}

		StringBuilder paramString = new StringBuilder();
		Set<String> paramNameSet = pageParamMap.keySet();
		Iterator<String> iterator = paramNameSet.iterator();

		while (iterator.hasNext()) {
			String paramName = iterator.next();
			paramString.append("&");
			paramString.append(paramName);
			paramString.append("=");
			paramString.append(pageParamMap.get(paramName));
		}
		return paramString.toString();
	}

	public void setSortOrder() {
		if (StringUtils.isNotEmpty(sortName)) {
			StringBuffer sortOrderBuffer = new StringBuffer();
			String[] sortNameArr = sortName.split(",");
			String[] sortByArr = sortBy.split(",");
			int sortCount = sortNameArr.length;
			for(int i = 0; i < sortCount; i++) {
				sortOrderBuffer.append(sortNameArr[i]);
				sortOrderBuffer.append(" ");
				sortOrderBuffer.append(sortByArr[i]);
				sortOrderBuffer.append(",");
			}
			String temp = sortOrderBuffer.toString();
			sortOrder = temp.substring(0, temp.length() - 1);
			LOGGER.info("sortOrder: " + sortOrder);
		}
	}


}
