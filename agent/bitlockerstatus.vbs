'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script :	Retrieve bitlocker status
' Version :	1.1
' Date :	14/09/2020
' Author :	Stéphane PAUTREL (acb78.com)/ GUIRONNET Nicolas
'----------------------------------------------------------
On Error Resume Next

arEncryptionMethod = Array("None", "AES 128 With Diffuser", "AES 256 With Diffuser", "AES 128", "AES 256", "HARDWARE ENCRYPTION", "XTS AES 128", "XTS AES 256")
arConversionStatus = Array("Fully Decrypted", "Fully Encrypted", "Encryption In Progress", "Decryption In Progress", "Encryption Paused", "Decryption Paused")
arLockStatus = Array("Unlocked", "Locked")
arVolumeType = Array("OperatingSystem","Data")

Set SWBemlocator = CreateObject("WbemScripting.SWbemLocator")

Set BitLocker = SWBemlocator.ConnectServer(strComputer,"root\CIMV2\security\microsoftvolumeencryption")
Set BitLockerItems = BitLocker.ExecQuery("Select * from Win32_EncryptableVolume",,48)

For Each BitLockerItem in BitLockerItems

	Result = "<BITLOCKERSTATUS>" & VbCrLf
	Result = Result & "<DRIVE>" & BitLockerItem.DriveLetter & "</DRIVE>" & VbCrLf
	Result = Result & "<VOLUMETYPE>" & arVolumeType(BitLockerItem.VolumeType) & "</VOLUMETYPE>" & VbCrLf
	BitLockerItem.GetConversionStatus ConversionStatus, EncryptionPercentage
	If EncryptionPercentage < 100 and EncryptionPercentage >0 Then 
		Result = Result & "<CONVERSIONSTATUS>" & arConversionStatus(BitLockerItem.ConversionStatus) & " - " & (EncryptionPercentage) & "%</CONVERSIONSTATUS>" & VbCrLf
	Else
		Result = Result & "<CONVERSIONSTATUS>" & arConversionStatus(BitLockerItem.ConversionStatus) & "</CONVERSIONSTATUS>" & VbCrLf
	End If
	Result = Result & "<PROTECTIONSTATUS>" & arLockStatus(BitLockerItem.ProtectionStatus) & "</PROTECTIONSTATUS>" & VbCrLf

	Result = Result & "<ENCRYPMETHOD>" & arEncryptionMethod(BitLockerItem.EncryptionMethod) & "</ENCRYPMETHOD>" & VbCrLf
	Result = Result & "<INITPROTECT>" & BitLockerItem.IsVolumeInitializedForProtection & "</INITPROTECT>" & VbCrLf
	BitLockerItem.GetKeyProtectors 0,VolumeKeyProtectorID
	Protectors=""
	For Each objId in VolumeKeyProtectorID
		BitLockerItem.GetKeyProtectorFriendlyName objId, VolumeKeyProtectorFriendlyName
		Protectors=VolumeKeyProtectorFriendlyName & "," & Protectors
		BitLockerItem.GetKeyProtectorType  objId, ProtectorType
		If ProtectorType=3 Then 
			BitLockerItem.GetKeyProtectorNumericalPassword  objId,Password
		Else	
			Password="none"
		End If
	Next
	Protectors=Left(Protectors,Len(Protectors)-1)
	Result = Result & "<PROTECTORS>" & Protectors & "</PROTECTORS>" & VbCrLf
	Result = Result & "<RECOVERYPASSWORD>" & Password & "</RECOVERYPASSWORD>" & VbCrLf
	Result = Result & "</BITLOCKERSTATUS>" & VbCrLf
	WScript.Echo Result

Next