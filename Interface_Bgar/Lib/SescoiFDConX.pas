unit SescoiFDConX;

interface

uses
  Winapi.Windows,
  System.AnsiStrings,
  System.Classes,
  System.SysUtils,
  ActiveX,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,

  Vcl.Dialogs;

type
  TConXas = (asRoot,asUser,asBackup,asView,asProvided);

type
  TSCQuery = class(TFDQuery)
  private

  public

  end;

type
  TFDConX = class(TFDConnection)
  private
  { private declarations }
    FWaitCursor:        TFDGUIxWaitCursor;
    FMySQLDriverLink:   TFDPhysMySQLDriverLink;

    FConXas:  TConXas;
    FCallCoInitialize:  Boolean;

    FEngine:  string; //Default MySQL

    FServer:  string; //Default localhost
    FPort:    integer;//Default 3306
    FDatabase:string; //Default MyWorkPLAN
    FCharset: string; //Default latin1

    FUserName:string; //MyWpUser
    FPassword:string; //

    procedure CreateConX();
    procedure SetConXParameters();
    procedure LoadParametersFromRegistry(AInfoProvide:Boolean);

    procedure SetCharset(ACharset: string);

    function GetFromRegistry(AKey: string; ASubKey: string; ADefault: string): string; overload;
//    function GetFromRegistry(AKey: string; ASubKey: string; ADefault: integer): integer; overload;
  protected
  { protected declarations }
  public
  { public declarations }
    constructor Create(AOpenConXas:TConXas=asUser; ACallCoInitialize:boolean=False); reintroduce; overload;
    constructor Create(AServer: string; APort: Integer; ADatabase: string; ACharset: string; AOpenConXas:TConXas=asUser; ACallCoInitialize:boolean=False); reintroduce; overload;
    destructor Destroy(); override;

    function Select(AQuery: string):TSCQuery; overload; deprecated 'Use Select(AQuery: string; var ASCQuery: TSCQuery): Boolean instead of' ;
    function Select(AQuery: string; var ASCQuery: TSCQuery): Boolean; overload;
    function Select(AQuery: string; ADefault: String):String; overload;
    function Select(AQuery: string; ADefault: Integer):Integer; overload;
    function Select(AQuery: string; ADefault: Double):Double; overload;
    function Select(AQuery: string; ADefault: Boolean):Boolean; overload;
    function Insert(AQuery: string):Integer;
    function Update(AQuery: string):Integer;
    function Delete(AQuery: string):Integer;

    function GetIntId(ATableName: string):Integer;
    function GetUserParamString(AUserId: integer; AParId: integer):String;
    function GetUserParamInteger(AUserId: integer; AParId: integer):Integer;
    function GetUserParamDate(AUserId: integer; AParId: integer):TDate;
    function GetUserParamFloat(AUserId: integer; AParId: integer):Double;

    property UserName: String read FUserName write FUserName;
    property Passowrd: string read FPassword write FPassword;
  published
  { published declarations }
  end;

  function FormatDecimalWithPoint(d:double):string;
  function FormatDecimalPointWithLocal(s:string):string;
  function FormatDateToMySQLDate(ADateTime:TDateTime):string;
  function FormatDateTimeInternational(ADateTime: TDateTime):string;

const
  DefaultCharset= 'latin1';

implementation

uses
  SescoiRegistry,
  SescoiRegistryKeys;

function ReadP(su:string;var sp:string):boolean;
{-------------------------------------------------------------------------------
  Procedure: ReadP
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
var
  c:                    ansistring;
  DLLRoutine:           function(login:PAnsiChar;crypt:PAnsiChar;clair:PAnsiChar):Boolean; stdcall;
  DLLHandle:            THandle;
  WPInstallDir:         string;
begin
  c:='0123456789';

//  FLogFile.Write(Format(_('Directory %s'),[QuotedStr(ExtractFilePath(ParamStr(0)))]));

  DLLHandle := LoadLibrary('..\myclient.dll');
  if DLLHandle=0 then
  begin
//    FLogFile.Write(Format(_('Could not locate %s'),[QuotedStr('..\myclient.dll')]));
    DLLHandle:=LoadLibrary('myclient.dll');
  end
  else
  begin
//    FLogFile.Write(Format(_('Locate %s'),[QuotedStr('..\myclient.dll')]));
  end;
  if DLLHandle=0 then
  begin
//    FLogFile.Write(Format(_('Could not locate %s'),[QuotedStr('myclient.dll')]));
    WPInstallDir:=regReadString(HKEY_LOCAL_MACHINE, HKLM_MYWP, 'INSTALLDIR','');
    if WPInstallDir<>'' then
    begin
      DLLHandle:=LoadLibrary(PChar(IncludeTrailingPathDelimiter(WPInstallDir) + 'myclient.dll'));
    end;
  end
  else
  begin
//    FLogFile.Write(Format(_('Locate %s'),[QuotedStr('myclient.dll')]));
  end;
  if DLLHandle=0 then
  begin
//    FLogFile.Write(Format(_('Could not locate %s'),[QuotedStr(IncludeTrailingPathDelimiter(WPInstallDir) + 'myclient.dll')]));
    Result:=False;
    EXIT;
  end
  else
  begin
//    FLogFile.Write(Format(_('Locate %s'),[QuotedStr(IncludeTrailingPathDelimiter(WPInstallDir) + 'myclient.dll')]));
  end;
  try
    DLLRoutine := GetProcAddress(DLLHandle, 'DeCode');
    if Assigned(DLLRoutine) then
    begin
      DLLRoutine(PAnsiChar(AnsiString(su)), PAnsiChar(AnsiString(sp)), @c[1]);
      If Pos(AnsiString(#0),c)>0 then c:=Copy(c,1,Pos(AnsiString(#0),c)-1);
      sp:=WideString(c);
      Result:=True;
    end
    else
    begin
//      FConXState:=CnxstError;
//      FConXError:='MyClient.dll not found';
      Result:=False;
    end;
  finally
    FreeLibrary(DLLHandle);
  end;
end;

function FormatDecimalWithPoint(d:double):string;
{-------------------------------------------------------------------------------
  Procedure: FormatDecimalWithPoint
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
var
  setting:  Tformatsettings;
begin
  setting:=TFormatSettings.Create();
  setting.DecimalSeparator:='.';
  Result:=Trim(Format('%g ',[d], setting));
end;

function FormatDecimalPointWithLocal(s:string):string;
{-------------------------------------------------------------------------------
  Procedure: FormatDecimalPointWithLocal
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
var
  setting:  Tformatsettings;
begin
  setting:=TFormatSettings.Create();
  Result:=StringReplace(s,'.',setting.DecimalSeparator,[])
end;

function FormatDateToMySQLDate(ADateTime:TDateTime):string;
{-----------------------------------------------------------------------------
  Procedure: FormatDateToMySQLDate
  Author:    vdupuis
  Date:      2010-01-28
-----------------------------------------------------------------------------}
const
  MySQLDateFormat=    'YYYY-MM-DD HH:NN:SS';
begin
  RESULT:=FormatDateTime(MySQLDateFormat, ADateTime);
end;

function FormatDateTimeInternational(ADateTime: TDateTime):string;
{-------------------------------------------------------------------------------
  Procedure: FormatDateTimeInternational
  Author:    vdupuis
  DateTime:  2015.05.21
-------------------------------------------------------------------------------}
const
  MySQLDateFormat=    'YYYY-MM-DD HH:NN:SS';
begin
  RESULT:=FormatDateTime(MySQLDateFormat, ADateTime);
end;

{ TFDConX }

constructor TFDConX.Create(AOpenConXas: TConXas; ACallCoInitialize: boolean);
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Create
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
begin
  FConXas:=AOpenConXas;
  FCallCoInitialize:=ACallCoInitialize;
  SetCharset('');

  CreateConX();
  LoadParametersFromRegistry(False);
  SetConXParameters();
end;

constructor TFDConX.Create(AServer: string; APort: Integer; ADatabase: string; ACharset: string; AOpenConXas: TConXas; ACallCoInitialize: boolean);
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Create
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  FServer:=AServer;
  FPort:=APort;
  FDatabase:=ADatabase;
  SetCharset(ACharset);

  FConXas:=AOpenConXas;
  FCallCoInitialize:=ACallCoInitialize;

  CreateConX();
  LoadParametersFromRegistry(True);
  SetConXParameters();
end;

procedure TFDConX.CreateConX;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.CreateConX
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  inherited Create(nil);

  if FCallCoInitialize then
  begin
    try
      CoInitialize(nil);
    except
      {do nothing}
    end;
  end;

  FWaitCursor:=TFDGUIxWaitCursor.Create(nil);
  FMySQLDriverLink:=TFDPhysMySQLDriverLink.Create(nil);
  FMySQLDriverLink.VendorLib:='libmysql.dll';
end;

function TFDConX.Delete(AQuery: string): Integer;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Delete
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
begin
  Result:=Insert(AQuery);
end;

destructor TFDConX.Destroy;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Destroy
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
begin
  FMySQLDriverLink.Free;
  FWaitCursor.Free;

  if FCallCoInitialize then
  begin
    try
      CoUnInitialize();
    except
      {do nothing}
    end;
  end;
  inherited;
end;

function TFDConX.GetFromRegistry(AKey, ASubKey, ADefault: string): string;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.GetFromRegistry
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
begin
  Result:=regReadString(HKEY_LOCAL_MACHINE, IncludeTrailingPathDelimiter(HKLM_MYWP) + AKey, ASubKey, ADefault);
  Result:=regReadString(HKEY_CURRENT_USER, IncludeTrailingPathDelimiter(HKCU_MYWP) + AKey, ASubKey, Result);
end;

function TFDConX.GetIntId(ATableName: string): Integer;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.GetIntId
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
var
  Query:  string;
begin
  Query:='SELECT get_int_id(%s)';
  Query:=Format(Query, [QuotedStr(ATableName)]);

  Result:=Select(Query, -1);
end;

function TFDConX.GetUserParamInteger(AUserId, AParId: integer): Integer;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.GetUserParam
  Author:    vdupuis
  DateTime:  2015.05.20
-------------------------------------------------------------------------------}
var
  sSelect:        String;
begin
  sSelect:='SELECT ' +
           '  num ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=%d ' +
           'UNION ' +
           'SELECT ' +
           '  num ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=0 ' +
           'LIMIT 1;';
  sSelect:=Format(sSelect,[AParId, AUserId, AParId]);

  Result:=Select(sSelect, -1);
end;

function TFDConX.GetUserParamString(AUserId, AParId: integer): String;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.GetUserParam
  Author:    vdupuis
  DateTime:  2015.05.20
-------------------------------------------------------------------------------}
var
  sSelect:        String;
begin
  sSelect:='SELECT ' +
           '  str ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=%d ';
  sSelect:=Format(sSelect,[AParId, AUserId]);

  Result:=Select(sSelect, '');

  if Result.IsEmpty then
  begin
    sSelect:= 'SELECT ' +
              '  num ' +
              'FROM ' +
              '  user_parameter ' +
              'WHERE ' +
              '  par_id=%d ' +
             'AND ' +
             '  users_id=0 ';
    sSelect:=Format(sSelect,[AParId]);

    Result:=Select(sSelect, '');
  end;
end;

function TFDConX.GetUserParamFloat(AUserId, AParId: integer): Double;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.GetUserParam
  Author:    vdupuis
  DateTime:  2015.05.20
-------------------------------------------------------------------------------}
var
  sSelect:        String;
begin
  sSelect:='SELECT ' +
           '  flt ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=%d ' +
           'UNION ' +
           'SELECT ' +
           '  num ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=0 ' +
           'LIMIT 1;';
  sSelect:=Format(sSelect,[AParId, AUserId, AParId]);

  Result:=Select(sSelect, -1);
end;

function TFDConX.GetUserParamDate(AUserId, AParId: integer): TDate;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.GetUserParam
  Author:    vdupuis
  DateTime:  2015.05.20
-------------------------------------------------------------------------------}
var
  sSelect:        String;
begin
  sSelect:='SELECT ' +
           '  dat ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=%d ' +
           'UNION ' +
           'SELECT ' +
           '  num ' +
           'FROM ' +
           '  user_parameter ' +
           'WHERE ' +
           '  par_id=%d ' +
           'AND ' +
           '  users_id=0 ' +
           'LIMIT 1;';
  sSelect:=Format(sSelect,[AParId, AUserId, AParId]);

  Result:=Select(sSelect, Now());
end;

function TFDConX.Insert(AQuery: string): Integer;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Insert
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
begin
  Result:=0;

  try
    Result:=ExecSQL(AQuery);
  except
    on e:Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
end;

//function TFDConX.GetFromRegistry(AKey, ASubKey: string; ADefault: integer): integer;
//{-------------------------------------------------------------------------------
//  Procedure: TFDConX.GetFromRegistry
//  Author:    vdupuis
//  DateTime:  2015.02.17
//-------------------------------------------------------------------------------}
//begin
//  Result:=regReadInteger(HKEY_LOCAL_MACHINE, IncludeTrailingPathDelimiter(HKLM_MYWP) + AKey, ASubKey, ADefault);
//  Result:=regReadInteger(HKEY_CURRENT_USER, IncludeTrailingPathDelimiter(HKCU_MYWP) + AKey, ASubKey, Result);
//end;

procedure TFDConX.LoadParametersFromRegistry(AInfoProvide:Boolean);
{-------------------------------------------------------------------------------
  Procedure: TFDConX.LoadParametersFromRegistry
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
var
  FPortStr:   string;
begin
  FEngine:=GetFromRegistry(KEY_CONNECT, 'Database', 'MySQL');

  if not AInfoProvide then
  begin
    FServer:=GetFromRegistry(KEY_CONNECT, 'Host', 'localhost');
    FPortStr:=GetFromRegistry(KEY_CONNECT, 'Port', '3306');
    FPort:=StrToIntDef(FPortStr, 3306);
    FDatabase:=GetFromRegistry(KEY_CONNECT, 'DBName', 'MyWorkPLAN');
  end;

  case FConXas of
    asRoot:
      begin
        FUserName:=GetFromRegistry(KEY_ADDACC, 'rlog', '9AD25E6BD6696D4F82B490646355FA003EAD5656');
        ReadP('rlog', FUserName);
        FPassword:=GetFromRegistry(KEY_ADDACC, 'rpas', '99D25E60A268081FBA8DA95C3330FB7435AD5655');
        ReadP(FUserName, FPassword);
      end;
    asUser:
      begin
        FUserName:=GetFromRegistry(KEY_CONNECT, 'Login', 'mywpuser');
        FPassword:=GetFromRegistry(KEY_CONNECT, 'Password', '8FC84169A02F0019F988AC1F3538BC763CB24C43');
        ReadP(FUserName, FPassword);
      end;
    asBackup:
      begin
        FUserName:=GetFromRegistry(KEY_ADDACC, 'blog', '9ADD4E7DD6716D4BFACBEF1C6755E20028BD5956');
        ReadP('blog', FUserName);
        FPassword:=GetFromRegistry(KEY_ADDACC, 'bpas', 'E5D23768A9691243FDDBFF1B6F2AFA7F3DC45629');
        ReadP(FUserName, FPassword);
      end;
    asView:
      begin
        FUserName:=GetFromRegistry(KEY_ADDACC, 'vlog', '8FD24168BC690F5CE3CBEF057037FA6A3DB25643');
        ReadP('vlog', FUserName);
        FPassword:=GetFromRegistry(KEY_ADDACC, 'vpas', 'ECD22D68A7691A43E1CFEB076F22FA713DDE5620');
        ReadP(FUserName, FPassword);
      end;
    asProvided:
      begin
//        FUserName:=GetFromRegistry(KEY_CONNECT, 'Login', 'MyWPUser');
//        FPassword:=GetFromRegistry(KEY_CONNECT, 'Password', '');
      end;
  end;
end;

function TFDConX.Select(AQuery: string): TSCQuery;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Select
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
begin
  Result:=TSCQuery.Create(nil);
  Result.Connection:=Self;
  Result.SQL.Text:=AQuery;
  try
    Result.Open();
  except
    on e:Exception do
    begin
      ShowMessage(e.Message);
//      Result.Free;
    end;
  end;
  Result.FetchAll;
end;

function TFDConX.Select(AQuery: string; ADefault: Integer): Integer;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Select
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
var
  FDQuery:  TFDQuery;
begin
  Result:=ADefault;

  FDQuery:=Select(AQuery);

  if FDQuery.RecordCount>0 then
  begin
    if not FDQuery.Fields.Fields[0].IsNull then
    begin
      Result:=FDQuery.Fields.Fields[0].AsInteger;
    end;
  end;

  FDQuery.Free;
end;

function TFDConX.Select(AQuery, ADefault: String): String;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Select
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
var
  FDQuery:  TFDQuery;
begin
  Result:=ADefault;

  FDQuery:=Select(AQuery);

  if FDQuery.RecordCount>0 then
  begin
    Result:=FDQuery.Fields.Fields[0].AsString;
  end;

  FDQuery.Free;
end;

procedure TFDConX.SetCharset(ACharset: string);
{-------------------------------------------------------------------------------
  Procedure: TFDConX.SetCharset
  Author:    vdupuis
  DateTime:  2015.05.21
-------------------------------------------------------------------------------}
begin
  if ACharset.IsEmpty then
  begin
    FCharset:=DefaultCharset;
  end
  else
  begin
    FCharset:=ACharset;
  end;
end;

procedure TFDConX.SetConXParameters;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.LoadParameters
  Author:    vdupuis
  DateTime:  2015.02.17
-------------------------------------------------------------------------------}
begin
  Params.Clear;

  Params.Add(Format('DriverId=%s', [FEngine]));
  Params.Add(Format('Server=%s', [FServer]));  { TODO -oVDU -cDB : FServer = localhost if FServer=ComputerName }
  Params.Add(Format('Port=%d', [FPort]));
  Params.Add(Format('CharacterSet=%s', [FCharset]));
  Params.Add(Format('TinyIntFormat=%s', ['Integer']));

  Params.Database:=FDatabase;

  Params.UserName:=FUserName;
  Params.Password:=FPassword;
end;

function TFDConX.Update(AQuery: string): Integer;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Update
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
begin
  Result:=Insert(AQuery);
end;

function TFDConX.Select(AQuery: string; ADefault: Double): Double;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Select
  Author:    vdupuis
  DateTime:  2015.05.19
-------------------------------------------------------------------------------}
var
  FDQuery:  TFDQuery;
begin
  Result:=ADefault;

  FDQuery:=Select(AQuery);

  if FDQuery.RecordCount>0 then
  begin
    if not FDQuery.Fields.Fields[0].IsNull then
    begin
      Result:=FDQuery.Fields.Fields[0].AsFloat;
    end;
  end;

  FDQuery.Free;
end;

function TFDConX.Select(AQuery: string; ADefault: Boolean): Boolean;
{-------------------------------------------------------------------------------
  Procedure: TFDConX.Select
  Author:    vdupuis
  DateTime:  2015.05.20
-------------------------------------------------------------------------------}
var
  FDQuery:  TFDQuery;
begin
  Result:=ADefault;

  FDQuery:=Select(AQuery);

  if FDQuery.RecordCount>0 then
  begin
    if not FDQuery.Fields.Fields[0].IsNull then
    begin
      Result:=FDQuery.Fields.Fields[0].AsInteger=1;
    end;
  end;

  FDQuery.Free;
end;

function TFDConX.Select(AQuery: string; var ASCQuery: TSCQuery): Boolean;
begin
  Result := False;

  if Assigned(ASCQuery) then
  begin
    ASCQuery.Connection:=Self;
    ASCQuery.SQL.Text:=AQuery;
    try
      ASCQuery.Open();

      Result := True;
    except
      on e:Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
    ASCQuery.FetchAll;
  end;
end;

end.
