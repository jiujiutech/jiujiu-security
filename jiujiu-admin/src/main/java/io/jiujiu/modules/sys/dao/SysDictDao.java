/**
 * Copyright (c) 2016-2019 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
 */

package io.jiujiu.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import io.jiujiu.modules.sys.entity.SysDictEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 数据字典
 *
 * @author Mark sunlightcs@gmail.com
 */
@Mapper
public interface SysDictDao extends BaseMapper<SysDictEntity> {
	
}
