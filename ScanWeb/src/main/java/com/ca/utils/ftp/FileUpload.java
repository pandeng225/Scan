package com.ca.utils.ftp;

import com.ca.utils.lang.RDate;
import com.google.common.base.Throwables;
import com.google.common.io.Files;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

public class FileUpload {

    private static final Logger logger = LoggerFactory.getLogger(FileUpload.class);

    private File file;
    private MultipartFile multipartFile;
    private String inputFileName;
    private String outputFileName;
    private String sftpUploadConfigAlis;
    private String path;
    private FtpConfig ftpConfig;

    public FileUpload(String sftpUploadConfigAlis, MultipartFile file,FtpConfig ftpConfig) {
        this.sftpUploadConfigAlis = sftpUploadConfigAlis;
        this.multipartFile = file;
        this.ftpConfig = ftpConfig;
    }

    public FileUpload useRandomNewFileName() {
        useCustomNewFileName(RDate.toDateTimeStr("yyyyMMddHHmmss") + RandomStringUtils.randomNumeric(10) + "."
                + Files.getFileExtension(inputFileName));
        return this;
    }

    /**
     * 上传文件到资源服务器
     * @return
     */
    public FileUpload upload() {
        logger.info("文件:{}上传开始", outputFileName);
        StaticUploader f = null;
        try {
        	if(!ftpConfig.isLocation()){
	            f = new StaticUploader(ftpConfig);
	            f.sftpUpload(outputFileName,multipartFile.getInputStream(),path);
	            logger.info("文件:{}上传结束", outputFileName);
        	}else{
        		String destPath=ftpConfig.getLocationPath()+path;
        		File dir=new File(destPath);
        		if(!dir.exists()){
        			dir.mkdirs();
        		}
        		File dest=new File(destPath,outputFileName);
        		multipartFile.transferTo(dest);
        	}
        } catch (Exception e) {
            logger.error(outputFileName + "upload error !", e);
            Throwables.propagate(e);
        } finally {
        	if(f!=null)
            f.closeAll();
        }
        return this;
    }

    private String concatPath(String basePath, String fullFilenameToAdd) {
        String ch = StringUtils.endsWith(basePath, "/") || StringUtils.startsWith(fullFilenameToAdd, "/") ? "" : "/";
        return basePath + ch + fullFilenameToAdd;
    }

    public FileUpload useCustomNewFileName(String fileName) {
        this.outputFileName = fileName;
        return this;
    }

    public FileUpload setInputFileName(String inputFileName) {
        this.inputFileName = inputFileName;
        return this;
    }

    public String getOutputFileName() {
        return outputFileName;
    }

    public FileUpload setPath(String path) {
        this.path = path;
        return this;
    }
}
