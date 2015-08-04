package com.ca.utils.ftp;

import net.sf.commons.ssh.*;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.FastDateFormat;

import java.io.*;
import java.util.*;

public class StaticUploader implements Closeable {

    private static FastDateFormat fmt = FastDateFormat.getInstance("yyyy_MM_dd_HH_mm_ss_");

    private List<FtpConfig> configList;
    private List<SftpItem> sftpItemList;

    private static class SftpItem {
        Connection connection;
        SftpSession sftpSession;
        SftpSession backSession;
        FtpConfig ftpConfig;
        String lastPath;
        String lastBackPath;

    }

    public StaticUploader(String configKey) throws IOException {
//        configList = getConfig("staticftp.csv", configKey);
        initConnection();
    }

    public StaticUploader(FtpConfig ftpConfig) throws IOException {
        configList = new ArrayList<FtpConfig>();
        configList.add(ftpConfig);
        initConnection();
    }

    /**
     * @throws java.io.IOException
     */
    private void initConnection() throws IOException {
        sftpItemList = new ArrayList<SftpItem>(configList.size());

        Set<String> requiredFeatures = new HashSet<String>();
        ConnectionFactory connectionFactory = ConnectionFactory.newInstance(
                "net.sf.commons.ssh.jsch.JschConnectionFactory", requiredFeatures);
        createSftpItemList(connectionFactory);
    }

    public void closeAll() {
        for (SftpItem sftpItem : sftpItemList) {
            if (sftpItem.backSession != null) {
                try {
                    sftpItem.backSession.close();
                }
                catch (IOException e) {
                    e.printStackTrace();
                }
            }
            try {
                sftpItem.sftpSession.close();
            }
            catch (IOException e) {
                e.printStackTrace();
            }
            try {
                sftpItem.connection.close();
            }
            catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void createSftpItemList(ConnectionFactory connectionFactory) throws IOException {
        for (FtpConfig ftpConfig : configList) {
            AuthenticationOptions authOptions = new PasswordAuthenticationOptions(ftpConfig.getLoginName(),
                    ftpConfig.getPassword());
            Connection connection = connectionFactory.openConnection(ftpConfig.getIp(), authOptions);
            SftpSessionOptions sftpSessionOptions = new SftpSessionOptions();
            SftpSession sftpSession = connection.openSftpSession(sftpSessionOptions);
            SftpItem sftpItem = new SftpItem();
            sftpItem.lastPath = getRemoteDir(null, ftpConfig);
            recursiveCd(sftpSession, sftpItem.lastPath);

            SftpSession backSession = null;

            if (StringUtils.isNotEmpty(ftpConfig.getRemoteBackPath())) {
                sftpItem.lastBackPath = getRemoteBackDir(null, ftpConfig, sftpItem.lastPath);
                backSession = connection.openSftpSession(sftpSessionOptions);
                recursiveCd(backSession, sftpItem.lastBackPath);
            }

            sftpItem.connection = connection;
            sftpItem.sftpSession = sftpSession;
            sftpItem.backSession = backSession;
            sftpItem.ftpConfig = ftpConfig;

            sftpItemList.add(sftpItem);
        }
    }

    /**
     * SFTP上传。
     *
     *  配置主键，一个主键可以配置多个上传路径。
     * @param fileName 不携带路径的上传文件名。
     * @param fileContent 上传文件内容。
     * @throws java.io.IOException
     */
    public void sftpUpload(String fileName, String fileContent) throws IOException {
        sftpUpload(fileName, fileContent, null);
    }

    public void sftpDelete(String fileName, String fileDir) throws IOException {

        for (SftpItem sftpItem : sftpItemList) {
            FtpConfig ftpConfig = sftpItem.ftpConfig;

            String remoteDir = getRemoteDir(fileDir, ftpConfig);
            if (!StringUtils.equals(remoteDir, sftpItem.lastPath)) {
                sftpItem.lastPath = remoteDir;
                recursiveCd(sftpItem.sftpSession, remoteDir);
            }

            sftpItem.sftpSession.rm(fileName);
        }
    }

    /**
     * SFTP上传。
     *
     *  配置主键，一个主键可以配置多个上传路径。
     * @param fileName 不携带路径的上传文件名。
     * @param file 上传文件。
     * @throws java.io.IOException
     * @throws java.io.FileNotFoundException
     */
    public void sftpUpload(String fileName, File file) throws FileNotFoundException, IOException {
        sftpUpload(fileName, file, null);
    }

    /**
     * SFTP上传。
     *
     *  配置主键，一个主键可以配置多个上传路径。
     * @param fileName 不携带路径的上传文件名。
     * @param fileContent 上传文件内容。
     * @param fileDir 上传目录。如果不指定，则使用配置中设置的上传目录。如果指定，但是不以/开头，则使用配置中指定的目录为相对目录。
     * @throws java.io.IOException
     */
    public void sftpUpload(String fileName, String fileContent, String fileDir) throws IOException {
        String backFileName = fmt.format(new Date()) + fileName;

        for (SftpItem sftpItem : sftpItemList) {
            InputStream inputStream = IOUtils.toInputStream(fileContent);
            sftpUpload(fileName, inputStream, backFileName, sftpItem, fileDir);
        }
    }

    public void sftpUpload(String fileName, InputStream fileContent, String fileDir) throws IOException {
        String backFileName = fmt.format(new Date()) + fileName;
        for (SftpItem sftpItem : sftpItemList) {
            sftpUpload(fileName, fileContent, backFileName, sftpItem, fileDir);
        }
    }

    public static boolean isWindows() {
        String os = System.getProperty("os.name").toLowerCase();
        // windows
        return os.indexOf("win") >= 0;
    }

    private static void recursiveCd(SftpSession sftpSession, String path) throws IOException {
        if (path.indexOf("/") == 0) {
            sftpSession.cd("/");
        }

        String[] subPaths = path.split("/");
        for (String subPath : subPaths) {
            if (StringUtils.isEmpty(subPath)) {
                continue;
            }

            try {
                sftpSession.cd(subPath);
            }
            catch (IOException e) {
                sftpSession.mkdir(subPath);
                sftpSession.cd(subPath);
            }
        }
    }

    /**
     * SFTP上传。
     *
     * 配置主键，一个主键可以配置多个上传路径。
     * @param fileName 不携带路径的上传文件名。
     * @param file 上传文件。
     * @param fileDir 上传目录。如果不指定，则使用配置中设置的上传目录。如果指定，但是不以/开头，则使用配置中指定的目录为相对目录。
     * @throws java.io.IOException
     * @throws java.io.FileNotFoundException
     */
    public void sftpUpload(String fileName, File file,String fileDir) throws FileNotFoundException,
            IOException {
        String backFileName = fmt.format(new Date()) + fileName;

        for (SftpItem sftpItem : sftpItemList) {
            try {
                sftpUpload(fileName, new FileInputStream(file), backFileName, sftpItem, fileDir);
            }
            catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 专门为商品静态化写的上传代码(请不要调用)
     * @param filePath
     * @param fileDir
     * @throws java.io.IOException
     */
    public void sftpUpload2(String filePath, String fileDir) throws IOException {
        for (SftpItem sftpItem : sftpItemList) {
            FtpConfig ftpConfig = sftpItem.ftpConfig;

            String remoteDir = getRemoteDir(null, ftpConfig);
            if (!StringUtils.equals(remoteDir, sftpItem.lastPath)) {
                sftpItem.lastPath = remoteDir;
                recursiveCd(sftpItem.sftpSession, remoteDir);
            }

            try {
                sftpItem.sftpSession.ls(fileDir);
            }
            catch (Exception ex) {
                sftpItem.sftpSession.mkdir(fileDir);
            }
            sftpItem.sftpSession.put(filePath + "/" + fileDir + "/*", fileDir);
        }
    }

    private void sftpUpload(String fileName, InputStream fileContent, String backFileName, SftpItem sftpItem,
            String fileDir) throws IOException {
        try {

            FtpConfig ftpConfig = sftpItem.ftpConfig;
            //            logger.info("->上传文件开始-----name:{},config:{}", fileName, ToStringBuilder.reflectionToString(ftpConfig));

            String remoteDir = getRemoteDir(fileDir, ftpConfig);
            if (!StringUtils.equals(remoteDir, sftpItem.lastPath)) {
                sftpItem.lastPath = remoteDir;
                recursiveCd(sftpItem.sftpSession, remoteDir);
            }

            sftpItem.sftpSession.put(fileContent, fileName);
            if (sftpItem.backSession != null) {
                String remoteBackDir = getRemoteBackDir(fileDir, ftpConfig, remoteDir);
                if (!StringUtils.equals(remoteBackDir, sftpItem.lastBackPath)) {
                    sftpItem.lastBackPath = remoteBackDir;
                    recursiveCd(sftpItem.backSession, remoteBackDir);
                }
                sftpItem.backSession.put(fileContent, backFileName);
            }
            //            logger.info("->上传文件结束-----{}-----", fileName);
        }
        finally {
            try {
                if (fileContent != null) {
                    fileContent.close();
                }
            }
            catch (Exception ex) {
                // Quietly.
            }
        }
    }

    private String getRemoteBackDir(String fileDir, FtpConfig ftpConfig, String remoteDir) {
        String remoteBackPath = ftpConfig.getRemoteBackPath();
        if (StringUtils.isEmpty(fileDir)) { return remoteBackPath; }

        if (StringUtils.isEmpty(remoteBackPath)) { return null; }

        if (fileDir.charAt(0) == '\\') { return new File(remoteDir, "back").toString(); }

        return StringUtils.replace(new File(remoteBackPath, fileDir).getPath(), "\\", "/");
    }

    private String getRemoteDir(String fileDir, FtpConfig ftpConfig) {
        if (StringUtils.isEmpty(fileDir)) { return ftpConfig.getRemotePath(); }

        if (fileDir.charAt(0) == '/') { return fileDir; }
        return StringUtils.replace(new File(ftpConfig.getRemotePath(), fileDir).getPath(), "\\", "/");
    }

    @Override
    public void close() throws IOException {
        closeAll();
    }

}
