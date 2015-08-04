package com.ca.entity;

public class SysWebCity {
    private String cityCode;

    private String cityName;

    private String provinceCode;

    private String essProvinceCode;

    private String essCityCode;

    private Short orderNumber;

    private String values1;

    private String values2;

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode == null ? null : cityCode.trim();
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName == null ? null : cityName.trim();
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode == null ? null : provinceCode.trim();
    }

    public String getEssProvinceCode() {
        return essProvinceCode;
    }

    public void setEssProvinceCode(String essProvinceCode) {
        this.essProvinceCode = essProvinceCode == null ? null : essProvinceCode.trim();
    }

    public String getEssCityCode() {
        return essCityCode;
    }

    public void setEssCityCode(String essCityCode) {
        this.essCityCode = essCityCode == null ? null : essCityCode.trim();
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