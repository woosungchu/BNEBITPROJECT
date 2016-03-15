package com.bnebit.sms.util.page;

import java.io.Serializable;
import java.util.List;

public class ResultPageInfo<E> implements Serializable {
  private static final long serialVersionUID = -2388531071751740725L;

  private List<E> dataList;
  private PageSet pageSet;

  public List<E> getDataList() {
    return dataList;
  }
  public PageSet getPageSet() {
    return pageSet;
  }
  public void setDataList(List<E> dataList) {
    this.dataList = dataList;
  }
  public void setPageSet(PageSet pageSet) {
    this.pageSet = pageSet;
  }

/*  public long getCurrentPage() {
    return pageSet.getCurrentPage();
  }

  public String getSearchKey() {
    return pageSet.getSearchKey();
  }

  public String getSearchValue() {
    return pageSet.getSearchValue();
  }

  public String getStartDate() {
    return pageSet.getStartDate();
  }

  public String getEndDate() {
    return pageSet.getEndDate();
  }*/

}
