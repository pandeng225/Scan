package com.ca.mapper;

import com.ca.entity.SysWebProvince;

import java.util.List;
import java.util.Map;

public interface SysWebProvinceMapper {
    int insert(SysWebProvince record);

    int insertSelective(SysWebProvince record);
    
    List<Map<String,String>> queryAllProvince(Map<String, Object> args);
}