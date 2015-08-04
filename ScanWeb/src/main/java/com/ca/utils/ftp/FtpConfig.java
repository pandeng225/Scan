package com.ca.utils.ftp;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Ftp配置类.
 * @author maxim
 *
 */
@Component
public class FtpConfig implements java.io.Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -3065243221249417206L;

    @Value("${sftp.ip}")
    private String ip;

    @Value("${sftp.port}")
    private int port;

    @Value("${sftp.loginName}")
    private String loginName;

    @Value("${sftp.password}")
    private String password;

    @Value("${sftp.remotePath}")
    private String remotePath;

    @Value("${sftp.remoteBackPath}")
    private String remoteBackPath;

    @Value("${host.hostImage}")
	private String hostImage;
    
    @Value("${sftp.islocation}")
    private boolean location=true;//默认上传本地
    
    @Value("${sftp.locationPath}")
    private String locationPath; //本地目录
    
    public FtpConfig(){}

    /**
     * 不带端口的构成函数(默认端口21).
     * @param ip ip
     * @param name 用户名
     * @param password 密码
     */
    public FtpConfig(String ip, String name, String password) {
        init(ip, 21, name, password);
    }

    /**
     * 带端口的构成函数.
     * @param ip ip
     * @param port 端口
     * @param name 用户名
     * @param password 密码
     */
    public FtpConfig(String ip, int port, String name, String password) {
        init(ip, port, name, password);
    }

    /**
     * 构成函数.
     * @param ip ip.
     * @param port 端口.
     * @param loginName 用户名.
     * @param password 密码.
     * @param remotePath 上传路径.
     */
    public FtpConfig(String ip, int port, String loginName, String password, String remotePath) {
        super();
        this.ip = ip;
        this.port = port;
        this.loginName = loginName;
        this.password = password;
        this.remotePath = remotePath;
    }

    private void init(String ip, int port, String loginName, String password) {
        this.ip = ip;
        this.port = port;
        this.loginName = loginName;
        this.password = password;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String name) {
        this.loginName = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRemotePath() {
        return remotePath;
    }

    public void setRemotePath(String remotePath) {
        this.remotePath = remotePath;
    }

    public String getRemoteBackPath() {
        return remoteBackPath;
    }

    public void setRemoteBackPath(String remoteBackPath) {
        this.remoteBackPath = remoteBackPath;
    }

	public String getHostImage() {
		return hostImage;
	}

	public void setHostImage(String hostImage) {
		this.hostImage = hostImage;
	}

	public boolean isLocation() {
		return location;
	}

	public void setLocation(boolean location) {
		this.location = location;
	}

	public String getLocationPath() {
		return locationPath;
	}

	public void setLocationPath(String locationPath) {
		this.locationPath = locationPath;
	}

}
