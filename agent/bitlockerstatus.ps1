$volumes = Get-BitLockerVolume | select *

foreach($volume in $volumes){
	$stores = Get-BitLockerVolume -MountPoint $volume.MountPoint | select *
    
	foreach ($store in $stores){
			$xml += "<BITLOCKERSTATUS>`n"
			$xml += "<DRIVE>"+$store.MountPoint+"</DRIVE>`n"
			$xml += "<VOLUMETYPE>"+$store.VolumeType+"</VOLUMETYPE>`n"
			$xml += "<CONVERSIONSTATUS>"+$store.VolumeStatus+"</CONVERSIONSTATUS>`n"
			$xml += "<PROTECTIONSTATUS>"+$store.ProtectionStatus+"</PROTECTIONSTATUS>`n"
			$xml += "<ENCRYPMETHOD>"+$store.EncryptionMethod+"</ENCRYPMETHOD>`n"
			$xml += "<INITPROTECT>"+$store.IsVolumeInitializedForProtection+"</INITPROTECT>`n"
			$xml += "</BITLOCKERSTATUS>`n"
	}
}

echo $xml