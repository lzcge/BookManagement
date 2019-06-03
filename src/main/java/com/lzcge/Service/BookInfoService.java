package com.lzcge.Service;

import com.lzcge.Entity.BookInfo;
import com.lzcge.VO.BookInfoVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BookInfoService {
	List<BookInfo> selectAllBook();

	List<BookInfoVo> selectByBookName(String BookName);

	List<BookInfo> wxselectByBookName(String BookName);

	public List<BookInfo> selectMoFuBookInfo(BookInfo bookInfo);

	/**
	 * 判断图书是否可借
	 * @param
	 * @return
	 */
	public List<BookInfo> borrowCheckByISBN( String bookISBN);

	public BookInfo selectByBookId( String bookId);

	/**
	 * 查出图书表中的最后一本图书，来生成新的图书编码
	 * @return
	 */
	public BookInfo selectEndBook();


	public Object updateBookInfo(BookInfo bookInfo) throws IllegalAccessException;

	public void insertBookInfo(BookInfo bookInfo) throws IllegalAccessException;

	public Object deleteBookInfo(BookInfo bookInfo);
}
