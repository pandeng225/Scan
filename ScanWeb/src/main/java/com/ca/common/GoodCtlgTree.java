package com.ca.common;

import java.util.ArrayList;
import java.util.List;

public class GoodCtlgTree {

	Long id;
	String text;
	String state;
	List<GoodCtlgTree> children=new ArrayList<GoodCtlgTree>();
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public List<GoodCtlgTree> getChildren() {
		return children;
	}
	public void setChildren(List<GoodCtlgTree> children) {
		this.children = children;
	}
	
}
