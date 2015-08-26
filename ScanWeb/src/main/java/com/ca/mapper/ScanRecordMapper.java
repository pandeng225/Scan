package com.ca.mapper;

import com.ca.entity.ScanRecord;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

public interface ScanRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ScanRecord record);

    int insertSelective(ScanRecord record);

    ScanRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ScanRecord record);

    int updateByPrimaryKey(ScanRecord record);

    List<ScanRecord> findAllRecord(ScanRecord params, RowBounds rowBounds);

    int insertBatchSelective(List<ScanRecord> params);

    List<ScanRecord> selectRecords(ScanRecord params);
}