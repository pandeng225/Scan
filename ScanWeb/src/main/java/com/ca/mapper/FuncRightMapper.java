package com.ca.mapper;

import com.ca.entity.FuncRight;

public interface FuncRightMapper {
    int deleteByPrimaryKey(String rightCode);

    int insert(FuncRight record);

    int insertSelective(FuncRight record);

    FuncRight selectByPrimaryKey(String rightCode);

    int updateByPrimaryKeySelective(FuncRight record);

    int updateByPrimaryKey(FuncRight record);
}