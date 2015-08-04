package com.ca.mapper;

import com.ca.entity.SysDecorater;

import java.util.List;
import java.util.Map;

public interface SysDecoraterMapper {
    int insert(SysDecorater record);

    int insertSelective(SysDecorater record);

    List<Map>  findAllDecoraterByTypeId(String typeId);

    int delete(SysDecorater record);

    int batchInsert(List<SysDecorater> sysDecoraterList);
}