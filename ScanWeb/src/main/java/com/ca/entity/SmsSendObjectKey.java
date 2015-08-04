package com.ca.entity;

public class SmsSendObjectKey {
    private Integer sendObjectCode;

    private String eparchyCode;

    public Integer getSendObjectCode() {
        return sendObjectCode;
    }

    public void setSendObjectCode(Integer sendObjectCode) {
        this.sendObjectCode = sendObjectCode;
    }

    public String getEparchyCode() {
        return eparchyCode;
    }

    public void setEparchyCode(String eparchyCode) {
        this.eparchyCode = eparchyCode == null ? null : eparchyCode.trim();
    }
}