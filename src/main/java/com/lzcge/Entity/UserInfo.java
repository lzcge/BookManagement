package com.lzcge.Entity;

import java.io.Serializable;

public class UserInfo extends User implements Serializable {
	private String UserId;
	private String Departments;  //院系
	private String Major;    //专业
	private String Phone;    //电话
	private String Email;
	private Integer Max;    //可借最大数量
	private Integer Time;   //可借期限
	private Integer LendedNum;  //在借数量

	public String getUserId() {
		return UserId;
	}

	public void setUserId(String userId) {
		UserId = userId;
	}

	public String getDepartments() {
		return Departments;
	}

	public void setDepartments(String departments) {
		Departments = departments;
	}

	public String getMajor() {
		return Major;
	}

	public void setMajor(String major) {
		Major = major;
	}

	public String getPhone() {
		return Phone;
	}

	public void setPhone(String phone) {
		Phone = phone;
	}

	public String getEmail() {
		return Email;
	}

	public void setEmail(String email) {
		Email = email;
	}

	public Integer getMax() {
		return Max;
	}

	public void setMax(Integer max) {
		Max = max;
	}

	public Integer getTime() {
		return Time;
	}

	public void setTime(Integer time) {
		Time = time;
	}

	public Integer getLendedNum() {
		return LendedNum;
	}

	public void setLendedNum(Integer lendedNum) {
		LendedNum = lendedNum;
	}

	public UserInfo(String userId, String departments, String major, String phone, String email, Integer max, Integer time, Integer lendedNum) {
		UserId = userId;
		Departments = departments;
		Major = major;
		Phone = phone;
		Email = email;
		Max = max;
		Time = time;
		LendedNum = lendedNum;
	}

	public UserInfo(){}
}
