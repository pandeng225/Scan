package com.ca.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class AdminMenuTree implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1229757374379637538L;
	
	private String id;
	private String pid;
	private String name;
	private String rightcode;
	private String url;
	private String target;
	private Integer levelid;
	private String typeid;
	private String cls;
	private boolean leaf;
	private List<AdminMenuTree> children = new ArrayList<AdminMenuTree>();
	
	// @return 返回 name
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	// @param 对name进行赋值
	public void setName(String name) {
		this.name = name;
	}
	// @return 返回 rightcode
	
	public String getRightcode() {
		return rightcode;
	}
	// @param 对rightcode进行赋值
	public void setRightcode(String rightcode) {
		this.rightcode = rightcode;
	}
	// @return 返回 url
	
	public String getUrl() {
		return url;
	}
	// @param 对url进行赋值
	public void setUrl(String url) {
		this.url = url;
	}
	
	// @return 返回 levelid
	
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public Integer getLevelid() {
		return levelid;
	}
	// @param 对levelid进行赋值
	public void setLevelid(Integer levelid) {
		this.levelid = levelid;
	}
	// @return 返回 typeid
	
	public String getTypeid() {
		return typeid;
	}
	// @param 对typeid进行赋值
	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}
	// @return 返回 cls
	
	public String getCls() {
		return cls;
	}
	// @param 对cls进行赋值
	public void setCls(String cls) {
		this.cls = cls;
	}

	// @return 返回 leaf
	
	public boolean isLeaf() {
		return leaf;
	}
	// @param 对leaf进行赋值
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	// @return 返回 children
	
	public List<AdminMenuTree> getChildren() {
		return children;
	}
	// @param 对children进行赋值
	public void setChildren(List<AdminMenuTree> children) {
		this.children = children;
	}
}
