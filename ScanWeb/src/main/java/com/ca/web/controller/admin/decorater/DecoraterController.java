package com.ca.web.controller.admin.decorater;

import com.ca.entity.SysDecorater;
import com.ca.service.admin.decorater.DecoraterService;
import com.ca.shiro.realm.ShiroRealm;
import com.ca.utils.AdminUtil;
import com.ca.utils.ftp.FileUpload;
import com.ca.utils.ftp.FtpConfig;
import com.ca.utils.ftp.UploadCommon;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Maps;
import com.google.common.io.Files;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangxiang2 on 2015/3/17.
 */
@Controller
@RequestMapping("/admin/am/decorater")
public class DecoraterController {
	
	private static final String HOME_TOP_BANNAR = "HOME_TOP_BANNAR";
	private static final String HOME_TOP_BANNAR_DATA_TITLE = "首页头部广告";
    private static final ImmutableList<String> extNameSelect = ImmutableList.of("jpg","gif","bmp","jpeg","png");

	private static final Logger logger = LoggerFactory
			.getLogger(DecoraterController.class);

    @Resource
    private FtpConfig ftpConfig;

	@Resource
	private DecoraterService decoraterService;
	
	@RequestMapping("decoraterIndex")
    public String getDecoraterByTypeId(String typeId,Model model){
        if(StringUtils.isBlank(typeId))
            typeId = HOME_TOP_BANNAR;
        List<Map> decoraterList = decoraterService.getDecoraterByTypeId(typeId);
        for(Map map : decoraterList){
            Object o = map.get("CONTENT");
            if(o!=null) {
                String c = String.valueOf(o);
                if (StringUtils.isNotBlank(c)) {
                    String[] cArray = c.split(";");
                    map.put("CLICK_URL", cArray[0]);
                    map.put("IMAGE_URL", cArray[1]);
                }
            }
        }
        model.addAttribute("decoraterList",decoraterList);

        return "admin/decorater/decoraterIndex";
    }

    @RequestMapping("updateDecorater")
    @ResponseBody
	public Map updateDecorater(String typeId, String dataKey,String dataTitle,
                               String[] clickUrl,String[] imageUrl) {
		Map map = new HashMap();
		if(clickUrl==null || clickUrl.length==0 || imageUrl == null || imageUrl.length==0){
            map.put("result","false");
            map.put("msg","至少上传一条广告信息");
            return map;
        }
        ShiroRealm.AdminShiroUser adminShiroUser = AdminUtil.getAdminStaff();
        List<SysDecorater> sysDecoraterList = new ArrayList<SysDecorater>();
        SysDecorater sysDecorater = null;
        for(int i=0;i<clickUrl.length;i++){
            if(StringUtils.isNotBlank(clickUrl[i]) && StringUtils.isNotBlank(imageUrl[i])) {
                sysDecorater = new SysDecorater();
                sysDecorater.setTypeId(typeId);
                sysDecorater.setContent(clickUrl[i] + ";" + imageUrl[i]);
                sysDecorater.setStatus("1");
                sysDecorater.setDataKey(dataKey);
                sysDecorater.setDataTitle(dataTitle);
                sysDecorater.setOrderSeq(BigDecimal.valueOf(i));
                sysDecorater.setStaffId(String.valueOf(adminShiroUser.getStaffId()));
                sysDecoraterList.add(sysDecorater);
            }
        }
        int i = decoraterService.batchInsert(sysDecoraterList);
        if(i>0){
            map.put("result","true");
            map.put("msg","保存成功");
        }else{
            map.put("result","true");
            map.put("msg","保存失败");
        }
        return map;
	}

    /**
     * 上传图片.
     * @return String
     */
    @RequestMapping("/uploadImage")
    @ResponseBody
    public Map uploadFile(MultipartFile img,Integer num) {


        try {
            Map r = validateUploadFile(img);
            if(r!=null && r.containsKey("key")){
                r.put("RespCode", "9999");
                return r;
            }

            FileUpload image = new FileUpload("image",img,ftpConfig).setInputFileName(img.getOriginalFilename()).useRandomNewFileName()
                    .setPath("uploader/decoraterimages")
                    .upload();//.generatePublishFile();

            String filePath = "/uploader/decoraterimages/" + image.getOutputFileName();
            String viewPath = ftpConfig.getHostImage() + filePath;
            Map<String,Object> map = new HashMap<String, Object>();
            map.put("key",viewPath);
            map.put("imgValue",viewPath);
            map.put("num",num);
            return map;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("------>上传广告图片异常<-----", e);
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
        /*//检查图像的大小
        if (!UploadCommon.checkSize(multipartFile, 300)) {
            uploadResult.put("key", "sizeError");
            return uploadResult;
        }
        //检查图片的尺寸
        BufferedImage bi = ImageIO.read(multipartFile.getInputStream());
        if(bi!=null){
            if (bi.getWidth() < 310 || bi.getHeight() < 310) {
                uploadResult.put("key", "whError");
                return uploadResult;
            }
        }else {
            uploadResult.put("key", "fileTypeError");
            return uploadResult;
        }*/

        return uploadResult;
    }
	
}
