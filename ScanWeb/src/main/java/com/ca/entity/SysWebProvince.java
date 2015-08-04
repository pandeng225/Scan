package com.ca.entity;

public class SysWebProvince {
    private String provinceCode;

    private String provinceName;

    private String essProvinceCode;

    private Short orderNumber;

    private String values1;

    private String values2;

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode == null ? null : provinceCode.trim();
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName == null ? null : provinceName.trim();
    }

    public String getEssProvinceCode() {
        return essProvinceCode;
    }

    public void setEssProvinceCode(String essProvinceCode) {
        this.essProvinceCode = essProvinceCode == null ? null : essProvinceCode.trim();
    }

    public Short getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(Short orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getValues1() {
        return values1;
    }

    public void setValues1(String values1) {
        this.values1 = values1 == null ? null : values1.trim();
    }

    public String getValues2() {
        return values2;
    }

    public void setValues2(String values2) {
        this.values2 = values2 == null ? null : values2.trim();
    }
}