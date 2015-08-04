package com.ca.entity;

import java.util.Date;

public class AgentAccount {
	private Integer agentId;
	
	private Long totalBalance;
	
	private Long availableBalance;
	
	private Long freezeMoney;
	
	private Long refundFreezeMoney;
	
	private Long creditLimit;
	
	private Long usedLimit;
	
	private String paymentCode;
	
	private String salt;
	
	private Date addDate;
	
	private String accountNature;
	
	private String accountDesc;
	
	public Integer getAgentId() {
		return agentId;
	}
	
	public void setAgentId(Integer agentId) {
		this.agentId = agentId;
	}
	
	public Long getTotalBalance() {
		return totalBalance;
	}
	
	public void setTotalBalance(Long totalBalance) {
		this.totalBalance = totalBalance;
	}
	
	public Long getAvailableBalance() {
		return availableBalance;
	}
	
	public void setAvailableBalance(Long availableBalance) {
		this.availableBalance = availableBalance;
	}
	
	public Long getFreezeMoney() {
		return freezeMoney;
	}
	
	public void setFreezeMoney(Long freezeMoney) {
		this.freezeMoney = freezeMoney;
	}
	
	public Long getRefundFreezeMoney() {
		return refundFreezeMoney;
	}
	
	public void setRefundFreezeMoney(Long refundFreezeMoney) {
		this.refundFreezeMoney = refundFreezeMoney;
	}
	
	public Long getCreditLimit() {
		return creditLimit;
	}
	
	public void setCreditLimit(Long creditLimit) {
		this.creditLimit = creditLimit;
	}
	
	public Long getUsedLimit() {
		return usedLimit;
	}
	
	public void setUsedLimit(Long usedLimit) {
		this.usedLimit = usedLimit;
	}
	
	public String getPaymentCode() {
		return paymentCode;
	}
	
	public void setPaymentCode(String paymentCode) {
		this.paymentCode = paymentCode == null ? null : paymentCode.trim();
	}
	
	public String getSalt() {
		return salt;
	}
	
	public void setSalt(String salt) {
		this.salt = salt == null ? null : salt.trim();
	}
	
	public Date getAddDate() {
		return addDate;
	}
	
	public void setAddDate(Date addDate) {
		this.addDate = addDate;
	}
	
	public String getAccountNature() {
		return accountNature;
	}
	
	public void setAccountNature(String accountNature) {
		this.accountNature = accountNature;
	}
	
	public String getAccountDesc() {
		return accountDesc;
	}
	
	public void setAccountDesc(String accountDesc) {
		this.accountDesc = accountDesc;
	}
	
	@Override
	public String toString() {
		return "AgentAccount [agentId=" + agentId + ", totalBalance="
				+ totalBalance + ", availableBalance=" + availableBalance
				+ ", freezeMoney=" + freezeMoney + ", refundFreezeMoney="
				+ refundFreezeMoney + ", creditLimit=" + creditLimit
				+ ", usedLimit=" + usedLimit + ", paymentCode=" + paymentCode
				+ ", salt=" + salt + ", addDate=" + addDate
				+ ", accountNature=" + accountNature + ",accountDesc="
				+ accountDesc + "]";
	}
	
}
