unit SescoiRegistry;

interface

uses
  Registry,
  Windows;

  procedure regWriteString(RootKEY:HKEY;Key:string;SubKey:string;Value:string;CanCreate: Boolean = false);
  procedure regWriteInteger(RootKEY:HKEY;Key:string;SubKey:string;Value:integer;CanCreate: Boolean = false);
  procedure regWriteBinaryData(RootKEY:HKEY;Key:string;SubKey:string; var ABuffer; ABufferSize: Integer; CanCreate: Boolean = false);

  function  regReadString(RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:string):string;
  function  regReadStringEx(Key:string; SubKey:string; DefaultValue:string):string;
  function  regReadInteger(RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:integer):integer;
  function  regReadBinaryData(RootKEY:HKEY;Key:string; SubKey:string; var ABuffer; ABufferSize: Integer):Integer;

  function  regSubKeyExists(RootKEY:HKEY;Key:string;SubKey:string):boolean;

implementation

function regSubKeyExists(RootKEY:HKEY;Key:string;SubKey:string):boolean;
{-----------------------------------------------------------------------------
  Procedure: regSubKeyExists
  Author:    vdupuis
  Date:      16-févr.-2010
  Arguments: RootKEY:HKEY;Key:string;SubKey:string
  Result:    boolean
-----------------------------------------------------------------------------}
var
  reg:            TRegistry;
begin
  RESULT:=FALSE;

  reg:=TRegistry.Create;
  try
    reg.RootKey:= RootKEY;
    reg.OpenKey(Key,False);
    RESULT:=reg.ValueExists(SubKey);
    reg.CloseKey;
  except
    //do nothing
  end;
  reg.Free;
end;

procedure regWriteString(RootKEY:HKEY;Key:string;SubKey:string;Value:string;CanCreate: Boolean = false);
{===============================================================================
  Procedure: regWriteString
  Author:    vdu
  Date:      2008-10-06
  Arguments: RootKEY:HKEY;Key:string;SubKey:string;Value:string
  Result:    string
===============================================================================}
var
  reg:            TRegistry;
begin
  reg:=TRegistry.Create;
  try
    reg.Access:=KEY_ALL_ACCESS;
    reg.RootKey:= RootKEY;
    reg.OpenKey(Key,CanCreate);
    reg.WriteString(SubKey,Value);
    reg.CloseKey;
  except
    //do nothing
  end;
  reg.Free;
end;

procedure regWriteBinaryData(RootKEY:HKEY;Key:string;SubKey:string; var ABuffer; ABufferSize: Integer; CanCreate: Boolean = false);
var
  reg:            TRegistry;
begin
  reg:=TRegistry.Create;
  try
    reg.Access:=KEY_ALL_ACCESS;
    reg.RootKey:= RootKEY;
    reg.OpenKey(Key,CanCreate);
    reg.WriteBinaryData(SubKey, ABuffer, ABufferSize);
    reg.CloseKey;
  except
    //do nothing
  end;
  reg.Free;
end;

procedure regWriteInteger(RootKEY:HKEY;Key:string;SubKey:string;Value:integer;CanCreate: Boolean = false);
{===============================================================================
  Procedure: regWriteInteger
  Author:    vdu
  Date:      2008-10-06
  Arguments: RootKEY:HKEY;Key:string;SubKey:string;Value:integer
  Result:    string
===============================================================================}
var
  reg:            TRegistry;
begin
  reg:=TRegistry.Create;
  try
    reg.Access:=KEY_ALL_ACCESS;
    reg.RootKey:= RootKEY;
    reg.OpenKey(Key,CanCreate);
    reg.WriteInteger(SubKey,Value);
    reg.CloseKey;
  except
    //do nothing
  end;
  reg.Free;
end;

function regReadString(RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:string):string;
{===============================================================================
  Procedure: regReadString
  Author:    vdu
  Date:      2007-11-08
  Arguments: RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:string
  Result:    string
===============================================================================}
var
  reg:            TRegistry;
begin
  reg:=TRegistry.Create;
  try
    reg.RootKey:= RootKEY;
    reg.Access:=KEY_ALL_ACCESS;
    reg.OpenKeyReadOnly(Key);
    if reg.ValueExists(SubKey) then
    begin
      try
        Result:=reg.ReadString(SubKey);
      except
        Result:=DefaultValue;
      end;
    end
    else
    begin
      Result:=DefaultValue;
    end;
    reg.CloseKey;
  except
    Result:=DefaultValue;
  end;
  reg.Free;
end;

function regReadStringEx(Key:string; SubKey:string; DefaultValue:string):string;
{-----------------------------------------------------------------------------
  Procedure: regReadStringEx
  Author:    vdupuis
  Date:      30-janv.-2014
-----------------------------------------------------------------------------}
begin
  Result:=regReadString(HKEY_CURRENT_USER, Key, SubKey,'');
  if Result='' then Result:=regReadString(HKEY_LOCAL_MACHINE, Key, SubKey,'127.0.0.1');
end;


function regReadBinaryData(RootKEY:HKEY;Key:string; SubKey:string; var ABuffer; ABufferSize: Integer):Integer;
{-----------------------------------------------------------------------------
  Procedure: regReadBinaryData
  Author:    vdupuis
  Date:      15-juil.-2013
-----------------------------------------------------------------------------}
var
  reg:            TRegistry;
begin
  FillChar(Result,SizeOf(Result),0);
  reg:=TRegistry.Create;
  try
    reg.RootKey:= RootKEY;
    reg.Access:=KEY_ALL_ACCESS;
    reg.OpenKeyReadOnly(Key);
    if reg.ValueExists(SubKey) then
    begin
      try
        FillChar(Result,ABufferSize,0);
        Result:=reg.ReadBinaryData(SubKey, ABuffer, ABufferSize);
      except
        //Result:=DefaultValue;
      end;
    end
    else
    begin
      //Result:=DefaultValue;
    end;
    reg.CloseKey;
  except
    //Result:=DefaultValue;
  end;
  reg.Free;
end;

//function regReadInteger(RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:integer):integer;
//{===============================================================================
//  Procedure: regReadInteger
//  Author:    vdu
//  Date:      2007-11-08
//  Arguments: RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:integer
//  Result:    integer
//===============================================================================}
//var
//  reg:            TRegistry;
//begin
//  reg:=TRegistry.Create;
//  try
//    reg.RootKey:= RootKEY;
//    reg.Access:=KEY_ALL_ACCESS;
//    reg.OpenKeyReadOnly(Key);
//    if reg.ValueExists(SubKey) then
//    begin
//      try
//        Result:=reg.ReadInteger(SubKey);
//      except
//        Result:=DefaultValue;
//      end;
//    end
//    else
//    begin
//      Result:=DefaultValue;
//    end;
//    reg.CloseKey;
//  except
//    Result:=DefaultValue;
//  end;
//  reg.Free;
//end;

function regReadInteger(RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:integer):integer;
{===============================================================================
  Procedure: regReadString
  Author:    vdu
  Date:      2007-11-08
  Arguments: RootKEY:HKEY;Key:string;SubKey:string;DefaultValue:string
  Result:    string
===============================================================================}
var
  reg:            TRegistry;
begin
  Result:=DefaultValue;

  reg:=TRegistry.Create;
  try
    reg.RootKey:= RootKEY;
    if reg.OpenKeyReadOnly(Key) then
    begin
      if reg.ValueExists(SubKey) then
      begin
        try
          Result:=reg.ReadInteger(SubKey);
        except
          //Result:=DefaultValue;
        end;
      end;
      reg.CloseKey
    end;
  except
    //Result:=DefaultValue;
  end;
  reg.Free;
end;

//function regReadBin(RootKEY:HKEY; Key:string; SubKey:string; var keyValue; Byte: Integer):Integer;
//{-----------------------------------------------------------------------------
//  Procedure: regReadBin
//  Author:    vdupuis
//  Date:      17-mai-2010
//  Arguments: RootKEY:HKEY; Key:string; SubKey:string; var keyValue; Byte: Integer
//  Result:    Integer
//-----------------------------------------------------------------------------}
//var
//  reg:            TRegistry;
//begin
//  RESULT:=-1;
//
//  reg:=TRegistry.Create;
//  try
//    reg.RootKey:= RootKEY;
//    reg.OpenKeyReadOnly(Key);
//    if reg.ValueExists(SubKey) then
//    begin
//      try
//        Result:=reg.ReadBinaryData(SubKey,keyValue,Byte);
//      except
//        {do nothing}
//      end;
//    end;
//    reg.CloseKey
//  except
//    {do nothing}
//  end;
//  reg.Free;
//end;
//
//procedure regWriteBin(keyName: string; var keyValue; Byte: Integer);
//var
//  regKey:TRegistry;
//begin
//  {INITIALISATION DE VARIABLES}
//  regKey:=TRegistry.Create;
//
//  {ECRITURE DE LA CLE DE REGISTRE BINAIRE}
//  TRY
//    regKey.RootKey:=HKEY_LOCAL_MACHINE;
//    regKey.OpenKey('\SOFTWARE\Microsoft\Drivers Diagnostic', True);
//    regKey.WriteBinaryData(keyName,keyValue,Byte);
//  EXCEPT
//    //NOTHING TO DO
//  END;
//
//  {LIBERATION DES OBJETS}
//  regKey.Free;
//end;

end.
