package com.ca.utils.ftp;

import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

/**
 *
 * @author LIHAO
 *
 */
public class UploadCommon {

    /**
     * 检查是否是图片格式.
     * @param extName .jpg
     * @param extNameSelect .jpg .png .psd 集合
     * @return boolean
     */
    public static boolean checkIsImage(String extName, List<String> extNameSelect) {
        boolean flag = false;
        if (null != extName && !"".equals(extName) && null != extNameSelect && 0 != extNameSelect.size()) {
            for (String string : extNameSelect) {
                if (string.equalsIgnoreCase(extName)) {
                    flag = true;
                    break;
                }
            }
        }
        return flag;
    }

    /**
     * 检查上传文件大小.
     * @param file 文件路径
     * @param size 多少k
     * @return boolean
     * @throws java.io.IOException File错误
     */
    public static boolean checkSize(File file, int size) throws IOException {
        boolean flag = true;
        FileInputStream fis = new FileInputStream(file);
        if (fis.available() / 1024 >= size) {
            flag = false;
        }
        fis.close();
        fis = null;
        return flag;
    }

    /**
     * 检查上传文件大小.
     * @param file 文件路径
     * @param size 多少k
     * @return boolean
     * @throws java.io.IOException File错误
     */
    public static boolean checkSize(MultipartFile file, int size) throws IOException {
        boolean flag = true;
        InputStream fis = file.getInputStream();
        if (fis.available() / 1024 >= size) {
            flag = false;
        }
        fis.close();
        fis = null;
        return flag;
    }

    /**
     * 检查图片的尺寸.
     * @param file 文件路径
     * @param width 图片的宽
     * @param height 图片的高
     * @return boolean
     * @throws java.io.IOException File错误
     */
    public static boolean checkWH(File file, int width, int height) throws IOException {
        boolean flag = true;
        BufferedImage bi = ImageIO.read(file);
        if (bi.getWidth() != width || bi.getHeight() != height) {
            flag = false;
        }
        return flag;
    }

    /**
     * 获取随机数.
     * @return int
     */
    public static int getRannum() {
        Random r = new Random();
        int rannum = r.nextInt() * (99999 - 10000 + 1) + 10000;
        return rannum;
    }

    /**
     * 获取当前日期.
     * @param format 日期格式化
     * @return String
     */
    public static String getCurrDate(String format) {
        SimpleDateFormat sDateFormat = new SimpleDateFormat(format);
        return sDateFormat.format(new Date());
    }
}
