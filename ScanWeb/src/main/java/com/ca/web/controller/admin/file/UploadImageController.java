package com.ca.web.controller.admin.file;

import com.ca.utils.ftp.FileUpload;
import com.ca.utils.ftp.FtpConfig;
import com.ca.utils.ftp.UploadCommon;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Maps;
import com.google.common.io.Files;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/3/12.
 */
@Controller
@RequestMapping("/admin/am")
public class UploadImageController {

    private static final ImmutableList<String> extNameSelect = ImmutableList.of("jpg","gif","bmp","jpeg","png");
    private static final Logger logger = LoggerFactory.getLogger(UploadImageController.class);


    @Resource
    private FtpConfig ftpConfig;

      /**
     * 上传图片.
     * @return String
     */
    @RequestMapping("/uploadImage/uploadFile")
    @ResponseBody
    public Map uploadFile(MultipartFile img,Integer num) {


        try {
            Map r = validateUploadFile(img);
                if(r!=null && r.containsKey("key")){
                r.put("RespCode", "9999");
                return r;
            }

            FileUpload image = new FileUpload("image",img,ftpConfig).setInputFileName(img.getOriginalFilename()).useRandomNewFileName()
                    .setPath("uploader/goodsimages")
                    .upload();//.generatePublishFile();

            String filePath = "/uploader/goodsimages/" + image.getOutputFileName();
            String viewPath = ftpConfig.getHostImage() + filePath;
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("key",viewPath);
            map.put("imgValue",filePath);
            map.put("num",num);
            map.put("biggerThanH",false);
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("------>上传图片异常<-----", e);
            return ImmutableMap.of("RespCode", "9999", "key", "ioError");
        } 

    }

    public Map validateUploadFile(MultipartFile multipartFile) throws Exception{
        Map uploadResult = Maps.newHashMap();
        //检查上传的图片是否符合格式
        if (!UploadCommon.checkIsImage(Files.getFileExtension(multipartFile.getOriginalFilename()), extNameSelect)) {
            uploadResult.put("key", "extNameError");
            return uploadResult;
        }
        //检查图像的大小
        if (!UploadCommon.checkSize(multipartFile, 300)) {
            uploadResult.put("key", "sizeError");
            return uploadResult;
        }
        //检查图片的尺寸
        BufferedImage bi = ImageIO.read(multipartFile.getInputStream());
        if(bi!=null){
            if (bi.getWidth() != 480 && bi.getHeight() != 320) {
                uploadResult.put("key", "whError");
                return uploadResult;
            }
        }else {
            uploadResult.put("key", "fileTypeError");
            return uploadResult;
        }

        //判断是否大于800*800
        if (bi.getWidth() >= 800 && bi.getHeight() >= 800) {
            uploadResult.put("biggerThanH",true);
        }

        return uploadResult;
    }

    public Map validateUploadFile(File img) throws IOException {
        Map uploadResult = Maps.newHashMap();
        //检查上传的图片是否符合格式
        if (!UploadCommon.checkIsImage(Files.getFileExtension(img.getName()), extNameSelect)) {
            uploadResult.put("key", "extNameError");
        }
        //检查图像的大小
        if (!UploadCommon.checkSize(img, 300)) {
            uploadResult.put("key", "sizeError");
        }
        //检查图片的尺寸
        BufferedImage bi = ImageIO.read(img);
        if (bi.getWidth() < 310 || bi.getHeight() < 310) {
            uploadResult.put("key", "whError");
        }

        //判断是否大于800*800
        if (bi.getWidth() >= 800 && bi.getHeight() >= 800) {
            uploadResult.put("biggerThanH",true);
        }

        if (uploadResult.containsKey("key")) {
            img.delete();
            uploadResult.put("RespCode", "9999");
        }
        return uploadResult;
    }

    public FtpConfig getFtpConfig() {
        return ftpConfig;
    }

    public void setFtpConfig(FtpConfig ftpConfig) {
        this.ftpConfig = ftpConfig;
    }
}
