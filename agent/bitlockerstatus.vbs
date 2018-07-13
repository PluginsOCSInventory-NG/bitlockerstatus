'----------------------------------------------------------
' Plugin for OCS Inventory NG 2.x
' Script :	Retrieve bitlocker status
' Version :	1.00
' Date :	13/07/2018
' Author :	Stéphane PAUTREL (acb78.com)
'----------------------------------------------------------
' OS checked [X] on	32b	64b	(Professionnal edition)
' Windows XP		[ ]
' Windows Vista		[ ]	[ ]
' Windows 7			[ ]	[ ]
' Windows 8.1		[ ]	[ ]	
' Windows 10		[X]	[X]
' Windows 2k8R2			[ ]
' Windows 2k12R2		[ ]
' Windows 2k16			[ ]
' ---------------------------------------------------------
' NOTE : No checked on Windows 8
' ---------------------------------------------------------
On Error Resume Next

Set SWBemlocator = CreateObject("WbemScripting.SWbemLocator")

Set BitLocker = SWBemlocator.ConnectServer(strComputer,"root\CIMV2\security\microsoftvolumeencryption")
Set BitLockerItems = BitLocker.ExecQuery("Select * from Win32_EncryptableVolume",,48)

For Each BitLockerItem in BitLockerItems

	Result = "<BITLOCKERSTATUS>" & VbCrLf
	Result = Result & "<DRIVE>" & BitLockerItem.DriveLetter & "</DRIVE>" & VbCrLf
	Result = Result & "<VOLUMETYPE>" & BitLockerItem.VolumeType & "</VOLUMETYPE>" & VbCrLf
	
	If BitLockerItem.ConversionStatus = 1 Then
		Result = Result & "<CONVERSIONSTATUS>" & "ENABLED" & "</CONVERSIONSTATUS>" & VbCrLf
	Else
		Result = Result & "<CONVERSIONSTATUS>" & "DISABLED" & "</CONVERSIONSTATUS>" & VbCrLf
	End If

	If BitLockerItem.ProtectionStatus = 1 Then
		Result = Result & "<PROTECTIONSTATUS>" & "ENABLED" & "</PROTECTIONSTATUS>" & VbCrLf
	Else
		Result = Result & "<PROTECTIONSTATUS>" & "DISABLED" & "</PROTECTIONSTATUS>" & VbCrLf
	End If
	
	Result = Result & "<ENCRYPMETHOD>" & BitLockerItem.EncryptionMethod & "</ENCRYPMETHOD>" & VbCrLf
	Result = Result & "<INITPROTECT>" & BitLockerItem.IsVolumeInitializedForProtection & "</INITPROTECT>" & VbCrLf
	Result = Result & "</BITLOCKERSTATUS>" & VbCrLf
	WScript.Echo Result

Next