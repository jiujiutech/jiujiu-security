/**
 * Copyright (c) 2018 99tech All rights reserved.
 *
 * https://i99tech.com
 *
 *
 */

package io.jiujiu.commons.dynamic.datasource.config;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * 多数据源
 *
 * @author Mark sunlightcs@gmail.com
 * @since 1.0.0
 */
public class DynamicDataSource extends AbstractRoutingDataSource {

    @Override
    protected Object determineCurrentLookupKey() {
        return DynamicContextHolder.peek();
    }

}
