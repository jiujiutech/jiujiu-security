/**
 * Copyright (c) 2016-2019 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
 */

package io.jiujiu.modules.job.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * 测试定时任务(演示Demo，可Delete)
 *
 * testTask为spring bean的名称
 *
 * @author Mark sunlightcs@gmail.com
 */
@Component("testTask")
public class TestTask implements ITask {
	private Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void run(String params){
		logger.debug("TestTask定时任务正在执行，参数为：{}", params);
	}
}
