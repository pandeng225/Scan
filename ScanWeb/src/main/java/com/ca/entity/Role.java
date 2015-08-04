package com.ca.entity;

import java.util.Date;

public class Role {
    private Integer roleId;

    private String roleName;

    private Integer merchantId;

    private String roleDesc;

    private String roleState;

    private Integer updateStaff;

    private Date updateTime;

    private String values1;

    private String values2;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    public Integer getMerchantId() {
        return merchantId;
    }

    public void setMerchantId(Integer merchantId) {
        this.merchantId = merchantId;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc == null ? null : roleDesc.trim();
    }

    public String getRoleState() {
        return roleState;
    }

    public void setRoleState(String roleState) {
        this.roleState = roleState == null ? null : roleState.trim();
    }

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