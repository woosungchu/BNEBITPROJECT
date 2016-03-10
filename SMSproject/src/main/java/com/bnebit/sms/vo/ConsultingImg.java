package com.bnebit.sms.vo;

import java.io.Serializable;

public class ConsultingImg implements Serializable {
	private static final long serialVersionUID = 5887084440634050957L;

	private String consultingImgId;
	private String consultingId;
	private String imgName;
	private String originName;
	public String getConsultingImgId() {
		return consultingImgId;
	}
	public void setConsultingImgId(String consultingImgId) {
		this.consultingImgId = consultingImgId;
	}
	public String getConsultingId() {
		return consultingId;
	}
	public void setConsultingId(String consultingId) {
		this.consultingId = consultingId;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	@Override
	public String toString() {
		return "ConsultingImg [consultingImgId=" + consultingImgId + ", consultingId=" + consultingId + ", imgName="
				+ imgName + ", originName=" + originName + "]";
	}


}
