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
import java.util.HashMap;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/3/16.
 */
@Controller
@RequestMapping("/admin/am")
public class NoticeImagesUploadController {

    private static final Logger logger = LoggerFactory.getLogger(NoticeImagesUploadController.class);

    private static final ImmutableList<String> extNameSelect = ImmutableList.of("jpg","gif","bmp","jpeg","png");

    @Resource
    private FtpConfig ftpConfig;

    @RequestMapping("/noticeImagesUpload")
    @ResponseBody
    public Map noticeImagesUpload(MultipartFile imgFile){

        try {
            Map r = validateUploadFile(imgFile);
            if(r!=null && r.containsKey("key")){
                r.put("RespCode", "9999");
                return r;
            }

            FileUpload image = new FileUpload("image",imgFile,ftpConfig).setInputFileName(imgFile.getOriginalFilename()).useRandomNewFileName()
                    .setPath("uploader/noticeimages/")
                    .upload();//.generatePublishFile();

            String filePath = "/uploader/noticeimages/" + image.getOutputFileName();
            String viewPath = ftpConfig.getHostImage() + filePath;
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("url",viewPath);
            map.put("error", 0);
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("------>公告上传图片异常<-----", e);
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

        return uploadResult;
    }

}
