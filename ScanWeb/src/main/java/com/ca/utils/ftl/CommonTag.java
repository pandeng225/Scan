package com.ca.utils.ftl;

import org.springframework.stereotype.Service;

@Service
public class CommonTag {
	
	private String hostRes;
	private String hostAdmRes;
	
	private String hostRoot;
	private String domain;
	
	private String hostFile;
	
	private String hostImage;

    private String ecsRoot;
    
    private String ecsHome;
    
    private String ecsMall;

    private String ecsAdminRoot;

    private String ecsOrder;

    private String ecsNum;

    private String ecsS;

    public String getEcsS() {
        return ecsS;
    }

    public void setEcsS(String ecsS) {
        this.ecsS = ecsS;
    }

    public String getEcsNum() {
        return ecsNum;
    }

    public void setEcsNum(String ecsNum) {
        this.ecsNum = ecsNum;
    }

    public String getEcsOrder() {
        return ecsOrder;
    }

    public void setEcsOrder(String ecsOrder) {
        this.ecsOrder = ecsOrder;
    }

    public String getEcsRoot() {
        return ecsRoot;
    }

    public void setEcsRoot(String ecsRoot) {
        this.ecsRoot = ecsRoot;
    }

    public String getEcsAdminRoot() {
        return ecsAdminRoot;
    }

    public void setEcsAdminRoot(String ecsAdminRoot) {
        this.ecsAdminRoot = ecsAdminRoot;
    }

    public String getHostRes() {
		return hostRes;
	}
	public void setHostRes(String hostRes) {
		this.hostRes = hostRes;
	}
	public String getHostRoot() {
		return hostRoot;
	}
	public void setHostRoot(String hostRoot) {
		this.hostRoot = hostRoot;
	}
	
	public String res(String path){
		return path==null? hostRes:hostRes+path;
	}
	public String admres(String path){
		return path==null? hostAdmRes:hostAdmRes+path;
	}
	
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getHostAdmRes() {
		return hostAdmRes;
	}
	public void setHostAdmRes(String hostAdmRes) {
		this.hostAdmRes = hostAdmRes;
	}
	public String getHostFile() {
		return hostFile;
	}
	public void setHostFile(String hostFile) {
		this.hostFile = hostFile;
	}
	public String getHostImage() {
		return hostImage;
	}
	public void setHostImage(String hostImage) {
		this.hostImage = hostImage;
	}

	public String getEcsHome() {
		return ecsHome;
	}

	public void setEcsHome(String ecsHome) {
		this.ecsHome = ecsHome;
	}

	public String getEcsMall() {
		return ecsMall;
	}

	public void setEcsMall(String ecsMall) {
		this.ecsMall = ecsMall;
	}

}
