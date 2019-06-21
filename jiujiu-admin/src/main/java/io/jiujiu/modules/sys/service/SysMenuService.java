/**
 * Copyright (c) 2016-2019 久久集团 All rights reserved.
 *
 * https://i99tech.com
 *
 * 版权所有，侵权必究！
 */

package io.jiujiu.modules.sys.service;


import com.baomidou.mybatisplus.extension.service.IService;
import io.jiujiu.modules.sys.entity.SysMenuEntity;

import java.util.List;


/**
 * 菜单管理
 *
 * @author Mark sunlightcs@gmail.com
 */
public interface SysMenuService extends IService<SysMenuEntity> {

	/**
	 * 根据父菜单，查询子菜单
	 * @param parentId 父菜单ID
	 * @param menuIdList  用户菜单ID
	 */
	List<SysMenuEntity> queryListParentId(Long parentId, List<Long> menuIdList);

	/**
	 * 根据父菜单，查询子菜单
	 * @param parentId 父菜单ID
	 */
	List<SysMenuEntity> queryListParentId(Long parentId);
	
	/**
	 * 获取不包含按钮的菜单列表
	 */
	List<SysMenuEntity> queryNotButtonList();
	
	/**
	 * 获取用户菜单列表
	 */
	List<SysMenuEntity> getUserMenuList(Long userId);

	/**
	 * Delete
	 */
	void delete(Long menuId);
}
