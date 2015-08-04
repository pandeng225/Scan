package com.ca.utils;

/**
 * Created by wangxiang2 on 2015/4/23.
 */

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;

public class ImageZoomUtils {
	private File file = null; // 文件对象
	private String inputDir; // 输入图路径此处若是文件上传的话把文件的输入路径也设置成服务器端的路径（就是在文件上传完成后做处理）这样会便于你去做图片的处理，因为本段代码并不支持url的解析
	private String outputDir; // 输出图路径也可以在这个里面加上一段url的解析处理，这样你的输出路径就会即支持url，也支持本地的缩放
	private String inputFileName; // 输入图文件名
	private String outputFileName; // 输出图文件名
	private int outputWidth = 100; // 默认输出图片宽
	private int outputHeight = 100; // 默认输出图片高
	private boolean proportion = true; // 是否等比缩放标记(默认为等比缩放)
	private InputStream in;
	
	public ImageZoomUtils() { // 初始化变量
		inputDir = "";
		outputDir = "";
		inputFileName = "";
		outputFileName = "";
		outputWidth = 450;
		outputHeight = 630;
		in = null;
	}
	
	public void setInputDir(String inputDir) {
		this.inputDir = inputDir;
	}
	
	public void setOutputDir(String outputDir) {
		this.outputDir = outputDir;
	}
	
	public void setInputFileName(String inputFileName) {
		this.inputFileName = inputFileName;
	}
	
	public void setOutputFileName(String outputFileName) {
		this.outputFileName = outputFileName;
	}
	
	public void setOutputWidth(int outputWidth) {
		this.outputWidth = outputWidth;
	}
	
	public void setOutputHeight(int outputHeight) {
		this.outputHeight = outputHeight;
	}
	
	public void setWidthAndHeight(int width, int height) {
		this.outputWidth = width;
		this.outputHeight = height;
	}
	
	public InputStream getIn() {
		return in;
	}
	
	public void setIn(InputStream in) {
		this.in = in;
	}
	
	public long getPicSize(String path) {
		file = new File(path);
		return file.length();
	}
	
	// 图片处理
	public BufferedImage zoomPicture(Image image) {
		
		Image img = image;
		// 判断图片格式是否正确
		if (img.getWidth(null) == -1) {
			return null;
		} else {
			int newWidth;
			int newHeight;
			// 判断是否是等比缩放
			if (this.proportion == true) {
				// 为等比缩放计算输出的图片宽度及高度
				double rate1 = ((double) img.getWidth(null))
						/ (double) outputWidth + 0.1;
				double rate2 = ((double) img.getHeight(null))
						/ (double) outputHeight + 0.1;
				// 根据缩放比率大的进行缩放控制
				double rate = rate1 > rate2 ? rate1 : rate2;
				newWidth = (int) (((double) img.getWidth(null)) / rate);
				newHeight = (int) (((double) img.getHeight(null)) / rate);
			} else {
				newWidth = outputWidth; // 输出的图片宽度
				newHeight = outputHeight; // 输出的图片高度
			}
			BufferedImage tag = new BufferedImage((int) newWidth,
					(int) newHeight, BufferedImage.TYPE_INT_RGB);
			
			tag.getGraphics().drawImage(
					img.getScaledInstance(newWidth, newHeight,
							Image.SCALE_SMOOTH), 0, 0, null);
			return tag;
		}
	}
	
}
