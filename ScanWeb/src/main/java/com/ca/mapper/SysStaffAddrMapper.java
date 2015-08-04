package com.ca.mapper;

import com.ca.entity.SysStaffAddr;

import java.util.List;
import java.util.Map;

public interface SysStaffAddrMapper {
    int insert(SysStaffAddr record);

    int insertSelective(SysStaffAddr record);
    
    List<Map<String,Object>> findOneAddr(SysStaffAddr addr);
    
    int update(SysStaffAddr record);
    
    int updateSelective(SysStaffAddr record);
    
    
}