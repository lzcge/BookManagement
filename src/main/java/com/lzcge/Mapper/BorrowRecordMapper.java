package com.lzcge.Mapper;

import com.lzcge.Entity.BorrowRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BorrowRecordMapper {

	public List<BorrowRecord> selReaderBorrowing(BorrowRecord borrowRecord);

	public List<BorrowRecord> selReaderBorrowed(BorrowRecord borrowRecord);

	public void addBorrowRecord(BorrowRecord borrowRecord);

	public BorrowRecord selBorrowById(@Param("borrowID") Integer borrowID);

	public BorrowRecord selectBorrowByBookId(BorrowRecord borrowRecord);

	public void updateBorrowRecord(BorrowRecord borrowRecord);

	public List<BorrowRecord> selectAdBorrowMoFu(BorrowRecord borrowRecord);
}
