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
CREATE DATABASE IF NOT EXISTS ApolloConfigDB;

Use ApolloConfigDB;

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
  Comment varchar(64) NOT NULL DEFAULT '', -- '注释'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_AppId_Name_DeletedAt (AppId,Name,DeletedAt),
  KEY Name_AppId (Name,AppId),
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table audit
# ------------------------------------------------------------

DROP TABLE IF EXISTS Audit;

CREATE TABLE Audit (
  Id int SERIAL PRIMARY KEY, -- '主键'
  EntityName varchar(50) NOT NULL DEFAULT 'default', -- '表名'
  EntityId int(10) unsigned DEFAULT NULL, -- '记录ID'
  OpName varchar(50) NOT NULL DEFAULT 'default', -- '操作类型'
   varchar(500) DEFAULT NULL, -- '备注'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table cluster
# ------------------------------------------------------------

DROP TABLE IF EXISTS Cluster;

CREATE TABLE Cluster (
  Id int SERIAL PRIMARY KEY, -- '自增主键'
  Name varchar(32) NOT NULL DEFAULT '', -- '集群名字'
  AppId varchar(64) NOT NULL DEFAULT '', -- 'App id'
  ParentClusterId int(10) unsigned NOT NULL DEFAULT '0', -- '父cluster'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_AppId_Name_DeletedAt (AppId,Name,DeletedAt),
  KEY IX_ParentClusterId (ParentClusterId),
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table commit
# ------------------------------------------------------------

DROP TABLE IF EXISTS Commit;

CREATE TABLE Commit (
  Id int SERIAL PRIMARY KEY, -- '主键'
  ChangeSets TEXT NOT NULL, -- '修改变更集'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  ClusterName varchar(500) NOT NULL DEFAULT 'default', -- 'ClusterName'
  NamespaceName varchar(500) NOT NULL DEFAULT 'default', -- 'namespaceName'
   varchar(500) DEFAULT NULL, -- '备注'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  KEY DataChange_LastTime (DataChange_LastTime),
  KEY AppId (AppId),
  KEY ClusterName (ClusterName(191)),
  KEY NamespaceName (NamespaceName(191))
);

# Dump of table grayreleaserule
# ------------------------------------------------------------

DROP TABLE IF EXISTS GrayReleaseRule;

CREATE TABLE GrayReleaseRule (
  Id int SERIAL PRIMARY KEY, -- '主键'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  ClusterName varchar(32) NOT NULL DEFAULT 'default', -- 'Cluster Name'
  NamespaceName varchar(32) NOT NULL DEFAULT 'default', -- 'Namespace Name'
  BranchName varchar(32) NOT NULL DEFAULT 'default', -- 'branch name'
  Rules varchar(16000) DEFAULT '[]', -- '灰度规则'
  ReleaseId int NOT NULL DEFAULT '0', -- '灰度对应的release'
  BranchStatus SMALLINT DEFAULT '1', -- '灰度分支状态: 0:删除分支,1:正在使用的规则 2：全量发布'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  KEY DataChange_LastTime (DataChange_LastTime),
  KEY IX_Namespace (AppId,ClusterName,NamespaceName)
);


# Dump of table instance
# ------------------------------------------------------------

DROP TABLE IF EXISTS Instance;

CREATE TABLE Instance (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  ClusterName varchar(32) NOT NULL DEFAULT 'default', -- 'ClusterName'
  DataCenter varchar(64) NOT NULL DEFAULT 'default', -- 'Data Center Name'
  Ip varchar(32) NOT NULL DEFAULT '', -- 'instance ip'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY IX_UNIQUE_KEY (AppId,ClusterName,Ip,DataCenter),
  KEY IX_IP (Ip),
  KEY IX_DataChange_LastTime (DataChange_LastTime)
);



# Dump of table instanceconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS InstanceConfig;

CREATE TABLE InstanceConfig (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  InstanceId int DEFAULT NULL, -- 'Instance Id'
  ConfigAppId varchar(64) NOT NULL DEFAULT 'default', -- 'Config App Id'
  ConfigClusterName varchar(32) NOT NULL DEFAULT 'default', -- 'Config Cluster Name'
  ConfigNamespaceName varchar(32) NOT NULL DEFAULT 'default', -- 'Config Namespace Name'
  ReleaseKey varchar(64) NOT NULL DEFAULT '', -- '发布的Key'
  ReleaseDeliveryTime timestamp NULL DEFAULT NULL, -- '配置获取时间'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY IX_UNIQUE_KEY (InstanceId,ConfigAppId,ConfigNamespaceName),
  KEY IX_ReleaseKey (ReleaseKey),
  KEY IX_DataChange_LastTime (DataChange_LastTime),
  KEY IX_Valid_Namespace (ConfigAppId,ConfigClusterName,ConfigNamespaceName,DataChange_LastTime)
);



# Dump of table item
# ------------------------------------------------------------

DROP TABLE IF EXISTS Item;

CREATE TABLE Item (
  Id int SERIAL PRIMARY KEY, -- '自增Id'
  NamespaceId int(10) unsigned NOT NULL DEFAULT '0', -- '集群NamespaceId'
  Key varchar(128) NOT NULL DEFAULT 'default', -- '配置项Key'
  Type SMALLINT unsigned NOT NULL DEFAULT '0', -- '配置项类型，0: String，1: Number，2: Boolean，3: JSON'
  Value TEXT NOT NULL, -- '配置项值'
   varchar(1024) DEFAULT '', -- '注释'
  LineNum int(10) unsigned DEFAULT '0', -- '行号'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  KEY IX_GroupId (NamespaceId),
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table namespace
# ------------------------------------------------------------

DROP TABLE IF EXISTS Namespace;

CREATE TABLE Namespace (
  Id int SERIAL PRIMARY KEY, -- '自增主键'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  ClusterName varchar(500) NOT NULL DEFAULT 'default', -- 'Cluster Name'
  NamespaceName varchar(500) NOT NULL DEFAULT 'default', -- 'Namespace Name'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_AppId_ClusterName_NamespaceName_DeletedAt (AppId,ClusterName(191),NamespaceName(191),DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime),
  KEY IX_NamespaceName (NamespaceName(191))
);



# Dump of table namespacelock
# ------------------------------------------------------------

DROP TABLE IF EXISTS NamespaceLock;

CREATE TABLE NamespaceLock (
  Id int SERIAL PRIMARY KEY, -- '自增id'
  NamespaceId int(10) unsigned NOT NULL DEFAULT '0', -- '集群NamespaceId'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  IsDeleted bit(1) DEFAULT b'0', -- '软删除'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  UNIQUE KEY UK_NamespaceId_DeletedAt (NamespaceId,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime)
);



# Dump of table release
# ------------------------------------------------------------

DROP TABLE IF EXISTS Release;

CREATE TABLE Release (
  Id int SERIAL PRIMARY KEY, -- 自增Id
  ReleaseKey varchar(64) NOT NULL DEFAULT '', -- '发布的Key'
  Name varchar(64) NOT NULL DEFAULT 'default', -- '发布名字'
   varchar(256) DEFAULT NULL, -- '发布说明'
  AppId varchar(64) NOT NULL DEFAULT 'default', -- 'AppID'
  ClusterName varchar(500) NOT NULL DEFAULT 'default', -- 'ClusterName'
  NamespaceName varchar(500) NOT NULL DEFAULT 'default', -- 'namespaceName'
  Configurations TEXT NOT NULL, -- '发布配置'
  IsAbandoned bit(1) NOT NULL DEFAULT b'0', -- '是否废弃'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', -- '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', -- '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  UNIQUE KEY UK_ReleaseKey_DeletedAt (ReleaseKey,DeletedAt),
  KEY AppId_ClusterName_GroupName (AppId,ClusterName(191),NamespaceName(191)),
  KEY DataChange_LastTime (DataChange_LastTime)
);


# Dump of table releasehistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS ReleaseHistory;

CREATE TABLE ReleaseHistory (
  Id int SERIAL PRIMARY KEY, -- 自增Id
  AppId varchar(64) NOT NULL DEFAULT 'default', -- AppID
  ClusterName varchar(32) NOT NULL DEFAULT 'default', -- ClusterName
  NamespaceName varchar(32) NOT NULL DEFAULT 'default', -- namespaceName
  BranchName varchar(32) NOT NULL DEFAULT 'default', -- 发布分支名
  ReleaseId int(11) unsigned NOT NULL DEFAULT '0', -- '关联的Release Id'
  PreviousReleaseId int(11) unsigned NOT NULL DEFAULT '0', -- '前一次发布的ReleaseId'
  Operation SMALLINT unsigned NOT NULL DEFAULT '0', -- '发布类型，0: 普通发布，1: 回滚，2: 灰度发布，3: 灰度规则更新，4: 灰度合并回主分支发布，5: 主分支发布灰度自动发布，6: 主分支回滚灰度自动发布，7: 放弃灰度'
  OperationContext TEXT NOT NULL, -- '发布上下文信息'
  IsDeleted bit(1) NOT NULL DEFAULT b'0', -- '1: deleted, 0: normal'
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0', -- 'Delete timestamp based on milliseconds'
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default', --  '创建人邮箱前缀'
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
  DataChange_LastModifiedBy varchar(64) DEFAULT '', --  '最后修改人邮箱前缀'
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- '最后修改时间'
  KEY IX_Namespace (AppId,ClusterName,NamespaceName,BranchName),
  KEY IX_ReleaseId (ReleaseId),
  KEY IX_DataChange_LastTime (DataChange_LastTime),
  KEY IX_PreviousReleaseId (PreviousReleaseId)
);


# Dump of table releasemessage
# ------------------------------------------------------------

DROP TABLE IF EXISTS ReleaseMessage;

CREATE TABLE ReleaseMessage (
  Id int SERIAL PRIMARY KEY,
  Message varchar(1024) NOT NULL DEFAULT '',
  DataChange_LastTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY DataChange_LastTime (DataChange_LastTime),
  KEY IX_Message (Message(191))
);



# Dump of table serverconfig
# ------------------------------------------------------------

DROP TABLE IF EXISTS ServerConfig;

CREATE TABLE ServerConfig (
  Id int SERIAL PRIMARY KEY,
  Key varchar(64) NOT NULL DEFAULT 'default',
  Cluster varchar(32) NOT NULL DEFAULT 'default',
  Value varchar(2048) NOT NULL DEFAULT 'default',
   varchar(1024) DEFAULT '',
  IsDeleted bit(1) NOT NULL DEFAULT b'0',
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0',
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default',
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  DataChange_LastModifiedBy varchar(64) DEFAULT '',
  DataChange_LastTime timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY UK_Key_Cluster_DeletedAt (Key,Cluster,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime)
);

# Dump of table accesskey
# ------------------------------------------------------------

DROP TABLE IF EXISTS AccessKey;

CREATE TABLE AccessKey (
  Id int SERIAL PRIMARY KEY,
  AppId varchar(64) NOT NULL DEFAULT 'default',
  Secret varchar(128) NOT NULL DEFAULT '',
  IsEnabled bit(1) NOT NULL DEFAULT b'0',
  IsDeleted bit(1) NOT NULL DEFAULT b'0',
  DeletedAt BIGINT(20) NOT NULL DEFAULT '0',
  DataChange_CreatedBy varchar(64) NOT NULL DEFAULT 'default',
  DataChange_CreatedTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  DataChange_LastModifiedBy varchar(64) DEFAULT '',
  DataChange_LastTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id),
  UNIQUE KEY UK_AppId_Secret_DeletedAt (AppId,Secret,DeletedAt),
  KEY DataChange_LastTime (DataChange_LastTime)
);


# Dump of table serviceregistry
# ------------------------------------------------------------

DROP TABLE IF EXISTS ServiceRegistry;

CREATE TABLE ServiceRegistry (
  Id INT SERIAL PRIMARY KEY,
  ServiceName VARCHAR(64) NOT NULL,
  Uri VARCHAR(64) NOT NULL,
  Cluster VARCHAR(64) NOT NULL,
  Metadata VARCHAR(1024) NOT NULL DEFAULT '{}',
  DataChange_CreatedTime TIMESTAMP NOT NULL,
  DataChange_LastTime TIMESTAMP NOT NULL,
  UNIQUE INDEX IX_UNIQUE_KEY (ServiceName, Uri),
  INDEX IX_DataChange_LastTime (DataChange_LastTime)
);


# Config
# ------------------------------------------------------------
INSERT INTO ServerConfig (Key, Cluster, Value, )
VALUES
    ('eureka.service.url', 'default', 'http://localhost:8080/eureka/', 'Eureka服务Url，多个service以英文逗号分隔'),
    ('namespace.lock.switch', 'default', 'false', '一次发布只能有一个人修改开关'),
    ('item.key.length.limit', 'default', '128', 'item key 最大长度限制'),
    ('item.value.length.limit', 'default', '20000', 'item value最大长度限制'),
    ('config-service.cache.enabled', 'default', 'false', 'ConfigService是否开启缓存，开启后能提高性能，但是会增大内存消耗！');

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
