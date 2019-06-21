/**
 * Copyright (c) 2016-2019 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
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
 * Sys User Controller
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
	 * Get user info
	 */
	@RequestMapping("/info")
	public R info(){
		return R.ok().put("user", getUser());
	}
	
	/**
	 * Update login user password
	 */
	@SysLog("Update password")
	@RequestMapping("/password")
	public R password(String password, String newPassword){
		Assert.isBlank(newPassword, "New password can not be empty");
		//old password
		password = ShiroUtils.sha256(password, getUser().getSalt());
		//new password
		newPassword = ShiroUtils.sha256(newPassword, getUser().getSalt());
				
		//update password
		boolean flag = sysUserService.updatePassword(getUserId(), password, newPassword);
		if(!flag){
			return R.error("old password is not correct");
		}
		
		return R.ok();
	}
	
	/**
	 * user info
	 */
	@RequestMapping("/info/{userId}")
	@RequiresPermissions("sys:user:info")
	public R info(@PathVariable("userId") Long userId){
		SysUserEntity user = sysUserService.getById(userId);
		
		//get user role list
		List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
		user.setRoleIdList(roleIdList);
		
		return R.ok().put("user", user);
	}
	
	/**
	 * save user
	 */
	@SysLog("Save User")
	@RequestMapping("/save")
	@RequiresPermissions("sys:user:save")
	public R save(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, AddGroup.class);
		
		sysUserService.saveUser(user);
		
		return R.ok();
	}
	
	/**
	 * Update user
	 */
	@SysLog("Update User")
	@RequestMapping("/update")
	@RequiresPermissions("sys:user:update")
	public R update(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, UpdateGroup.class);

		sysUserService.update(user);
		
		return R.ok();
	}
	
	/**
	 * Delete user
	 */
	@SysLog("Delete User")
	@RequestMapping("/delete")
	@RequiresPermissions("sys:user:delete")
	public R delete(@RequestBody Long[] userIds){
		if(ArrayUtils.contains(userIds, 1L)){
			return R.error("Admin Can not be Deleted");
		}
		
		if(ArrayUtils.contains(userIds, getUserId())){
			return R.error("Current User Can not be Deleted");
		}

		sysUserService.removeByIds(Arrays.asList(userIds));
		
		return R.ok();
	}
}
