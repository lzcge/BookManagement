package com.lzcge.Entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BorrowRecord implements Serializable{
	private Integer borrowID;  //借阅记录ID
	private String userId;
	private String bookId;
	private String bookName;   //书名
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date borrowTime;    //借书时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")  //返回json数据时格式化
	private Date shouldTime;    //预还书时间
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date returnTime;      //实际还书时间
	private Integer state;      //借阅状态（0借出;1已还）

	public Integer getBorrowID() {
		return borrowID;
	}

	public void setBorrowID(Integer borrowID) {
		this.borrowID = borrowID;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBookId() {
		return bookId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public Date getBorrowTime() {
		return borrowTime;
	}

	public void setBorrowTime(Date borrowTime) {
		this.borrowTime = borrowTime;
	}

	public Date getShouldTime() {
		return shouldTime;
	}

	public void setShouldTime(Date shouldTime) {
		this.shouldTime = shouldTime;
	}

	public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
}
