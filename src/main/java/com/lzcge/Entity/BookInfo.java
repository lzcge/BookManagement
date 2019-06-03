package com.lzcge.Entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;


public class BookInfo implements Serializable{
	private String BookId;    //图书的唯一编号
	private String BookName;   //图书名称
	private String Author;    //作者
	private String Translator;  //译者
	private float Price;   //价格
	private String ISBNCode; //ISBN编码
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date ComeUpTime;  //出版日期
	private String PublishCompany;  //出版社
	private Integer State;    //  图书状态（0借出;1在库）
	private String EnteringMen;  //入库者
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date EnteringDate;   //入库日期

	public String getBookId() {
		return BookId;
	}

	public void setBookId(String bookId) {
		BookId = bookId;
	}

	public String getBookName() {
		return BookName;
	}

	public void setBookName(String bookName) {
		BookName = bookName;
	}

	public String getAuthor() {
		return Author;
	}

	public void setAuthor(String author) {
		Author = author;
	}

	public String getTranslator() {
		return Translator;
	}

	public void setTranslator(String translator) {
		Translator = translator;
	}

	public float getPrice() {
		return Price;
	}

	public void setPrice(float price) {
		Price = price;
	}

	public String getISBNCode() {
		return ISBNCode;
	}

	public void setISBNCode(String ISBNCode) {
		this.ISBNCode = ISBNCode;
	}

	public Date getComeUpTime() {
		return ComeUpTime;
	}

	public void setComeUpTime(Date comeUpTime) {
		ComeUpTime = comeUpTime;
	}

	public String getPublishCompany() {
		return PublishCompany;
	}

	public void setPublishCompany(String publishCompany) {
		PublishCompany = publishCompany;
	}

	public Integer getState() {
		return State;
	}

	public void setState(Integer state) {
		State = state;
	}

	public String getEnteringMen() {
		return EnteringMen;
	}

	public void setEnteringMen(String enteringMen) {
		EnteringMen = enteringMen;
	}

	public Date getEnteringDate() {
		return EnteringDate;
	}

	public void setEnteringDate(Date enteringDate) {
		EnteringDate = enteringDate;
	}

	public BookInfo(){}

	public BookInfo(String bookId, String bookName, String author, String translator,
					float price, String ISBNCode, Date comeUpTime, String publishCompany,
					Integer state, String enteringMen, Date enteringDate) {
		BookId = bookId;
		BookName = bookName;
		Author = author;
		Translator = translator;
		Price = price;
		this.ISBNCode = ISBNCode;
		ComeUpTime = comeUpTime;
		PublishCompany = publishCompany;
		State = state;
		EnteringMen = enteringMen;
		EnteringDate = enteringDate;
	}
}
