package com.ca.service.admin.scan;

import com.ca.entity.ScanRecord;
import com.ca.mapper.ScanRecordMapper;
import com.ca.mapper.StaffMapper;
import com.ca.utils.pagination.model.Paging;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pandeng on 2015/7/20.
 */
@Service
public class ScanService {
    Logger logger = LoggerFactory.getLogger(ScanService.class);

    @Autowired
    ScanRecordMapper scanRecordMapper;


    public List<ScanRecord> findAllRecord(ScanRecord params, Paging<ScanRecord> pager) {
        return scanRecordMapper.findAllRecord(params,pager.getRowBounds());
    }

    public int add(List<ScanRecord> params) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ScanRecords",params);
        return scanRecordMapper.insertBatchSelective(map);
    }

    public List<ScanRecord> selectRecords(ScanRecord params) {

        return scanRecordMapper.selectRecords(params);
    }
}
