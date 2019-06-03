package com.lzcge.VO;

import com.lzcge.Entity.BookInfo;
import com.lzcge.Entity.BorrowRecord;

import java.io.Serializable;

public class AdCheckBookVo implements Serializable{
	private BorrowRecord borrowRecord;
	private BookInfo bookInfo;

	public BorrowRecord getBorrowRecord() {
		return borrowRecord;
	}

	public void setBorrowRecord(BorrowRecord borrowRecord) {
		this.borrowRecord = borrowRecord;
	}

	public BookInfo getBookInfo() {
		return bookInfo;
	}

	public void setBookInfo(BookInfo bookInfo) {
		this.bookInfo = bookInfo;
	}

	public AdCheckBookVo(BorrowRecord borrowRecord, BookInfo bookInfo) {
		this.borrowRecord = borrowRecord;
		this.bookInfo = bookInfo;
	}

	public AdCheckBookVo(){}
}
