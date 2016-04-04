package com.bnebit.sms.util;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class UploadUtil {

	private static final String UPLOAD_PATH = "//192.168.1.20/Upload/";

	public static void uploadHelper(MultipartFile file, String fileName){
		System.out.println("처음 fileName " + fileName);
		if(file!=null && !file.isEmpty())
		{
			File saveFile = new File(UPLOAD_PATH+fileName);
			try {
				file.transferTo(saveFile);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void deletePreFile(String fileName){
		File deleteFile = new File(UPLOAD_PATH+fileName);
		deleteFile.delete();
	}

	//@Deprecated
}
