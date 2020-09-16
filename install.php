<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_bitlockerstatus()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `bitlockerstatus` (
                              `ID` INT(11) NOT NULL AUTO_INCREMENT,
                              `HARDWARE_ID` INT(11) NOT NULL,
                              `DRIVE` VARCHAR(255) DEFAULT NULL,
                              `VOLUMETYPE` VARCHAR(255) DEFAULT NULL,
                              `CONVERSIONSTATUS` VARCHAR(255) DEFAULT NULL,
                              `PROTECTIONSTATUS` VARCHAR(255) DEFAULT NULL,
                              `ENCRYPMETHOD` VARCHAR(255) DEFAULT NULL,
                              `INITPROTECT` VARCHAR(255) DEFAULT NULL,
							  `RECOVERYPASSWORD` VARCHAR(255) DEFAULT NULL,
							  `PROTECTORS` VARCHAR(255) DEFAULT NULL,
							  `PASSWORDID` VARCHAR(255) DEFAULT NULL,
                              PRIMARY KEY  (`ID`,`HARDWARE_ID`)
                            ) ENGINE=INNODB ;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_bitlockerstatus()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `bitlockerstatus`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_bitlockerstatus()
{

}
