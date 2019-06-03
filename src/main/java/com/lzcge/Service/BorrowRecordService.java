package com.lzcge.Service;

import com.lzcge.Entity.BorrowRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BorrowRecordService {

	public List<BorrowRecord> selReaderBorrowing(BorrowRecord borrowRecord);

	public List<BorrowRecord> selReaderBorrowed(BorrowRecord borrowRecord);

	public BorrowRecord selectBorrowByBookId(BorrowRecord borrowRecord);

	public void addBorrowRecord(BorrowRecord borrowRecord) throws IllegalAccessException;

	public BorrowRecord selBorrowById( Integer borrowID);

	public void updateBorrowRecord(BorrowRecord borrowRecord) throws IllegalAccessException;

//	管理员查询借阅记录
	public List<BorrowRecord> selectAdBorrowMoFu(BorrowRecord borrowRecord);
}
