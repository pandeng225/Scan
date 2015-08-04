package com.ca.entity;

public class SmsSendTimeKey {
    private Integer sendTimeCode;

    private String eparchyCode;

    public Integer getSendTimeCode() {
        return sendTimeCode;
    }

    public void setSendTimeCode(Integer sendTimeCode) {
        this.sendTimeCode = sendTimeCode;
    }

    public String getEparchyCode() {
        return eparchyCode;
    }

    public void setEparchyCode(String eparchyCode) {
        this.eparchyCode = eparchyCode == null ? null : eparchyCode.trim();
    }
}