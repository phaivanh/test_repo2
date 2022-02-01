unit cls.UserSettings;

interface

uses
  Vcl.Dialogs,
  System.SysUtils,
  System.IniFiles,
  Winapi.Windows,

  //Sescoi
  SescoiFileUtils,
  SescoiRegistry,
  SescoiRegistryKeys,
  uConneXion;

type
  TUserSettings = class
  private
    FIniFilePath      : string;

    FServer           : string;
    FPort             : Integer;
    FDatabase         : string;
    FCharset          : string;
    FEmployee         : Integer;
    FShowGeneratedFiles : Boolean;
    FLocalLogFolder     : string;

    FWPSIsInstalled     : Boolean; //indique si WPS est installé


    procedure Load();
    function IsWPSInstalled():boolean;
    procedure GetInfoFromWPSRegistry();

    function GetFromRegistry(AKey, ASubKey, ADefault: string): string; overload;
    function GetFromRegistry(AKey, ASubKey: string; ADefault: integer): integer; overload;
  public
    constructor Create();
    procedure Save();

    function ParametersMissing():Boolean;

    property IniFilePath: string read FIniFilePath ;
    property Host: string read FServer write FServer;
    property Port: Integer read FPort write FPort;
    property Database: string read FDatabase write FDatabase;
    property Charset: string read FCharset write FCharset;
    property LocalLogFolder: string read FLocalLogFolder ;

    property WPSIsInstalled: Boolean read FWPSIsInstalled;
    property ShowGeneratedFiles: Boolean read FShowGeneratedFiles;

  end;

var
  GUserSettings: TUserSettings;

const
  CDefaultPort: integer =   3306;

implementation

{ TUserSettings }
uses ugfunctions, UNameHexagon;

function TUserSettings.GetFromRegistry(AKey, ASubKey, ADefault: string): string;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.GetFromRegistry
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  Result:=regReadString(HKEY_LOCAL_MACHINE, IncludeTrailingPathDelimiter(HKLM_MYWP) + AKey, ASubKey, ADefault);
  Result:=regReadString(HKEY_CURRENT_USER, IncludeTrailingPathDelimiter(HKCU_MYWP) + AKey, ASubKey, Result);
end;

function TUserSettings.GetFromRegistry(AKey, ASubKey: string; ADefault: integer): integer;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.GetFromRegistry
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  Result:=regReadInteger(HKEY_LOCAL_MACHINE, IncludeTrailingPathDelimiter(HKLM_MYWP) + AKey, ASubKey, ADefault);
  Result:=regReadInteger(HKEY_CURRENT_USER, IncludeTrailingPathDelimiter(HKCU_MYWP) + AKey, ASubKey, Result);
end;

constructor TUserSettings.Create;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.Create

-------------------------------------------------------------------------------}
var
  ProgDataFolder : string;
begin
//  FIniFilePath:=IncludeTrailingPathdelimiter(GetFolder(sdCommon, '', 'Vero Software', 'WorkNC_Interface', '', True)) + 'WorkNC_Interface.ini';
//  FLocalLogFolder := GetFolder(sdCommon, '', 'Vero Software', 'WorkNC_Interface', 'log', True);

  ProgDataFolder := GetProgDataFolder('WorkNC_Interface');
  FIniFilePath:=IncludeTrailingPathdelimiter(ProgDataFolder) + 'WorkNC_Interface.ini';
  FLocalLogFolder := IncludeTrailingBackslash( ProgDataFolder) + 'log';

  Load();
end;

procedure TUserSettings.GetInfoFromWPSRegistry;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.GetInfoFromWPSRegistry
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
var
  FPortStr:     string;
begin
  FServer:=GetFromRegistry(KEY_CONNECT, 'Host', 'localhost');
  FPortStr:=GetFromRegistry(KEY_CONNECT, 'Port', '3306');
  FPort:=StrToIntDef(FPortStr, 3306);
  FDatabase:=GetFromRegistry(KEY_CONNECT, 'DBName', 'MyWorkPLAN');

end;

procedure TUserSettings.Load;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.Load
  Author:    vdupuis
  DateTime:  2015.05.11
-------------------------------------------------------------------------------}
var
  IniFile:      TIniFile;
begin
  IniFile:=TIniFile.Create(FIniFilePath);

  {ConneXion}

  if IsWPSInstalled then
  begin
    FWPSIsInstalled:=True;
    GetInfoFromWPSRegistry();
  end
  else
  begin
    FWPSIsInstalled:=False;
    FServer:=IniFile.ReadString('Connection', 'Host', '');
    FPort:=IniFile.ReadInteger('Connection', 'Port', CDefaultPort);
    FDatabase:=IniFile.ReadString('Connection', 'Database', '');
  end;
  FCharset:=IniFile.ReadString('Connection', 'Charset', 'utf8');

  IniFile.Free;
end;

function TUserSettings.ParametersMissing: Boolean;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.ParametersMissing
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  Result:=FServer.IsEmpty or (FPort=-1) or FDatabase.IsEmpty ;
end;

procedure TUserSettings.Save;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.Save
  Author:    vdupuis
  DateTime:  2015.05.11
-------------------------------------------------------------------------------}
var
  IniFile:      TIniFile;
  reqsql : string;
begin
  IniFile:=TIniFile.Create(FIniFilePath);

  {ConneXion}
  IniFile.WriteString('Connection', 'Host', FServer);
  IniFile.WriteInteger('Connection', 'Port', FPort);
  IniFile.WriteString('Connection', 'Database', FDatabase);
  IniFile.WriteString('Connection', 'Charset', FCharset);

  IniFile.Free;
end;

function TUserSettings.IsWPSInstalled():Boolean;
{-------------------------------------------------------------------------------
  Procedure: TUserSettings.WPSIsInstalled
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  {$MESSAGE WARN 'Change to take registry setting'}
  //Result:=False;
  Result:=regReadString(HKEY_LOCAL_MACHINE, HKLM_MYWP, SUBKEY_INSTALLDIR, '') <>'';
end;

initialization
  GUserSettings:=TUserSettings.Create();

finalization
  GUserSettings.Free;

end.
