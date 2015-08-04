package com.ca.mapper;

import com.ca.entity.SysWebDistrict;

import java.util.List;
import java.util.Map;

public interface SysWebDistrictMapper {
    int insert(SysWebDistrict record);

    int insertSelective(SysWebDistrict record);
    
    List<Map<String, String>> queryAllDistrict(Map<String, Object> m);
}