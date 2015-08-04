package com.ca.mapper;

import com.ca.entity.StaffRole;
import com.ca.entity.StaffRoleKey;

public interface StaffRoleMapper {
    int deleteByPrimaryKey(StaffRoleKey key);

    int insert(StaffRole record);

    int insertSelective(StaffRole record);

    StaffRole selectByPrimaryKey(StaffRoleKey key);

    int updateByPrimaryKeySelective(StaffRole record);

    int updateByPrimaryKey(StaffRole record);

}