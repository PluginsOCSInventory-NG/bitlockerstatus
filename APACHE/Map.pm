###############################################################################
## OCSINVENTORY-NG
## Copyleft Stephane PAUTREL 2018
## Web : http://www.acb78.com
##
## This code is open source and may be copied and modified as long as the source
## code is always made freely available.
## Please refer to the General Public Licence http://www.gnu.org/ or Licence.txt
################################################################################
 
package Apache::Ocsinventory::Plugins::Bitlockerstatus::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;

$DATA_MAP{bitlockerstatus} = {
	mask => 0,
		multi => 1,
		auto => 1,
		delOnReplace => 1,
		sortBy => 'DRIVE',
		writeDiff => 0,
		cache => 0,
		fields => {
			DRIVE => {},
			VOLUMETYPE => {},
			CONVERSIONSTATUS => {},
			PROTECTIONSTATUS => {},
			ENCRYPMETHOD => {},
			INITPROTECT => {},
			RECOVERYPASSWORD => {},
			PROTECTORS => {},
			PASSWORDID => {}
}
};
1;
