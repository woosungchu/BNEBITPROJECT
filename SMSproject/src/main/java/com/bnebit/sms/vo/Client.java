package com.bnebit.sms.vo;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class Client implements Serializable {
	private static final long serialVersionUID = 124480644534369044L;

	private String clientId;
	@NotEmpty(message = "고객코드를 입력해주세요", groups = {ClientInsert.class})
	private String clientCode;
	@NotEmpty(message = "고객명을 입력해주세요", groups = {ClientInsert.class, ClientUpdate.class})
	private String clientName;
	@NotEmpty(message = "2차거래선을 입력해주세요", groups = {ClientInsert.class, ClientUpdate.class})
	private String secondName;
	@NotEmpty(message = "주소를 입력해주세요", groups = {ClientInsert.class, ClientUpdate.class})
	private String address;
	private String phone;
	@NotEmpty(message = "대표자를 입력해주세요", groups = {ClientInsert.class, ClientUpdate.class})
	private String ceo;
	private int isDelete;
	private String regDate;
	@Pattern(regexp = "(01([0|1|6|7|8|9]))", message="전화번호 형식이 잘못되었습니다", groups = {ClientInsert.class, ClientUpdate.class})
	private String phone1;
	@Pattern(regexp = "([0-9]{3,4})", message="전화번호 형식이 잘못되었습니다", groups = {ClientInsert.class, ClientUpdate.class})
	private String phone2;
	@Pattern(regexp = "([0-9]{4})", message="전화번호 형식이 잘못되었습니다", groups = {ClientInsert.class, ClientUpdate.class})
	private String phone3;

	public String getPhone1() {
		return phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientCode() {
		return clientCode;
	}
	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getSecondName() {
		return secondName;
	}
	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public void setPhone() {
		this.phone = phone1 + "-" + phone2 + "-" + phone3;
	}

	public void setPhoneSplit() {
		String[] phoneArr = phone.split("-");
		phone1 = phoneArr[0];
		phone2 = phoneArr[1];
		phone3 = phoneArr[2];
	}

	public interface ClientInsert {}
	public interface ClientUpdate {}

}
