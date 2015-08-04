package com.ca.utils;

import com.ca.entity.Staff;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * 密码加密 hash md5 2times
 */
@Service
public class PasswordHelper {

	private RandomNumberGenerator randomNumberGenerator = new SecureRandomNumberGenerator();

	@Value("${password.algorithmName}")
	private String algorithmName = "md5";
	@Value("${password.hashIterations}")
	private int hashIterations = 2;
	@Value("${accesstoken}")
	private String accesstoken;
	@Value("${agent.paymentCode}")
	private String defaultPwd;
	@Value("${agent.link}")
	private String agentlink;
	@Value("${userlogininfoMD5.s.salt}")
	private String userlogininfoMD5SSalt;
	@Value("${userlogininfoMD5.e.salt}")
	private String userlogininfoMD5ESalt;

	
	public String getAgentlink() {
		return agentlink;
	}

	public void setAgentlink(String agentlink) {
		this.agentlink = agentlink;
	}

	public void setRandomNumberGenerator(
			RandomNumberGenerator randomNumberGenerator) {
		this.randomNumberGenerator = randomNumberGenerator;
	}

	public void setAlgorithmName(String algorithmName) {
		this.algorithmName = algorithmName;
	}

	public void setHashIterations(int hashIterations) {
		this.hashIterations = hashIterations;
	}
	
	public String getDefaultPwd() {
		return defaultPwd;
	}

	public void setDefaultPwd(String defaultPwd) {
		this.defaultPwd = defaultPwd;
	}

	public String getUserlogininfoMD5SSalt() {
		return userlogininfoMD5SSalt;
	}

	public void setUserlogininfoMD5SSalt(String userlogininfoMD5SSalt) {
		this.userlogininfoMD5SSalt = userlogininfoMD5SSalt;
	}

	public String getUserlogininfoMD5ESalt() {
		return userlogininfoMD5ESalt;
	}

	public void setUserlogininfoMD5ESalt(String userlogininfoMD5ESalt) {
		this.userlogininfoMD5ESalt = userlogininfoMD5ESalt;
	}

	public RandomNumberGenerator getRandomNumberGenerator() {
		return randomNumberGenerator;
	}

	public String getAlgorithmName() {
		return algorithmName;
	}

	public int getHashIterations() {
		return hashIterations;
	}

	public void encryptPassword(Staff user) {

		user.setSalt(randomNumberGenerator.nextBytes().toHex());

//		String newPassword = new SimpleHash(algorithmName, user.getPassword(),
//				ByteSource.Util.bytes(user.getSalt()), hashIterations).toHex();

		String pwd = userlogininfoMD5SSalt+user.getPasswd()+userlogininfoMD5ESalt;
		String newPassword = DigestUtils.shaHex(pwd);
				
		user.setPasswd(newPassword);
	}

    public String encryptPassword(String password){
        String ecncyptPwd = null;
        password =  userlogininfoMD5SSalt+password+userlogininfoMD5ESalt;
        ecncyptPwd = DigestUtils.shaHex(password.getBytes());
        return ecncyptPwd;
    }

	public void encryptPassword1(Staff user) {

		user.setSalt(randomNumberGenerator.nextBytes().toHex());

		String newPassword = new SimpleHash(algorithmName, user.getPasswd(),
				ByteSource.Util.bytes(user.getSalt()), hashIterations).toHex();

		user.setPasswd(newPassword);
	}

	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}

	/*public void encryptPassword(AgentAccount account) {

		account.setSalt(randomNumberGenerator.nextBytes().toHex());

		String newPassword = new SimpleHash(algorithmName, defaultPwd,
				ByteSource.Util.bytes(account.getSalt()), hashIterations)
				.toHex();

		account.setPaymentCode(newPassword);
	}*/

    public String encryptPayPassword(String password,String salt){
        String ecncyptPwd = new SimpleHash(algorithmName, password,
                ByteSource.Util.bytes(salt), hashIterations)
                .toHex();
        return ecncyptPwd;
    }
	
	/*public void encryptPassword1(AgentAccount account) {

		account.setSalt(randomNumberGenerator.nextBytes().toHex());

		String pwd = userlogininfoMD5SSalt+defaultPwd+userlogininfoMD5ESalt;
		String newPassword = DigestUtils.md5Hex(pwd.getBytes());

		account.setPaymentCode(newPassword);
	}*/

	public static void main(String[] args) {
		String s = new SimpleHash("md5", "123456",
				"abc", 2)
				.toHex();
		System.out.println(s);

        String s1 = new SimpleHash("md5", "123456",
                "abcd", 2)
                .toHex();
        System.out.println(s1);

        String ss = new SimpleHash("md5", "dq123456!",
                "abcd", 2)
                .toHex();
        System.out.println(ss);

		String s11 = DigestUtils.shaHex("`!@#123456,.`/");
		System.out.println(s11);
		PasswordHelper p=new PasswordHelper();
		Staff staff=new Staff();
		staff.setPasswd("1");
		p.encryptPassword(staff);
		System.out.println(staff.getPasswd());


	}


}
