package com.ai.am;

import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;

/**
 * Created by wangxiang2 on 2015/3/7.
 */
public class CredentialsMatcherTest {

    @Test
    public void testPassword(){
        String pwd = "`!@#"+new String("1")+",.`/";
        String enpwd = DigestUtils.shaHex(pwd.getBytes());
        System.out.println(enpwd);
        boolean f = "67575ba31b7a93aef0debb9e6a3599aaf5d0ac13".equals(enpwd);
        System.out.println(f);
    }

}
