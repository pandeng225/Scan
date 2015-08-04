package com.ca.mapper;

import com.ca.entity.SysWebCity;

import java.util.List;
import java.util.Map;

public interface SysWebCityMapper {
    int insert(SysWebCity record);

    int insertSelective(SysWebCity record);
    
    List<Map<String, String>> queryAllCity(Map<String, Object> m);
}