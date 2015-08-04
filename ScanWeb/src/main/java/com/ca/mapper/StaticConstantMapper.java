package com.ca.mapper;

import com.ca.entity.StaticConstant;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface StaticConstantMapper {

	@Select("select * from SYS_P_STATIC where type_id = #{typeId} AND IS_ENABLE='1' ORDER BY data_key")
	public List<StaticConstant> queryByTypeId(String typeId);

    @Select("select DATA_VALUE from SYS_P_STATIC where type_id = #{typeId} AND DATA_KEY = #{datakey} AND IS_ENABLE='1'")
    public String queryByDataKey(@Param("typeId") String typeId, @Param("datakey") String datakey);

    @Select("select * from SYS_P_STATIC where type_id = #{typeId} AND DATA_KEY = #{datakey} AND IS_ENABLE='1'")
	public StaticConstant queryBylevel(@Param("typeId") String typeId, @Param("datakey") String datakey);

    @Select("select * from SYS_P_STATIC where type_id like '%'||#{typeId}||'%'  AND IS_ENABLE='1' ORDER BY data_key")
	public List<StaticConstant> queryInTypeId(String typeId);
    

}
