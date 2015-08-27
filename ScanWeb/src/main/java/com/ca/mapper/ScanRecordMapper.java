package com.ca.mapper;

import com.ca.entity.ScanRecord;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

public interface ScanRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(ScanRecord record);

    int insertSelective(ScanRecord record);

    ScanRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ScanRecord record);

    int updateByPrimaryKey(ScanRecord record);

    List<ScanRecord> findAllRecord(ScanRecord params, RowBounds rowBounds);

    int insertBatchSelective(Map<String, Object> map);

    List<ScanRecord> selectRecords(ScanRecord params);
}