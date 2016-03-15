package com.bnebit.sms.util.page;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.tags.form.AbstractHtmlElementTag;
import org.springframework.web.servlet.tags.form.TagWriter;

public class PagingTag extends AbstractHtmlElementTag {
  private static final long serialVersionUID = 6219333267087907329L;

  private static final Logger LOGGER = LoggerFactory.getLogger(PagingTag.class);

  private String linkUrl;
  private String pageParamName;
  private PageSet pageSet;

  public String getLinkUrl() {
    return linkUrl;
  }

  public String getPageParamName() {
    return pageParamName;
  }

  public PageSet getPageSet() {
    return pageSet;
  }

  public void setPageParamName(String pageParamName) {
    this.pageParamName = pageParamName;
  }

  public void setLinkUrl(String linkUrl) {
    this.linkUrl = linkUrl;
  }

  public void setPageSet(PageSet pageSet) {
    this.pageSet = pageSet;
  }

  private String getLinkAddParam(final long targetPage) {
    return linkUrl + "?" + pageParamName + "=" + targetPage + this.pageSet.getParamString();
  }

  @Override
  protected int writeTagContent(TagWriter tagWriter) throws JspException {
    StringBuilder pagingTag = new StringBuilder();
    if (pageSet.hasPreviousPageGroup()) {
      pagingTag.append("<a href=\"");
      pagingTag.append(getLinkAddParam(pageSet.getPageGroupStartPage() - 1));
      pagingTag.append("\">");
      pagingTag.append(pageSet.getPreviousLabel());
      pagingTag.append("</a>");
    }

    long pageGroupStartPage = pageSet.getPageGroupStartPage();
    long pageGroupEndPage = pageSet.getPageGroupEndPage();
    long currentPage = pageSet.getCurrentPage();
    for (long i = pageGroupStartPage; i <= pageGroupEndPage; i++ ) {
      if (currentPage == i) {
        pagingTag.append("<a href=\"#!");
        pagingTag.append("\" class=\"");
        pagingTag.append(pageSet.getCurrentPageClass());
        pagingTag.append("\">");
        pagingTag.append(i);
        pagingTag.append("</a>");
      } else {
        pagingTag.append("<a href=\"");
        pagingTag.append(getLinkAddParam(i));
        pagingTag.append("\" class=\"");
        pagingTag.append(pageSet.getPageClass());
        pagingTag.append("\">");
        pagingTag.append(i);
        pagingTag.append("</a>");
      }
      pagingTag.append("&nbsp;");
    }

    if (pageSet.hasNextPageGroup()) {
      pagingTag.append("<a href=\"");
      pagingTag.append(getLinkAddParam(pageSet.getPageGroupEndPage() + 1));
      pagingTag.append("\">");
      pagingTag.append(pageSet.getNextLabel());
      pagingTag.append("</a>");
    }

    JspWriter writer = this.pageContext.getOut();
    try {
      writer.write(pagingTag.toString());
      writer.flush();
    } catch (IOException e) {
      LOGGER.error("페이징 태그 에러!!!", e);
    }

    return EVAL_PAGE;
  }

}
