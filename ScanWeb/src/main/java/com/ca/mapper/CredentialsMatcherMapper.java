package com.ca.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

public interface CredentialsMatcherMapper {

	
	@Select("SELECT S.STAFF_ID STAFF_ID, S.STAFF_CODE STAFF_CODE, S.PASSWD PASSWD, S.STAFF_NAME STAFF_NAME, S.LINK_PHONE LINK_PHONE, S.EMAIL, S.ESS_STAFF_ID, S.INIT_PASSWORD_TAG, S.AREA_CODE,S.STAFF_TYPE  STAFF_TYPE  FROM SYS_D_STAFF S WHERE S.STAFF_CODE = #{staffCode} AND S.STAFF_STATUS='1'")
	Map<String, Object> getStaffInfoByStaffCode(@Param("staffCode") String staffCode);
	
}
