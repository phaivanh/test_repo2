unit SescoiRegistryKeys;

interface

//const
  {general path}
//  regHKLMPath=    'SOFTWARE\Sescoi\MyWorkPLAN';
//  regHKCUPath=    'SOFTWARE\Sescoi International\MyWorkPLAN';

  {path}
//  regHKLMLicensePath= regHKLMPath + '\License';
//  regHKLMServerPath= regHKLMPath + '\Server';

  {keys}
  //keyINSTALLDIR=      'INSTALLDIR';

const
  HKLM_MYWP=          'SOFTWARE\Sescoi\MyWorkPLAN';
  HKCU_MYWP=          'Software\Sescoi International\MyWorkPLAN';

  KEY_CONNECT=        'Connect';
  KEY_ADDACC=         'Connect\AddAcc';
  KEY_LICENSE=        'License';
  KEY_SERVER=         'Server';
  KEY_GOOGLEAPI=      'GoogleAPI';
  KEY_MDSELECTION=    'MDSelection';

  SUBKEY_INSTALLDIR=      'INSTALLDIR';
  SUBKEY_GOOGLEAPIKEY=    'APIKEY';
  SUBKEY_GOOGLEAPIVERSION='APIVERSION';
  SUBKEY_DEBUG=           'DEBUG';
  SUBKEY_LASTREPORT=      'LastReport';

  SUBKEY_ALIVEDELAY=          'AliveDelay';
  SUBKEY_SERVERPORT=          'Port';
  SUBKEY_INTERFACEPORT=       'InterfacePort';
  SUBKEY_BADNAMERESOLUTION=   'BadNameResolution';

  HKLM_MYWP_LICENSE=          HKLM_MYWP + '\' + KEY_LICENSE;
  HKLM_MYWP_SERVER=           HKLM_MYWP + '\' + KEY_SERVER;
  HKLM_MYWP_MDSELECTION=      HKLM_MYWP + '\' + KEY_MDSELECTION;

implementation

end.
