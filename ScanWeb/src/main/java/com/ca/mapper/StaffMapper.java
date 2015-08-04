package com.ca.mapper;

import com.ca.entity.Staff;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.List;
import java.util.Map;

public interface StaffMapper {
    int deleteByPrimaryKey(Integer staffId);

    int insert(Staff record);

    int insertSelective(Staff record);

    Staff selectByPrimaryKey(Integer staffId);

    int updateByPrimaryKeySelective(Staff record);

    int updateByPrimaryKey(Staff record);

    List<Map<?,?>> findAdminMenu(@Param("staffId") String staffId);

    Staff selectByStaffCode(@Param("staffCode")String staffCode);

    List<Map<String,String>> findAllStaffInitInfo(Map<String, Object> args, RowBounds rowbounds);

    List<Map<String,String>> queryRoleInfoList(Map<String, Object> args);

    String getStaffCode();

    Integer queryStaffCode(Map<String,Object> params);

    List<Map<String,String>> queryAllCityList(Map<String,Object> parmas);

    String creatStaffId();

    void addStaffInfo(Map map);

    void addStaffRoleR(Map map);

    void addStaffGroupR(Map map);

    void addStaffBusiRes(Map map);

    List<Map> queryRoleListByStaffID(Map map);

    List<Map> queryGroupListByStaffID(@Param("p")Map map);

    List<Map> queryStaffBusiRes(Map map);

    void updateStaffInfo(Map map);

    void deleteStaffRoleR(Map map);

    void deleteStaffGroupR(Map map);

    void deleteStaffBusiRes(Map map);

    void deleteStaffByID(Map map);

    Map checkOldPassWd(Map map);

    Integer modifyPassword(Map map);
}