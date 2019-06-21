/**
 * Copyright (c) 2016-2019 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
 */

package io.jiujiu.common.utils;

/**
 * Redis所有Keys
 *
 * @author Mark sunlightcs@gmail.com
 */
public class RedisKeys {

    public static String getSysConfigKey(String key){
        return "sys:config:" + key;
    }

    public static String getShiroSessionKey(String key){
        return "sessionid:" + key;
    }
}
