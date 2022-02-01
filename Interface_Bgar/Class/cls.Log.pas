unit cls.Log;


interface

uses  SescoiRegistry ,
    SescoiRegistryKeys,
     Winapi.Windows;

const
  TAB = Chr(9);

type
  clLog = class
  private
  FstrFolder : string;
  FstrLogName : string;
  FFullLogName : string;
  FActiveLog : boolean;

  public
    constructor create(astrFolder, astrExeName : string);
    destructor Destroy();
    procedure write(str : string);

    property LogName:string read FFullLogName;
    property ActiveLog:boolean read FActiveLog;
  end;

implementation

uses SysUtils, Dialogs;

procedure clLog.write(str : string);
var
  strFileName : string;
  Pt : TextFile;

begin
  if FActiveLog then
  begin
      strFileName := IncludeTrailingBackslash(FstrFolder) + FstrLogName;

      try
        AssignFile(Pt, strFileName);
        try

          if not FileExists(strFileName) then
            rewrite(Pt)
          else Append(Pt);
          Writeln(Pt,formatdatetime('hh:nn:ss:zzz',now) + TAB + str);
        finally
          Flush(Pt);
          CloseFile(Pt);
        end;
      except

        on E:Exception do
        begin
          ShowMessage(E.ClassName+' error raised, with message : '+E.Message + ' FILE : ' + strFileName)
        end;
      end;
  end;
end;

constructor clLog.create(astrFolder, astrExeName : string);
begin
  FstrFolder    := IncludeTrailingBackslash(astrFolder);
  FstrLogName   := astrExeName;
  FFullLogName  := FstrFolder + FstrLogName;
  FActiveLog := false;
  FActiveLog := (regReadInteger(HKEY_LOCAL_MACHINE, 'SOFTWARE\Sescoi\WorkNC interface','debug_mode',0) = 1);

  if not DirectoryExists(FstrFolder) then ForceDirectories(FstrFolder);

end;

destructor clLog.Destroy();
begin
  inherited;
end;

end.
