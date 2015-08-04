package com.ca.entity;

import java.util.Date;

public class StaffRole extends StaffRoleKey {
    private Integer updateStaff;

    private Date updateTime;

    private String values1;

    private String values2;

    public Integer getUpdateStaff() {
        return updateStaff;
    }

    public void setUpdateStaff(Integer updateStaff) {
        this.updateStaff = updateStaff;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
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