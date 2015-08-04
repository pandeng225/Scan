package com.ca.entity;

import java.util.Date;

public class SmsSendTime extends SmsSendTimeKey {
    private String sendTimeDesc;

    private String smsChannelCode;

    private String smsStartDate;

    private String smsEndDate;

    private String smsStartTime;

    private String smsEndTime;

    private String remark;

    private String updateStaffId;

    private String updateDepartId;

    private Date updateTime;

    public String getSendTimeDesc() {
        return sendTimeDesc;
    }

    public void setSendTimeDesc(String sendTimeDesc) {
        this.sendTimeDesc = sendTimeDesc == null ? null : sendTimeDesc.trim();
    }

    public String getSmsChannelCode() {
        return smsChannelCode;
    }

    public void setSmsChannelCode(String smsChannelCode) {
        this.smsChannelCode = smsChannelCode == null ? null : smsChannelCode.trim();
    }

    public String getSmsStartDate() {
        return smsStartDate;
    }

    public void setSmsStartDate(String smsStartDate) {
        this.smsStartDate = smsStartDate == null ? null : smsStartDate.trim();
    }

    public String getSmsEndDate() {
        return smsEndDate;
    }

    public void setSmsEndDate(String smsEndDate) {
        this.smsEndDate = smsEndDate == null ? null : smsEndDate.trim();
    }

    public String getSmsStartTime() {
        return smsStartTime;
    }

    public void setSmsStartTime(String smsStartTime) {
        this.smsStartTime = smsStartTime == null ? null : smsStartTime.trim();
    }

    public String getSmsEndTime() {
        return smsEndTime;
    }

    public void setSmsEndTime(String smsEndTime) {
        this.smsEndTime = smsEndTime == null ? null : smsEndTime.trim();
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