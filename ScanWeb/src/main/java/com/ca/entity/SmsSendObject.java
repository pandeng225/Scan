package com.ca.entity;

import java.util.Date;

public class SmsSendObject extends SmsSendObjectKey {
    private String sendObjectDesc;

    private String smsChannelCode;

    private String sendObject;

    private String remark;

    private String updateStaffId;

    private String updateDepartId;

    private Date updateTime;

    public String getSendObjectDesc() {
        return sendObjectDesc;
    }

    public void setSendObjectDesc(String sendObjectDesc) {
        this.sendObjectDesc = sendObjectDesc == null ? null : sendObjectDesc.trim();
    }

    public String getSmsChannelCode() {
        return smsChannelCode;
    }

    public void setSmsChannelCode(String smsChannelCode) {
        this.smsChannelCode = smsChannelCode == null ? null : smsChannelCode.trim();
    }

    public String getSendObject() {
        return sendObject;
    }

    public void setSendObject(String sendObject) {
        this.sendObject = sendObject == null ? null : sendObject.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getUpdateStaffId() {
        return updateStaffId;
    }

    public void setUpdateStaffId(String updateStaffId) {
        this.updateStaffId = updateStaffId == null ? null : updateStaffId.trim();
    }

    public String getUpdateDepartId() {
        return updateDepartId;
    }

    public void setUpdateDepartId(String updateDepartId) {
        this.updateDepartId = updateDepartId == null ? null : updateDepartId.trim();
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}