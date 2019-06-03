package com.lzcge.Mapper;

import com.lzcge.Entity.BookInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BookInfoMapper {

	public List<BookInfo> selectAllBook();

	public List<BookInfo> selectByBookName(@Param("BookName") String BookName);

	public List<BookInfo> selectMoFuBookInfo(BookInfo bookInfo);

	/**
	 * 判断图书是否可借
	 * @param
	 * @return
	 */
	public List<BookInfo> borrowCheckByISBN(@Param("bookISBN") String bookISBN);

	public BookInfo selectByBookId(@Param("bookId") String bookId);

	/**
	 * 查出图书表中的最后一本图书，来生成新的图书编码
	 * @return
	 */
	public BookInfo selectEndBook();

	public void updateBookInfo(BookInfo bookInfo);


	public void insertBookInfo(BookInfo bookInfo);

	public void deleteBookInfo(BookInfo bookInfo);
}
