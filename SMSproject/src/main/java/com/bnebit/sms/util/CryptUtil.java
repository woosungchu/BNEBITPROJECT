package com.bnebit.sms.util;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;


public class CryptUtil {
	
	private static CryptUtil instance;
	
	private CryptUtil(){};
	
	public static CryptUtil getInstance(Object caller){
		if(caller instanceof Cryptable){
			if(instance == null){
				instance = new CryptUtil();
			}
			return instance;
		}else{
			return null;
		}
	}
	
	public String hashing(String str) {
		String SHA = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			StringBuffer sb = new StringBuffer();
			
			for (int k = 0; k < 3; k++) {
				//clear
				sb.delete(0, sb.length());
				str += "BNE Partners & BIT Computer";
				
				//SHA
				sh.update(str.getBytes());
				byte byteData[] = sh.digest();
				for (int i = 0; i < byteData.length; i++) {
					sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				}
				
				str = sb.toString();
			}//end shaking
			SHA = str;

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			SHA = null;
		}
		return SHA;
	}
	
	public Map<String,String> encryptRSA(HttpSession session) {
		Map<String,String> map = new HashMap<String,String>();
		try {
			
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.genKeyPair();
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();
	 
			session.setAttribute("__rsaPrivateKey__", privateKey);   //세션에 RSA 개인키를 세션에 저장한다.
			RSAPublicKeySpec publicSpec;
				publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

			map.put("RSAModulus", publicKeyModulus);  //로그인 폼에 Input Hidden에 값을 셋팅하기위해서
			map.put("RSAExponent", publicKeyExponent);   //로그인 폼에 Input Hidden에 값을 셋팅하기위해서
			
		} catch (InvalidKeySpecException | NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
	
	 public static byte[] hexToByteArray(String hex) {
	        if (hex == null || hex.length() % 2 != 0) {
	            return new byte[]{};
	        }

	        byte[] bytes = new byte[hex.length() / 2];
	        for (int i = 0; i < hex.length(); i += 2) {
	            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
	            bytes[(int) Math.floor(i / 2)] = value;
	        }
	        return bytes;
	    }

}
