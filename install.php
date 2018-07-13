<?php
function plugin_version_bitlockerstatus()
{
return array('name' => 'bitlockerstatus',
'version' => '1.1',
'author'=> 'Stephane PAUTREL',
'license' => 'GPLv2',
'verMinOcs' => '2.2');
}

function plugin_init_bitlockerstatus()
{
$object = new plugins;
$object -> add_cd_entry("bitlockerstatus","other");

$object -> sql_query("CREATE TABLE IF NOT EXISTS `bitlockerstatus` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `HARDWARE_ID` INT(11) NOT NULL,
  `DRIVE` VARCHAR(255) DEFAULT NULL,
  `VOLUMETYPE` VARCHAR(255) DEFAULT NULL,
  `CONVERSIONSTATUS` VARCHAR(255) DEFAULT NULL,
  `PROTECTIONSTATUS` VARCHAR(255) DEFAULT NULL,
  `ENCRYPMETHOD` VARCHAR(255) DEFAULT NULL,
  `INITPROTECT` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY  (`ID`,`HARDWARE_ID`)
) ENGINE=INNODB ;");

}

function plugin_delete_bitlockerstatus()
{
$object = new plugins;
$object -> del_cd_entry("bitlockerstatus");
$object -> sql_query("DROP TABLE `bitlockerstatus`;");

}

?>
