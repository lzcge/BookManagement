package com.lzcge.VO;

import com.lzcge.Entity.BookInfo;

public class BookInfoVo {
	private Integer count;  //可借数量
	private Integer totalCount;//在库数
	private BookInfo bookInfo; //显示的当前可接书籍

	public BookInfoVo(Integer totalCount,Integer count, BookInfo bookInfo) {
		this.totalCount = totalCount;
		this.count = count;
		this.bookInfo = bookInfo;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public BookInfo getBookInfo() {
		return bookInfo;
	}

	public void setBookInfo(BookInfo bookInfo) {
		this.bookInfo = bookInfo;
	}
}
