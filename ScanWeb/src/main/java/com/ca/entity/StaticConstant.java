package com.ca.entity;

public class StaticConstant {

	private String typeId;
	private String dataKey;
	private String dataValue;
	private String isEnable;

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getDataKey() {
		return dataKey;
	}

	public void setDataKey(String dataKey) {
		this.dataKey = dataKey;
	}

	public String getDataValue() {
		return dataValue;
	}

	public void setDataValue(String dataValue) {
		this.dataValue = dataValue;
	}

	public String getIsEnable() {
		return isEnable;
	}

	public void setIsEnable(String isEnable) {
		this.isEnable = isEnable;
	}

	@Override
	public String toString() {
		return "StaticConstant [typeId=" + typeId + ", dataKey=" + dataKey
				+ ", dataValue=" + dataValue + ", isEnable=" + isEnable + "]";
	}

}
