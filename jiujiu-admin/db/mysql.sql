-- create database 99sysback default character set utf8mb4 collate utf8mb4_unicode_ci;
-- menu
CREATE TABLE `sys_menu`
(
    `menu_id`   bigint NOT NULL AUTO_INCREMENT,
    `parent_id` bigint COMMENT 'parent menu ID, first level menu is 0',
    `name`      varchar(50) COMMENT 'menu name',
    `url`       varchar(200) COMMENT 'menu URL',
    `perms`     varchar(500) COMMENT 'authorization (multiple separated by commas, eg: user:list, user:create)',
    `type`      int COMMENT 'type 0: directory 1: menu 2: button ',
    `icon`      varchar(50) COMMENT 'menu icon',
    `order_num` int COMMENT 'sort',
    PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Menu Management';

-- Department
CREATE TABLE `sys_dept`
(
    `dept_id`   bigint NOT NULL AUTO_INCREMENT,
    `parent_id` bigint COMMENT 'Superior department ID, the first department is 0',
    `name`      varchar(50) COMMENT 'department name',
    `order_num` int COMMENT 'sort',
    `del_flag`  tinyint DEFAULT 0 COMMENT 'Delete -1: Deleted 0: Normal',
    PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Department Management';

-- system user
CREATE TABLE `sys_user`
(
    `user_id`     bigint      NOT NULL AUTO_INCREMENT,
    `username`    varchar(50) NOT NULL COMMENT 'username',
    `password`    varchar(100) COMMENT 'password',
    `salt`        varchar(20) COMMENT 'Salt',
    `email`       varchar(100) COMMENT 'mailbox',
    `mobile`      varchar(100) COMMENT 'Mobile number',
    `status`      tinyint COMMENT 'Status 0: Disable 1: Normal',
    `dept_id`     bigint(20) COMMENT 'Department ID',
    `create_time` datetime COMMENT 'create time',
    PRIMARY KEY (`user_id`),
    UNIQUE INDEX (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='System User';

-- Character
CREATE TABLE `sys_role`
(
    `role_id`     bigint NOT NULL AUTO_INCREMENT,
    `role_name`   varchar(100) COMMENT 'role name',
    `remark`      varchar(100) COMMENT 'Remarks',
    `dept_id`     bigint(20) COMMENT 'Department ID',
    `create_time` datetime COMMENT 'create time',
    PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Role';

-- User-to-role mapping
CREATE TABLE `sys_user_role`
(
    `id`      bigint NOT NULL AUTO_INCREMENT,
    `user_id` bigint COMMENT 'user ID',
    `role_id` bigint COMMENT 'role ID',
    PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User-to-role correspondence';

-- Role and menu correspondence
CREATE TABLE `sys_role_menu`
(
    `id`      bigint NOT NULL AUTO_INCREMENT,
    `role_id` bigint COMMENT 'role ID',
    `menu_id` bigint COMMENT 'menu ID',
    PRIMARY KEY (`id`)
)   ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Role and menu correspondence';

-- Role and department correspondence
CREATE TABLE `sys_role_dept`
(
    `id`      bigint NOT NULL AUTO_INCREMENT,
    `role_id` bigint COMMENT 'role ID',
    `dept_id` bigint COMMENT 'Department ID',
    PRIMARY KEY (`id`)
)   ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Role and department correspondence';


-- System configuration information
CREATE TABLE `sys_config`
(
    `id`          bigint NOT NULL AUTO_INCREMENT,
    `param_key`   varchar(50) COMMENT 'key',
    `param_value` varchar(2000) COMMENT 'value',
    `status`      tinyint DEFAULT 1 COMMENT 'Status 0: Hid 1: Display ',
    `remark`      varchar(500) COMMENT 'Remarks',
    PRIMARY KEY (`id`),
    UNIQUE INDEX (`param_key`)
)   ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COMMENT='System Configuration Information Table';

-- Data Dictionary
CREATE TABLE `sys_dict`
(
    `id`        bigint        NOT NULL AUTO_INCREMENT,
    `name`      varchar(100)  NOT NULL COMMENT 'dictionary name',
    `type`      varchar(100)  NOT NULL COMMENT 'dictionary type',
    `code`      varchar(100)  NOT NULL COMMENT 'dictionary code',
    `value`     varchar(1000) NOT NULL COMMENT 'dictionary value',
    `order_num` int     DEFAULT 0 COMMENT 'sort',
    `remark`    varchar(255) COMMENT 'Remarks',
    `del_flag`  tinyint DEFAULT 0 COMMENT 'delete flag -1: deleted 0: normal',
    PRIMARY KEY (`id`),
    UNIQUE KEY (`type`, `code`)
)   ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COMMENT='Data Dictionary Table';

-- System log
CREATE TABLE `sys_log`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT,
    `username`    varchar(50) COMMENT 'username',
    `operation`   varchar(50) COMMENT 'user operation',
    `method`      varchar(200) COMMENT 'Request method',
    `params`      varchar(5000) COMMENT 'Request parameters',
    `time`        bigint     NOT NULL COMMENT 'execution time (milliseconds)',
    `ip`          varchar(64) COMMENT 'IP address',
    `create_date` datetime COMMENT 'create time',
    PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COMMENT='System Log';

-- Initial data
INSERT INTO `sys_user` (`user_id`, `username`, `password`, `salt`, `email`, `mobile`, `status`, `dept_id`, `create_time`) VALUES ('1', 'admin ', 'e1153123d7d180ceeb820d577ff119876678732a68eef4e6ffc0b1f06a01f91b', 'YzcmCZNvbXocrsz9dm8e', 'root@jiujiu.io', '13612345678', '1', '1', '2016-11-11 11:11:11');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('1', '0', 'system Manage ', NULL, NULL, '0', 'fa fa-cog', '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('2', '1', 'user management', 'modules/sys/user.html', NULL, '1', 'fa fa-user', '1');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('3', '1', 'role Management ', 'modules/sys/role.html', NULL, '1', 'fa fa-user-secret', '2');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('4', '1', 'menu Management ', 'modules/sys/menu.html', NULL, '1', 'fa fa-th-list', '3');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('5', '1', 'SQL Monitor ', 'druid/sql.html', NULL, '1', 'fa fa-bug', '4');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('15', '2', 'View ', NULL, 'sys:user:list,sys:user:info', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('16', '2', 'new Increase ', NULL, 'sys:user:save,sys:role:select', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('17', '2', 'Modify ', NULL, 'sys:user:update,sys:role:select', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('18', '2', 'delete ', NULL, 'sys:user:delete', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('19', '3', 'View ', NULL, 'sys:role:list,sys:role:info', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('20', '3', 'new Increase ', NULL, 'sys:role:save,sys:menu:perms', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('21', '3', 'Modify ', NULL, 'sys:role:update,sys:menu:perms', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('22', '3', 'delete ', NULL, 'sys:role:delete', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('23', '4', 'View ', NULL, 'sys:menu:list,sys:menu:info', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('24', '4', 'new Increase ', NULL, 'sys:menu:save,sys:menu:select', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('25', '4', 'Modify ', NULL, 'sys:menu:update,sys:menu:select', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('26', '4', 'delete ', NULL, 'sys:menu:delete', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('27', '1', 'parameters Admin', 'modules/sys/config.html', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', '1', ' fa fa-sun-o', '6');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('29', '1', 'system Log ', 'modules/sys/log.html', 'sys:log:list', '1', 'fa fa-file-text-o', '7');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('31', '1', 'department Management ', 'modules/sys/dept.html', NULL, '1', 'fa fa-file-code-o', '1');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('32', '31', 'View ', NULL, 'sys:dept:list,sys:dept:info', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('33', '31', 'new Increase ', NULL, 'sys:dept:save,sys:dept:select', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('34', '31', 'Modify ', NULL, 'sys:dept:update,sys:dept:select', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('35', '31', 'delete ', NULL, 'sys:dept:delete', '2', NULL, '0');

INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (36, 1, 'dictionary management', 'modules/sys/dict.html', NULL, 1, 'fa fa-bookmark-o', 6);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (37, 36, 'View', NULL, 'sys:dict:list,sys:dict:info', 2, NULL, 6);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (38, 36, 'new', NULL , 'sys:dict:save', 2, NULL, 6);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (39, 36, 'modify', NULL, 'sys:dict:update', 2, NULL, 6);
INSERT INTO `sys_menu`(`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES (40, 36, 'delete', NULL, 'sys:dict:delete', 2, NULL, 6);


INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `name`, `order_num`, `del_flag`) VALUES ('1', '0', '99tech', '0', '0') ;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `name`, `order_num`, `del_flag`) VALUES ('2', '1', 'Changsha Branch', '1', '0') ;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `name`, `order_num`, `del_flag`) VALUES ('3', '1', 'Shanghai Branch', '2', '0') ;
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `name`, `order_num`, `del_flag`) VALUES ('4', '3', 'Technology', '0', '0');
INSERT INTO `sys_dept` (`dept_id`, `parent_id`, `name`, `order_num`, `del_flag`) VALUES ('5', '3', 'sales', '1', '0');

INSERT INTO `sys_dict`(`id`, `name`, `type`, `code`, `value`, `order_num`, `remark`, `del_flag`) VALUES (1, 'gender', 'sex', '0', 'female', 0, NULL, 0);
INSERT INTO `sys_dict`(`id`, `name`, `type`, `code`, `value`, `order_num`, `remark`, `del_flag`) VALUES (2, 'gender', 'sex', '1', 'Men', 1, NULL, 0);
INSERT INTO `sys_dict`(`id`, `name`, `type`, `code`, `value`, `order_num`, `remark`, `del_flag`) VALUES (3, 'gender', 'sex', '2', 'Unknown', 3, NULL, 0);



-- ------------------------------------------------ -------------------------------------------------- -------------------------------------------------- -----------------------
-- Cloud storage service related SQL, if you do not use this function, you do not need to execute the following SQL ------------------------------- -------------------------------------------------- ----------------------------
-- ------------------------------------------------ -------------------------------------------------- -------------------------------------------------- -----------------------

-- File Upload
CREATE TABLE `sys_oss`
(
    `id`          bigint(20) NOT NULL AUTO_INCREMENT,
    `url`         varchar(200) COMMENT 'URL address',
    `create_date` datetime COMMENT 'create time',
    PRIMARY KEY (`id`)
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COMMENT='File Upload';

INSERT INTO `sys_config` (`param_key`, `param_value`, `status`, `remark`) VALUES ('CLOUD_STORAGE_CONFIG_KEY', '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\ ",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\ ":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\" ,\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb .clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}', '0', 'Cloud Storage Configuration Information ');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('30', '1', 'file Upload ', 'modules/oss/oss.html', 'sys:oss:all', '1', 'fa fa-file-image-o', '6');
-- ------------------------------------------------ -------------------------------------------------- -------------------------------------------------- -----------------------
-- Timing task related table structure, if you do not use the job module, you do not need to execute the following SQL ------------------------------- -------------------------------------------------- ----------------------------
-- ------------------------------------------------ -------------------------------------------------- -------------------------------------------------- -----------------------

-- Initialize menu data
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('6', '1', 'Timed Task ', 'modules/job/schedule.html', NULL, '1', 'fa fa-tasks', '5');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('7', '6', 'View ', NULL, 'sys:schedule:list,sys:schedule:info', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('8', '6', 'new Increase ', NULL, 'sys:schedule:save', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('9', '6', 'Modify ', NULL, 'sys:schedule:update', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('10', '6', 'delete ', NULL, 'sys:schedule:delete', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('11', '6', 'pause ', NULL, 'sys:schedule:pause', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('12', '6', 'Restore ', NULL, 'sys:schedule:resume', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('13', '6', 'immediately Execute ', NULL, 'sys:schedule:run', '2', NULL, '0');
INSERT INTO `sys_menu` (`menu_id`, `parent_id`, `name`, `url`, `perms`, `type`, `icon`, `order_num`) VALUES ('14', '6', 'log List ', NULL, 'sys:schedule:log', '2', NULL, '0');

-- Timed tasks
CREATE TABLE `schedule_job`
(
    `job_id`          bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'task id',
    `bean_name`       varchar(200)  DEFAULT NULL COMMENT 'spring bean name',
    `params`          varchar(2000) DEFAULT NULL COMMENT 'parameters',
    `cron_expression` varchar(100)  DEFAULT NULL COMMENT 'cron expression',
    `status`          tinyint(4)    DEFAULT NULL COMMENT 'Task status 0: Normal 1: Pause',
    `remark`          varchar(255)  DEFAULT NULL COMMENT 'Remarks',
    `create_time`     datetime      DEFAULT NULL COMMENT 'create time',
    PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Timed Task';

-- Scheduled task log
CREATE TABLE `schedule_job_log`
(
    `log_id`      bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'task log id',
    `job_id`      bigint(20) NOT NULL COMMENT 'task id',
    `bean_name`   varchar(200)  DEFAULT NULL COMMENT 'spring bean name',
    `params`      varchar(2000) DEFAULT NULL COMMENT 'parameters',
    `status`      tinyint(4) NOT NULL COMMENT 'Task status 0: Success 1: Failed',
    `error`       varchar(2000) DEFAULT NULL COMMENT 'failure information',
    `times`       int(11)    NOT NULL COMMENT 'time-consuming (in milliseconds)',
    `create_time` datetime      DEFAULT NULL COMMENT 'create time',
    PRIMARY KEY (`log_id`),
    KEY `job_id` (`job_id`)
)   ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Timed Task Log';

INSERT INTO `schedule_job` (`bean_name`, `params`, `cron_expression`, `status`, `remark`, `create_time`) VALUES ('testTask', 'jiujiu', '0 0/30 * * * ?' , '0', 'parameter test', now());

--  quartz struct
CREATE TABLE QRTZ_JOB_DETAILS(
  SCHED_NAME VARCHAR(120) NOT NULL,
  JOB_NAME VARCHAR(200) NOT NULL,
  JOB_GROUP VARCHAR(200) NOT NULL,
  DESCRIPTION VARCHAR(250) NULL,
  JOB_CLASS_NAME VARCHAR(250) NOT NULL,
  IS_DURABLE VARCHAR(1) NOT NULL,
  IS_NONCONCURRENT VARCHAR(1) NOT NULL,
  IS_UPDATE_DATA VARCHAR(1) NOT NULL,
  REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
  JOB_DATA BLOB NULL,
  PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  JOB_NAME VARCHAR(200) NOT NULL,
  JOB_GROUP VARCHAR(200) NOT NULL,
  DESCRIPTION VARCHAR(250) NULL,
  NEXT_FIRE_TIME BIGINT(13) NULL,
  PREV_FIRE_TIME BIGINT(13) NULL,
  PRIORITY INTEGER NULL,
  TRIGGER_STATE VARCHAR(16) NOT NULL,
  TRIGGER_TYPE VARCHAR(8) NOT NULL,
  START_TIME BIGINT(13) NOT NULL,
  END_TIME BIGINT(13) NULL,
  CALENDAR_NAME VARCHAR(200) NULL,
  MISFIRE_INSTR SMALLINT(2) NULL,
  JOB_DATA BLOB NULL,
  PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
  REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  REPEAT_COUNT BIGINT(7) NOT NULL,
  REPEAT_INTERVAL BIGINT(12) NOT NULL,
  TIMES_TRIGGERED BIGINT(10) NOT NULL,
  PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CRON_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  CRON_EXPRESSION VARCHAR(120) NOT NULL,
  TIME_ZONE_ID VARCHAR(80),
  PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
(
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  STR_PROP_1 VARCHAR(512) NULL,
  STR_PROP_2 VARCHAR(512) NULL,
  STR_PROP_3 VARCHAR(512) NULL,
  INT_PROP_1 INT NULL,
  INT_PROP_2 INT NULL,
  LONG_PROP_1 BIGINT NULL,
  LONG_PROP_2 BIGINT NULL,
  DEC_PROP_1 NUMERIC(13,4) NULL,
  DEC_PROP_2 NUMERIC(13,4) NULL,
  BOOL_PROP_1 VARCHAR(1) NULL,
  BOOL_PROP_2 VARCHAR(1) NULL,
  PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_BLOB_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  BLOB_DATA BLOB NULL,
  PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
  INDEX (SCHED_NAME,TRIGGER_NAME, TRIGGER_GROUP),
  FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
  REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CALENDARS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  CALENDAR_NAME VARCHAR(200) NOT NULL,
  CALENDAR BLOB NOT NULL,
  PRIMARY KEY (SCHED_NAME,CALENDAR_NAME))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_FIRED_TRIGGERS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  ENTRY_ID VARCHAR(95) NOT NULL,
  TRIGGER_NAME VARCHAR(200) NOT NULL,
  TRIGGER_GROUP VARCHAR(200) NOT NULL,
  INSTANCE_NAME VARCHAR(200) NOT NULL,
  FIRED_TIME BIGINT(13) NOT NULL,
  SCHED_TIME BIGINT(13) NOT NULL,
  PRIORITY INTEGER NOT NULL,
  STATE VARCHAR(16) NOT NULL,
  JOB_NAME VARCHAR(200) NULL,
  JOB_GROUP VARCHAR(200) NULL,
  IS_NONCONCURRENT VARCHAR(1) NULL,
  REQUESTS_RECOVERY VARCHAR(1) NULL,
  PRIMARY KEY (SCHED_NAME,ENTRY_ID))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SCHEDULER_STATE (
  SCHED_NAME VARCHAR(120) NOT NULL,
  INSTANCE_NAME VARCHAR(200) NOT NULL,
  LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
  CHECKIN_INTERVAL BIGINT(13) NOT NULL,
  PRIMARY KEY (SCHED_NAME,INSTANCE_NAME))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_LOCKS (
  SCHED_NAME VARCHAR(120) NOT NULL,
  LOCK_NAME VARCHAR(40) NOT NULL,
  PRIMARY KEY (SCHED_NAME,LOCK_NAME))
  ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE INDEX IDX_QRTZ_J_REQ_RECOVERY ON QRTZ_JOB_DETAILS(SCHED_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_J_GRP ON QRTZ_JOB_DETAILS(SCHED_NAME,JOB_GROUP);

CREATE INDEX IDX_QRTZ_T_J ON QRTZ_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_JG ON QRTZ_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_T_C ON QRTZ_TRIGGERS(SCHED_NAME,CALENDAR_NAME);
CREATE INDEX IDX_QRTZ_T_G ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_T_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_N_G_STATE ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_GROUP,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NEXT_FIRE_TIME ON QRTZ_TRIGGERS(SCHED_NAME,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST ON QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_STATE,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_STATE);
CREATE INDEX IDX_QRTZ_T_NFT_ST_MISFIRE_GRP ON QRTZ_TRIGGERS(SCHED_NAME,MISFIRE_INSTR,NEXT_FIRE_TIME,TRIGGER_GROUP,TRIGGER_STATE);

CREATE INDEX IDX_QRTZ_FT_TRIG_INST_NAME ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME);
CREATE INDEX IDX_QRTZ_FT_INST_JOB_REQ_RCVRY ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,INSTANCE_NAME,REQUESTS_RECOVERY);
CREATE INDEX IDX_QRTZ_FT_J_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_JG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,JOB_GROUP);
CREATE INDEX IDX_QRTZ_FT_T_G ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP);
CREATE INDEX IDX_QRTZ_FT_TG ON QRTZ_FIRED_TRIGGERS(SCHED_NAME,TRIGGER_GROUP);
