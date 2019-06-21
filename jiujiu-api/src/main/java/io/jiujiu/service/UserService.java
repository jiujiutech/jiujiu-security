/**
 * Copyright (c) 2016-2019 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
 */

package io.jiujiu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.jiujiu.entity.UserEntity;
import io.jiujiu.form.LoginForm;

import java.util.Map;

/**
 * 用户
 *
 * @author Mark sunlightcs@gmail.com
 */
public interface UserService extends IService<UserEntity> {

	UserEntity queryByMobile(String mobile);

	/**
	 * 用户登录
	 * @param form    登录表单
	 * @return        Return登录信息
	 */
	Map<String, Object> login(LoginForm form);
}
