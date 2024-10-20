/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.3-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: directus-project
-- ------------------------------------------------------
-- Server version	11.4.3-MariaDB-ubu2310

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `directus_access`
--

DROP TABLE IF EXISTS `directus_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_access` (
  `id` char(36) NOT NULL,
  `role` char(36) DEFAULT NULL,
  `user` char(36) DEFAULT NULL,
  `policy` char(36) NOT NULL,
  `sort` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_access_role_foreign` (`role`),
  KEY `directus_access_user_foreign` (`user`),
  KEY `directus_access_policy_foreign` (`policy`),
  CONSTRAINT `directus_access_policy_foreign` FOREIGN KEY (`policy`) REFERENCES `directus_policies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_access_role_foreign` FOREIGN KEY (`role`) REFERENCES `directus_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_access_user_foreign` FOREIGN KEY (`user`) REFERENCES `directus_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_activity`
--

DROP TABLE IF EXISTS `directus_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_activity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `action` varchar(45) NOT NULL,
  `user` char(36) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip` varchar(50) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `collection` varchar(64) NOT NULL,
  `item` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_activity_collection_foreign` (`collection`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_collections`
--

DROP TABLE IF EXISTS `directus_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_collections` (
  `collection` varchar(64) NOT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `display_template` varchar(255) DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `singleton` tinyint(1) NOT NULL DEFAULT 0,
  `translations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`translations`)),
  `archive_field` varchar(64) DEFAULT NULL,
  `archive_app_filter` tinyint(1) NOT NULL DEFAULT 1,
  `archive_value` varchar(255) DEFAULT NULL,
  `unarchive_value` varchar(255) DEFAULT NULL,
  `sort_field` varchar(64) DEFAULT NULL,
  `accountability` varchar(255) DEFAULT 'all',
  `color` varchar(255) DEFAULT NULL,
  `item_duplication_fields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`item_duplication_fields`)),
  `sort` int(11) DEFAULT NULL,
  `group` varchar(64) DEFAULT NULL,
  `collapse` varchar(255) NOT NULL DEFAULT 'open',
  `preview_url` varchar(255) DEFAULT NULL,
  `versioning` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`collection`),
  KEY `directus_collections_group_foreign` (`group`),
  CONSTRAINT `directus_collections_group_foreign` FOREIGN KEY (`group`) REFERENCES `directus_collections` (`collection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_dashboards`
--

DROP TABLE IF EXISTS `directus_dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_dashboards` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(64) NOT NULL DEFAULT 'dashboard',
  `note` text DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `user_created` char(36) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_dashboards_user_created_foreign` (`user_created`),
  CONSTRAINT `directus_dashboards_user_created_foreign` FOREIGN KEY (`user_created`) REFERENCES `directus_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_extensions`
--

DROP TABLE IF EXISTS `directus_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_extensions` (
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `id` char(36) NOT NULL,
  `folder` varchar(255) NOT NULL,
  `source` varchar(255) NOT NULL,
  `bundle` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_fields`
--

DROP TABLE IF EXISTS `directus_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `collection` varchar(64) NOT NULL,
  `field` varchar(64) NOT NULL,
  `special` varchar(64) DEFAULT NULL,
  `interface` varchar(64) DEFAULT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `display` varchar(64) DEFAULT NULL,
  `display_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`display_options`)),
  `readonly` tinyint(1) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `sort` int(10) unsigned DEFAULT NULL,
  `width` varchar(30) DEFAULT 'full',
  `translations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`translations`)),
  `note` text DEFAULT NULL,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `required` tinyint(1) DEFAULT 0,
  `group` varchar(64) DEFAULT NULL,
  `validation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`validation`)),
  `validation_message` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_fields_collection_foreign` (`collection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_files`
--

DROP TABLE IF EXISTS `directus_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_files` (
  `id` char(36) NOT NULL,
  `storage` varchar(255) NOT NULL,
  `filename_disk` varchar(255) DEFAULT NULL,
  `filename_download` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `folder` char(36) DEFAULT NULL,
  `uploaded_by` char(36) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_by` char(36) DEFAULT NULL,
  `modified_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `charset` varchar(50) DEFAULT NULL,
  `filesize` bigint(20) DEFAULT NULL,
  `width` int(10) unsigned DEFAULT NULL,
  `height` int(10) unsigned DEFAULT NULL,
  `duration` int(10) unsigned DEFAULT NULL,
  `embed` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `tags` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `focal_point_x` int(11) DEFAULT NULL,
  `focal_point_y` int(11) DEFAULT NULL,
  `tus_id` varchar(64) DEFAULT NULL,
  `tus_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tus_data`)),
  `uploaded_on` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_files_uploaded_by_foreign` (`uploaded_by`),
  KEY `directus_files_modified_by_foreign` (`modified_by`),
  KEY `directus_files_folder_foreign` (`folder`),
  CONSTRAINT `directus_files_folder_foreign` FOREIGN KEY (`folder`) REFERENCES `directus_folders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `directus_files_modified_by_foreign` FOREIGN KEY (`modified_by`) REFERENCES `directus_users` (`id`),
  CONSTRAINT `directus_files_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `directus_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_flows`
--

DROP TABLE IF EXISTS `directus_flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_flows` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `trigger` varchar(255) DEFAULT NULL,
  `accountability` varchar(255) DEFAULT 'all',
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `operation` char(36) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `user_created` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `directus_flows_operation_unique` (`operation`),
  KEY `directus_flows_user_created_foreign` (`user_created`),
  CONSTRAINT `directus_flows_user_created_foreign` FOREIGN KEY (`user_created`) REFERENCES `directus_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_folders`
--

DROP TABLE IF EXISTS `directus_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_folders` (
  `id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_folders_parent_foreign` (`parent`),
  CONSTRAINT `directus_folders_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `directus_folders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_migrations`
--

DROP TABLE IF EXISTS `directus_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_migrations` (
  `version` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_notifications`
--

DROP TABLE IF EXISTS `directus_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  `status` varchar(255) DEFAULT 'inbox',
  `recipient` char(36) NOT NULL,
  `sender` char(36) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `collection` varchar(64) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_notifications_recipient_foreign` (`recipient`),
  KEY `directus_notifications_sender_foreign` (`sender`),
  CONSTRAINT `directus_notifications_recipient_foreign` FOREIGN KEY (`recipient`) REFERENCES `directus_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_notifications_sender_foreign` FOREIGN KEY (`sender`) REFERENCES `directus_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_operations`
--

DROP TABLE IF EXISTS `directus_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_operations` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `key` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `position_x` int(11) NOT NULL,
  `position_y` int(11) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `resolve` char(36) DEFAULT NULL,
  `reject` char(36) DEFAULT NULL,
  `flow` char(36) NOT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `user_created` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `directus_operations_resolve_unique` (`resolve`),
  UNIQUE KEY `directus_operations_reject_unique` (`reject`),
  KEY `directus_operations_flow_foreign` (`flow`),
  KEY `directus_operations_user_created_foreign` (`user_created`),
  CONSTRAINT `directus_operations_flow_foreign` FOREIGN KEY (`flow`) REFERENCES `directus_flows` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_operations_reject_foreign` FOREIGN KEY (`reject`) REFERENCES `directus_operations` (`id`),
  CONSTRAINT `directus_operations_resolve_foreign` FOREIGN KEY (`resolve`) REFERENCES `directus_operations` (`id`),
  CONSTRAINT `directus_operations_user_created_foreign` FOREIGN KEY (`user_created`) REFERENCES `directus_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_panels`
--

DROP TABLE IF EXISTS `directus_panels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_panels` (
  `id` char(36) NOT NULL,
  `dashboard` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `show_header` tinyint(1) NOT NULL DEFAULT 0,
  `note` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `position_x` int(11) NOT NULL,
  `position_y` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `user_created` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_panels_dashboard_foreign` (`dashboard`),
  KEY `directus_panels_user_created_foreign` (`user_created`),
  CONSTRAINT `directus_panels_dashboard_foreign` FOREIGN KEY (`dashboard`) REFERENCES `directus_dashboards` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_panels_user_created_foreign` FOREIGN KEY (`user_created`) REFERENCES `directus_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_permissions`
--

DROP TABLE IF EXISTS `directus_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `collection` varchar(64) NOT NULL,
  `action` varchar(10) NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `validation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`validation`)),
  `presets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`presets`)),
  `fields` text DEFAULT NULL,
  `policy` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_permissions_collection_foreign` (`collection`),
  KEY `directus_permissions_policy_foreign` (`policy`),
  CONSTRAINT `directus_permissions_policy_foreign` FOREIGN KEY (`policy`) REFERENCES `directus_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_policies`
--

DROP TABLE IF EXISTS `directus_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_policies` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(64) NOT NULL DEFAULT 'badge',
  `description` text DEFAULT NULL,
  `ip_access` text DEFAULT NULL,
  `enforce_tfa` tinyint(1) NOT NULL DEFAULT 0,
  `admin_access` tinyint(1) NOT NULL DEFAULT 0,
  `app_access` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_presets`
--

DROP TABLE IF EXISTS `directus_presets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_presets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bookmark` varchar(255) DEFAULT NULL,
  `user` char(36) DEFAULT NULL,
  `role` char(36) DEFAULT NULL,
  `collection` varchar(64) DEFAULT NULL,
  `search` varchar(100) DEFAULT NULL,
  `layout` varchar(100) DEFAULT 'tabular',
  `layout_query` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`layout_query`)),
  `layout_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`layout_options`)),
  `refresh_interval` int(11) DEFAULT NULL,
  `filter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`filter`)),
  `icon` varchar(64) DEFAULT 'bookmark',
  `color` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_presets_collection_foreign` (`collection`),
  KEY `directus_presets_user_foreign` (`user`),
  KEY `directus_presets_role_foreign` (`role`),
  CONSTRAINT `directus_presets_role_foreign` FOREIGN KEY (`role`) REFERENCES `directus_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_presets_user_foreign` FOREIGN KEY (`user`) REFERENCES `directus_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_relations`
--

DROP TABLE IF EXISTS `directus_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_relations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `many_collection` varchar(64) NOT NULL,
  `many_field` varchar(64) NOT NULL,
  `one_collection` varchar(64) DEFAULT NULL,
  `one_field` varchar(64) DEFAULT NULL,
  `one_collection_field` varchar(64) DEFAULT NULL,
  `one_allowed_collections` text DEFAULT NULL,
  `junction_field` varchar(64) DEFAULT NULL,
  `sort_field` varchar(64) DEFAULT NULL,
  `one_deselect_action` varchar(255) NOT NULL DEFAULT 'nullify',
  PRIMARY KEY (`id`),
  KEY `directus_relations_many_collection_foreign` (`many_collection`),
  KEY `directus_relations_one_collection_foreign` (`one_collection`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_revisions`
--

DROP TABLE IF EXISTS `directus_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_revisions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `activity` int(10) unsigned NOT NULL,
  `collection` varchar(64) NOT NULL,
  `item` varchar(255) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `delta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`delta`)),
  `parent` int(10) unsigned DEFAULT NULL,
  `version` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_revisions_collection_foreign` (`collection`),
  KEY `directus_revisions_parent_foreign` (`parent`),
  KEY `directus_revisions_activity_foreign` (`activity`),
  KEY `directus_revisions_version_foreign` (`version`),
  CONSTRAINT `directus_revisions_activity_foreign` FOREIGN KEY (`activity`) REFERENCES `directus_activity` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_revisions_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `directus_revisions` (`id`),
  CONSTRAINT `directus_revisions_version_foreign` FOREIGN KEY (`version`) REFERENCES `directus_versions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_roles`
--

DROP TABLE IF EXISTS `directus_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_roles` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(64) NOT NULL DEFAULT 'supervised_user_circle',
  `description` text DEFAULT NULL,
  `parent` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_roles_parent_foreign` (`parent`),
  CONSTRAINT `directus_roles_parent_foreign` FOREIGN KEY (`parent`) REFERENCES `directus_roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_sessions`
--

DROP TABLE IF EXISTS `directus_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_sessions` (
  `token` varchar(64) NOT NULL,
  `user` char(36) DEFAULT NULL,
  `expires` timestamp NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `share` char(36) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  `next_token` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `directus_sessions_user_foreign` (`user`),
  KEY `directus_sessions_share_foreign` (`share`),
  CONSTRAINT `directus_sessions_share_foreign` FOREIGN KEY (`share`) REFERENCES `directus_shares` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_sessions_user_foreign` FOREIGN KEY (`user`) REFERENCES `directus_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_settings`
--

DROP TABLE IF EXISTS `directus_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_name` varchar(100) NOT NULL DEFAULT 'Directus',
  `project_url` varchar(255) DEFAULT NULL,
  `project_color` varchar(255) NOT NULL DEFAULT '#6644FF',
  `project_logo` char(36) DEFAULT NULL,
  `public_foreground` char(36) DEFAULT NULL,
  `public_background` char(36) DEFAULT NULL,
  `public_note` text DEFAULT NULL,
  `auth_login_attempts` int(10) unsigned DEFAULT 25,
  `auth_password_policy` varchar(100) DEFAULT NULL,
  `storage_asset_transform` varchar(7) DEFAULT 'all',
  `storage_asset_presets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`storage_asset_presets`)),
  `custom_css` text DEFAULT NULL,
  `storage_default_folder` char(36) DEFAULT NULL,
  `basemaps` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`basemaps`)),
  `mapbox_key` varchar(255) DEFAULT NULL,
  `module_bar` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_bar`)),
  `project_descriptor` varchar(100) DEFAULT NULL,
  `default_language` varchar(255) NOT NULL DEFAULT 'en-US',
  `custom_aspect_ratios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`custom_aspect_ratios`)),
  `public_favicon` char(36) DEFAULT NULL,
  `default_appearance` varchar(255) NOT NULL DEFAULT 'auto',
  `default_theme_light` varchar(255) DEFAULT NULL,
  `theme_light_overrides` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`theme_light_overrides`)),
  `default_theme_dark` varchar(255) DEFAULT NULL,
  `theme_dark_overrides` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`theme_dark_overrides`)),
  `report_error_url` varchar(255) DEFAULT NULL,
  `report_bug_url` varchar(255) DEFAULT NULL,
  `report_feature_url` varchar(255) DEFAULT NULL,
  `public_registration` tinyint(1) NOT NULL DEFAULT 0,
  `public_registration_verify_email` tinyint(1) NOT NULL DEFAULT 1,
  `public_registration_role` char(36) DEFAULT NULL,
  `public_registration_email_filter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`public_registration_email_filter`)),
  PRIMARY KEY (`id`),
  KEY `directus_settings_project_logo_foreign` (`project_logo`),
  KEY `directus_settings_public_foreground_foreign` (`public_foreground`),
  KEY `directus_settings_public_background_foreign` (`public_background`),
  KEY `directus_settings_storage_default_folder_foreign` (`storage_default_folder`),
  KEY `directus_settings_public_favicon_foreign` (`public_favicon`),
  KEY `directus_settings_public_registration_role_foreign` (`public_registration_role`),
  CONSTRAINT `directus_settings_project_logo_foreign` FOREIGN KEY (`project_logo`) REFERENCES `directus_files` (`id`),
  CONSTRAINT `directus_settings_public_background_foreign` FOREIGN KEY (`public_background`) REFERENCES `directus_files` (`id`),
  CONSTRAINT `directus_settings_public_favicon_foreign` FOREIGN KEY (`public_favicon`) REFERENCES `directus_files` (`id`),
  CONSTRAINT `directus_settings_public_foreground_foreign` FOREIGN KEY (`public_foreground`) REFERENCES `directus_files` (`id`),
  CONSTRAINT `directus_settings_public_registration_role_foreign` FOREIGN KEY (`public_registration_role`) REFERENCES `directus_roles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `directus_settings_storage_default_folder_foreign` FOREIGN KEY (`storage_default_folder`) REFERENCES `directus_folders` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_shares`
--

DROP TABLE IF EXISTS `directus_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_shares` (
  `id` char(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `collection` varchar(64) NOT NULL,
  `item` varchar(255) NOT NULL,
  `role` char(36) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_created` char(36) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `date_start` timestamp NULL DEFAULT NULL,
  `date_end` timestamp NULL DEFAULT NULL,
  `times_used` int(11) DEFAULT 0,
  `max_uses` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_shares_role_foreign` (`role`),
  KEY `directus_shares_user_created_foreign` (`user_created`),
  KEY `directus_shares_collection_foreign` (`collection`),
  CONSTRAINT `directus_shares_collection_foreign` FOREIGN KEY (`collection`) REFERENCES `directus_collections` (`collection`) ON DELETE CASCADE,
  CONSTRAINT `directus_shares_role_foreign` FOREIGN KEY (`role`) REFERENCES `directus_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `directus_shares_user_created_foreign` FOREIGN KEY (`user_created`) REFERENCES `directus_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_translations`
--

DROP TABLE IF EXISTS `directus_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_translations` (
  `id` char(36) NOT NULL,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_users`
--

DROP TABLE IF EXISTS `directus_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_users` (
  `id` char(36) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `avatar` char(36) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `tfa_secret` varchar(255) DEFAULT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'active',
  `role` char(36) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `last_access` timestamp NULL DEFAULT NULL,
  `last_page` varchar(255) DEFAULT NULL,
  `provider` varchar(128) NOT NULL DEFAULT 'default',
  `external_identifier` varchar(255) DEFAULT NULL,
  `auth_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`auth_data`)),
  `email_notifications` tinyint(1) DEFAULT 1,
  `appearance` varchar(255) DEFAULT NULL,
  `theme_dark` varchar(255) DEFAULT NULL,
  `theme_light` varchar(255) DEFAULT NULL,
  `theme_light_overrides` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`theme_light_overrides`)),
  `theme_dark_overrides` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`theme_dark_overrides`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `directus_users_external_identifier_unique` (`external_identifier`),
  UNIQUE KEY `directus_users_email_unique` (`email`),
  UNIQUE KEY `directus_users_token_unique` (`token`),
  KEY `directus_users_role_foreign` (`role`),
  CONSTRAINT `directus_users_role_foreign` FOREIGN KEY (`role`) REFERENCES `directus_roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_versions`
--

DROP TABLE IF EXISTS `directus_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_versions` (
  `id` char(36) NOT NULL,
  `key` varchar(64) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `collection` varchar(64) NOT NULL,
  `item` varchar(255) NOT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NULL DEFAULT current_timestamp(),
  `user_created` char(36) DEFAULT NULL,
  `user_updated` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_versions_collection_foreign` (`collection`),
  KEY `directus_versions_user_created_foreign` (`user_created`),
  KEY `directus_versions_user_updated_foreign` (`user_updated`),
  CONSTRAINT `directus_versions_collection_foreign` FOREIGN KEY (`collection`) REFERENCES `directus_collections` (`collection`) ON DELETE CASCADE,
  CONSTRAINT `directus_versions_user_created_foreign` FOREIGN KEY (`user_created`) REFERENCES `directus_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `directus_versions_user_updated_foreign` FOREIGN KEY (`user_updated`) REFERENCES `directus_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `directus_webhooks`
--

DROP TABLE IF EXISTS `directus_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `directus_webhooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `method` varchar(10) NOT NULL DEFAULT 'POST',
  `url` varchar(255) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'active',
  `data` tinyint(1) NOT NULL DEFAULT 1,
  `actions` varchar(100) NOT NULL,
  `collections` varchar(255) NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`headers`)),
  `was_active_before_deprecation` tinyint(1) NOT NULL DEFAULT 0,
  `migrated_flow` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `directus_webhooks_migrated_flow_foreign` (`migrated_flow`),
  CONSTRAINT `directus_webhooks_migrated_flow_foreign` FOREIGN KEY (`migrated_flow`) REFERENCES `directus_flows` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-10-20 18:40:01
