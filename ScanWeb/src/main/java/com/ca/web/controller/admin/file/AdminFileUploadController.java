/**
 * 
 */
package com.ca.web.controller.admin.file;

import com.ca.utils.ftp.FileUpload;
import com.ca.utils.ftp.FtpConfig;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * @author Weiwy
 * 
 */
@Controller
@RequestMapping(value = "/admin/am/file/upload")
public class AdminFileUploadController {

	@Resource
	private FtpConfig ftpConfig;

	private static final long FILE_SIZE = 5 << 20; // 5M
	private static final String regstr = "\\W";
	static final Pattern pattern = Pattern.compile(regstr);

	@RequestMapping(value = "/addImageCK", method = RequestMethod.POST)
	public void addImages(@RequestParam MultipartFile upload,
			HttpServletRequest request, HttpServletResponse resp, Model model)
			throws IOException {
		resp.setContentType("text/html;charset=UTF-8");
		resp.setHeader("X-Frame-Options", "SAMEORIGIN");
		resp.setCharacterEncoding("GBK");
		PrintWriter out = resp.getWriter();
		String callback = request.getParameter("CKEditorFuncNum");
		Map<String, Object> map = new HashMap<String, Object>();
		if (upload.getSize() > FILE_SIZE || upload.getSize() <= 0) {
			map.put("success", Boolean.FALSE);
			map.put("error", "文件大小超过限制");
			out.print("<script type=\"text/javascript\">");
			out.print("alert(" + map.get("error") + ")");
			out.print("<script>window.parent.CKEDITOR.tools.callFunction("
					+ callback + ")");
			out.print("</script>");
		}
		MultipartFile f = upload;
		String filePath ="";
		try {
			FileUpload image = new FileUpload("image", f, ftpConfig)
					.setInputFileName(f.getOriginalFilename())
					.useRandomNewFileName().setPath("uploader/goodimages")
					.upload();
			filePath = "/uploader/goodimages/"
					+ image.getOutputFileName();
			map.put("orderFileUrl", filePath);
		} catch (Exception e) {
			map.put("success", Boolean.FALSE);
			map.put("error", e.getMessage());
		}
		map.put("success", Boolean.TRUE);
		map.put("host", ftpConfig.getHostImage());
		// 图片上传
		out.println("<script type=\"text/javascript\">");
		out.println("window.parent.CKEDITOR.tools.callFunction(" + callback
				+ ",'" + ftpConfig.getHostImage() + filePath + "','')");
		out.println("</script>");
	}

	@RequestMapping(value = "/addFileCK", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addFiles(@RequestParam MultipartFile qqfile,
			HttpServletRequest request, HttpServletResponse resp, Model model)
			throws IOException {
		resp.addHeader("Access-Control-Allow-Methods", "POST, DELETE");
		resp.addHeader("Access-Control-Allow-Headers",
				"x-requested-with, cache-control, content-type");
		resp.setHeader("X-Frame-Options", "SAMEORIGIN");
		Map<String, Object> map = new HashMap<String, Object>();
		if (qqfile.getSize() > FILE_SIZE || qqfile.getSize() <= 0) {
			map.put("success", Boolean.FALSE);
			map.put("error", "文件大小超过限制");
			return map;
		}
		MultipartFile f = qqfile;
		try {
			FileUpload image = new FileUpload("file", f, ftpConfig)
					.setInputFileName(f.getOriginalFilename())
					.useRandomNewFileName().setPath("uploader/goodfiles")
					.upload();
			String filePath = "/uploader/goodfiles/"
					+ image.getOutputFileName();
			map.put("fileName", f.getOriginalFilename());
			map.put("fileUrl", filePath);
		} catch (Exception e) {
			map.put("success", Boolean.FALSE);
			map.put("error", e.getMessage());
			return map;
		}
		map.put("success", Boolean.TRUE);
		map.put("host", ftpConfig.getHostImage());
		return map;

	}

}
