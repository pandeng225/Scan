package com.ca.mapper;

import com.ca.entity.RoleFuncRight;
import com.ca.entity.RoleFuncRightKey;

public interface RoleFuncRightMapper {
    int deleteByPrimaryKey(RoleFuncRightKey key);

    int insert(RoleFuncRight record);

    int insertSelective(RoleFuncRight record);

    RoleFuncRight selectByPrimaryKey(RoleFuncRightKey key);

    int updateByPrimaryKeySelective(RoleFuncRight record);

    int updateByPrimaryKey(RoleFuncRight record);
}