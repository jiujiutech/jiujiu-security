/**
 * Copyright (c) 2016-2019 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
 */

package io.jiujiu.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import io.jiujiu.common.utils.PageUtils;
import io.jiujiu.modules.sys.entity.SysDictEntity;

import java.util.Map;

/**
 * 数据字典
 *
 * @author Mark sunlightcs@gmail.com
 */
public interface SysDictService extends IService<SysDictEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

