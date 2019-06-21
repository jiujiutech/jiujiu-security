/**
 * Copyright (c) 2016-2019 久久集团 All rights reserved.
 *
 * https://i99tech.com
 *
 * 版权所有，侵权必究！
 */

package io.jiujiu.modules.sys.controller;


import io.jiujiu.common.annotation.SysLog;
import io.jiujiu.common.utils.PageUtils;
import io.jiujiu.common.utils.R;
import io.jiujiu.common.validator.Assert;
import io.jiujiu.common.validator.ValidatorUtils;
import io.jiujiu.common.validator.group.AddGroup;
import io.jiujiu.common.validator.group.UpdateGroup;
import io.jiujiu.modules.sys.entity.SysUserEntity;
import io.jiujiu.modules.sys.service.SysUserRoleService;
import io.jiujiu.modules.sys.service.SysUserService;
import io.jiujiu.modules.sys.shiro.ShiroUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 系统用户
 *
 * @author Mark sunlightcs@gmail.com
 */
@RestController
@RequestMapping("/sys/user")
public class SysUserController extends AbstractController {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserRoleService sysUserRoleService;
	
	/**
	 * 所有用户列表
	 */
	@RequestMapping("/list")
	@RequiresPermissions("sys:user:list")
	public R list(@RequestParam Map<String, Object> params){
		PageUtils page = sysUserService.queryPage(params);

		return R.ok().put("page", page);
	}
	
	/**
	 * 获取登录的用户信息
	 */
	@RequestMapping("/info")
	public R info(){
		return R.ok().put("user", getUser());
	}
	
	/**
	 * Update登录用户密码
	 */
	@SysLog("Update密码")
	@RequestMapping("/password")
	public R password(String password, String newPassword){
		Assert.isBlank(newPassword, "新密码不为能空");

		//原密码
		password = ShiroUtils.sha256(password, getUser().getSalt());
		//新密码
		newPassword = ShiroUtils.sha256(newPassword, getUser().getSalt());
				
		//更新密码
		boolean flag = sysUserService.updatePassword(getUserId(), password, newPassword);
		if(!flag){
			return R.error("原密码不正确");
		}
		
		return R.ok();
	}
	
	/**
	 * 用户信息
	 */
	@RequestMapping("/info/{userId}")
	@RequiresPermissions("sys:user:info")
	public R info(@PathVariable("userId") Long userId){
		SysUserEntity user = sysUserService.getById(userId);
		
		//获取用户所属的角色列表
		List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
		user.setRoleIdList(roleIdList);
		
		return R.ok().put("user", user);
	}
	
	/**
	 * 保存用户
	 */
	@SysLog("保存用户")
	@RequestMapping("/save")
	@RequiresPermissions("sys:user:save")
	public R save(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, AddGroup.class);
		
		sysUserService.saveUser(user);
		
		return R.ok();
	}
	
	/**
	 * Update用户
	 */
	@SysLog("Update用户")
	@RequestMapping("/update")
	@RequiresPermissions("sys:user:update")
	public R update(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, UpdateGroup.class);

		sysUserService.update(user);
		
		return R.ok();
	}
	
	/**
	 * Delete用户
	 */
	@SysLog("Delete用户")
	@RequestMapping("/delete")
	@RequiresPermissions("sys:user:delete")
	public R delete(@RequestBody Long[] userIds){
		if(ArrayUtils.contains(userIds, 1L)){
			return R.error("系统管理员不能Delete");
		}
		
		if(ArrayUtils.contains(userIds, getUserId())){
			return R.error("当前用户不能Delete");
		}

		sysUserService.removeByIds(Arrays.asList(userIds));
		
		return R.ok();
	}
}
