--
-- Copyright 2022 Apollo Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# Create Database
# ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS ApolloPortalDB;

Use ApolloPortalDB;

# Dump of table app
# ------------------------------------------------------------

DROP TABLE IF EXISTS App;

CREATE TABLE App (
  Id int SERIAL PRIMARY KEY, -- '主键'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  Name varchar(500) NOT NULL DEFAULT 'default', -- '应用名'
  OrgId varchar(32) NOT NULL DEFAULT 'default', -- '部门Id'
  OrgName varchar(64) NOT NULL DEFAULT 'default', -- '部门名字'
  OwnerName varchar(500) NOT NULL DEFAULT 'default', -- 'ownerName'
  OwnerEmail varchar(500) NOT NULL DEFAULT 'default', -- 'ownerEmail'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_AppId_DeletedAt (AppId,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime),
  KEY IX_Name (Name(191))
);



# Dump of table appnamespace
# ------------------------------------------------------------

DROP TABLE IF EXISTS AppNamespace;

CREATE TABLE AppNamespace (
  Id int SERIAL PRIMARY KEY, -- '自增主键'
  Name varchar(32) NOT NULL DEFAULT '', -- 'namespace名字，注意，需要全局唯一'
  AppId varchar(64) NOT NULL DEFAULT '', -- 'app id'
  Format varchar(32) NOT NULL DEFAULT 'properties', -- 'namespace的format类型'
  IsPublic bit(1) NOT NULL DEFAULT b'0', -- 'namespace是否为公共'
   varchar(64) NOT NULL DEFAULT '', -- '注释'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_AppId_Name_DeletedAt (AppId,Name,DeletedAt),
  KEY Name_AppId (Name,AppId),
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table consumer
# ------------------------------------------------------------

DROP TABLE IF EXISTS Consumer;

CREATE TABLE Consumer (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  Name varchar(500) NOT NULL DEFAULT 'default', -- '应用名'
  OrgId varchar(32) NOT NULL DEFAULT 'default', -- '部门Id'
  OrgName varchar(64) NOT NULL DEFAULT 'default', -- '部门名字'
  OwnerName varchar(500) NOT NULL DEFAULT 'default', -- 'ownerName'
  OwnerEmail varchar(500) NOT NULL DEFAULT 'default', -- 'ownerEmail'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_AppId_DeletedAt (AppId,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table consumeraudit
# ------------------------------------------------------------

DROP TABLE IF EXISTS ConsumerAudit;

CREATE TABLE ConsumerAudit (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  ConsumerId int unsigned DEFAULT NULL, -- 'Consumer Id'
  Uri varchar(1024) NOT NULL DEFAULT '', -- '访问的Uri'
  Method varchar(16) NOT NULL DEFAULT '', -- '访问的Method'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  KEY IX_DataChange_LastTime (DataChange_LastTime),
  KEY IX_ConsumerId (ConsumerId)
);



# Dump of table consumerrole
# ------------------------------------------------------------

DROP TABLE IF EXISTS ConsumerRole;

CREATE TABLE ConsumerRole (
  Id int SERIAL PRIMARY KEY, --'自增Id'
  ConsumerId int unsigned DEFAULT NULL, -- 'Consumer Id'
  RoleId int unsigned DEFAULT NULL, -- 'Role Id'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_ConsumerId_RoleId_DeletedAt (ConsumerId,RoleId,DeletedAt),
  KEY IX_DataChange_LastTime (DataChange_LastTime),
  KEY IX_RoleId (RoleId)
);



# Dump of table consumertoken
# ------------------------------------------------------------

DROP TABLE IF EXISTS ConsumerToken;

CREATE TABLE ConsumerToken (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  ConsumerId int unsigned DEFAULT NULL, -- 'ConsumerId'
  Token varchar(128) NOT NULL DEFAULT '', -- 'token'
  Expires TIMESTAMP NOT NULL DEFAULT '2099-01-01 00:00:00', -- 'token失效时间'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_Token_DeletedAt (Token,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime)
);

# Dump of table favorite
# ------------------------------------------------------------

DROP TABLE IF EXISTS Favorite;

CREATE TABLE Favorite (
  Id int SERIAL PRIMARY KEY, -- '主键'
  UserId varchar(32) NOT NULL DEFAULT 'default', -- '收藏的用户'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  Position int(32) NOT NULL DEFAULT '10000', -- '收藏顺序'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_UserId_AppId_DeletedAt (UserId,AppId,DeletedAt),
  KEY AppId (AppId),
  KEY DataChange_LastTime (DataChange_LastTime)
); -- '应用收藏表'

# Dump of table permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS Permission;

CREATE TABLE Permission (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  PermissionType varchar(32) NOT NULL DEFAULT '', -- '权限类型'
  TargetId varchar(256) NOT NULL DEFAULT '', -- '权限对象类型'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_TargetId_PermissionType_DeletedAt (TargetId,PermissionType,DeletedAt),
  KEY IX_DataChange_LastTime (DataChange_LastTime)
); -- permission表



# Dump of table role
# ------------------------------------------------------------

DROP TABLE IF EXISTS Role;

CREATE TABLE Role (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  RoleName varchar(256) NOT NULL DEFAULT '', -- 'Role name'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_RoleName_DeletedAt (RoleName,DeletedAt),
  KEY IX_DataChange_LastTime (DataChange_LastTime)
); -- '角色表'



# Dump of table rolepermission
# ------------------------------------------------------------

DROP TABLE IF EXISTS RolePermission;

CREATE TABLE RolePermission (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  RoleId int(10) unsigned DEFAULT NULL, -- 'Role Id'
  PermissionId int(10) unsigned DEFAULT NULL, -- 'Permission Id'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_RoleId_PermissionId_DeletedAt (RoleId,PermissionId,DeletedAt),
  KEY IX_DataChange_LastTime (DataChange_LastTime),
  KEY IX_PermissionId (PermissionId)
); -- '角色和权限的绑定表'



# Dump of table serverconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS ServerConfig;

CREATE TABLE ServerConfig (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  Key varchar(64) NOT NULL DEFAULT 'default', -- '配置项Key'
  Value varchar(2048) NOT NULL DEFAULT 'default', -- '配置项值'
   varchar(1024) DEFAULT '', -- '注释'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_Key_DeletedAt (Key,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime)
); --'配置服务自身配置'



# Dump of table userrole
# ------------------------------------------------------------

DROP TABLE IF EXISTS UserRole;

CREATE TABLE UserRole (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  UserId varchar(128) DEFAULT '', -- '用户身份标识'
  RoleId int unsigned DEFAULT NULL, -- 'Role Id'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_UserId_RoleId_DeletedAt (UserId,RoleId,DeletedAt),
  KEY IX_DataChange_LastTime (DataChange_LastTime),
  KEY IX_RoleId (RoleId)
); -- '用户和role的绑定表'

# Dump of table Users
# ------------------------------------------------------------

DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  Username varchar(64) NOT NULL DEFAULT 'default', -- '用户登录账户'
  Password varchar(512) NOT NULL DEFAULT 'default', -- '密码'
  UserDisplayName varchar(512) NOT NULL DEFAULT 'default', -- '用户名称'
  Email varchar(64) NOT NULL DEFAULT 'default', -- '邮箱地址'
  Enabled SMALLINT DEFAULT NULL, -- '是否有效'
  UNIQUE KEY UK_Username (Username)
); -- '用户表'


# Dump of table Authorities
# ------------------------------------------------------------

DROP TABLE IF EXISTS Authorities;

CREATE TABLE Authorities (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  Username varchar(64) NOT NULL,
  Authority varchar(50) NOT NULL
);


# Config
# ------------------------------------------------------------
INSERT INTO ServerConfig (Key, Value, )
VALUES
    ('apollo.portal.envs', 'dev', '可支持的环境列表'),
    ('organizations', '[{\"orgId\":\"TEST1\",\"orgName\":\"样例部门1\"},{\"orgId\":\"TEST2\",\"orgName\":\"样例部门2\"}]', '部门列表'),
    ('superAdmin', 'apollo', 'Portal超级管理员'),
    ('api.readTimeout', '10000', 'http接口read timeout'),
    ('consumer.token.salt', 'someSalt', 'consumer token salt'),
    ('admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace'),
    ('configView.memberOnly.envs', 'pro', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔'),
    ('apollo.portal.meta.servers', '{}', '各环境Meta Service列表');


INSERT INTO Users (Username, Password, UserDisplayName, Email, Enabled)
VALUES
	('apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo', 'apollo@acme.com', 1);

INSERT INTO Authorities (Username, Authority) VALUES ('apollo', 'ROLE_user');

-- spring session (https://github.com/spring-projects/spring-session/blob/faee8f1bdb8822a5653a81eba838dddf224d92d6/spring-session-jdbc/src/main/resources/org/springframework/session/jdbc/schema-mysql.sql)
CREATE TABLE SPRING_SESSION (
	PRIMARY_ID CHAR(36) NOT NULL,
	SESSION_ID CHAR(36) NOT NULL,
	CREATION_TIME BIGINT NOT NULL,
	LAST_ACCESS_TIME BIGINT NOT NULL,
	MAX_INACTIVE_INTERVAL INT NOT NULL,
	EXPIRY_TIME BIGINT NOT NULL,
	PRINCIPAL_NAME VARCHAR(100),
	CONSTRAINT SPRING_SESSION_PK PRIMARY KEY (PRIMARY_ID)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

CREATE UNIQUE INDEX SPRING_SESSION_IX1 ON SPRING_SESSION (SESSION_ID);
CREATE INDEX SPRING_SESSION_IX2 ON SPRING_SESSION (EXPIRY_TIME);
CREATE INDEX SPRING_SESSION_IX3 ON SPRING_SESSION (PRINCIPAL_NAME);

CREATE TABLE SPRING_SESSION_ATTRIBUTES (
	SESSION_PRIMARY_ID CHAR(36) NOT NULL,
	ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
	ATTRIBUTE_BYTES BYTEA NOT NULL,
	CONSTRAINT SPRING_SESSION_ATTRIBUTES_PK PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
	CONSTRAINT SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_PRIMARY_ID) REFERENCES SPRING_SESSION(PRIMARY_ID) ON DELETE CASCADE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
