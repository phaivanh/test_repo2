unit UDbAccess;

interface

uses   SescoiFDConX,
  System.SysUtils,
  Vcl.Dialogs,
  classes;

const
  ErrorId = -99;

type
  TCreateTask = record
      FDConX          : TFDConX;
      LineJobId       : Integer;
      AssemblyId      : Integer;
      ServiceId       : Integer;
      OpDescription   :string;
      ComponentId     : integer;
      Weight : Double;
      UnitId     : integer;
      Density : Double;
  end;

  TComponentInfos = record
    ComponentId   : Integer;
    ComponentDesc : string ;
    ServiceId     : Integer;
    UnitId        : Integer;
    Density       : double;
  end;


    function GetServiceId(FDConX : TFDConX; ServiceCode : string; DefaultValue : integer) : Integer;
    procedure GetServiceInfos(FDConX : TFDConX; ServiceCode : string; var ServiceId : integer ; var ServiceDesc  : string );
    function  GetIntId(FDConX : TFDConX; TableName : string):integer;
    function FormatDecimalWithPoint(d:double):string;
    function CreateSqlList(str: string): string;
    function GetComponentCode(FDConX : TFDConX; ComponentId : integer; DefaultValue : string) : string;
    function GetMyDataLogFolder(FDConX : TFDConX) : string;
    procedure UpdateWorkZone(FDConX : TFDConX; TaskId : Integer; WorkZonePath: string);
    function Test(FDConX : TFDConX; RawMaterial, Thickness: string): Integer;

implementation
uses cls.UserSettings;


procedure UpdateWorkZone(FDConX : TFDConX; TaskId : Integer; WorkZonePath: string);
var reqsql : string;
    WorkzoneId : integer;
    DBPath, Desc : string;
    SL: TStringList;

begin

  if (trim(WorkZonePath)<> '') and (Directoryexists(WorkZonePath))  then
  begin
     // on recupère le dernier repertoire en tant que description de la Workzone
      SL := TStringList.Create;
      if pos('/', WorkZonePath) > 0 then
        SL.Text := StringReplace(WorkZonePath, '/', #13#10, [rfReplaceAll])
      else SL.Text := StringReplace(WorkZonePath, '\', #13#10, [rfReplaceAll]);
      Desc := SL[SL.Count - 1 ];
      SL.Free;
      // on regarde s'il y a deja un enregistrement dans workzone

      DBPath := stringreplace(WorkZonePath, '\', '\\',[rfReplaceAll, rfIgnoreCase]);

      ReqSql := format('SELECT int_id from workzone where task_id= %d and zonepath = %s and typ = 0',[TaskId, quotedstr(DBPath) ]);
      WorkzoneId := FDConX.Select(Reqsql, -99);
      if WorkzoneId = -99 then
      begin
        WorkzoneId := GetIntId(FDConX,'Workzone');

        reqsql := Format('insert into workzone (int_id, description, zonepath, task_id, typ) values(%d, %s, %s, %d, %d)',
                [WorkzoneId,quotedstr(Desc), quotedstr(DBPath), TaskId, 0 ]);
        FDConX.Update(reqsql);
      end;
  end;
end;

function Test(FDConX : TFDConX; RawMaterial, Thickness: string): Integer;
var
  Reqsql, Msg, ChoosenComponentCode,ComponentList : string;
  NbComponent, ComponentId : integer;
  SqlSet : TSCQuery;

begin
  // on regarde si larticle trouve a partir de la matiere et de l'épaisseur est unique
  ReqSql := format('SELECT count(*) from component where material= %s and thickness = %s ',[quotedstr(RawMaterial), Thickness ]);
  NbComponent := FDConX.Select(Reqsql, 0);

  ReqSql := format('SELECT int_id from component where material= %s and thickness = %s ',[quotedstr(RawMaterial), Thickness ]);
  ComponentId := FDConX.Select(Reqsql, -99);

  if NbComponent > 1 then begin
      ReqSql := format('SELECT int_id, code from component where material= %s and thickness = %s ',[quotedstr(RawMaterial), Thickness ]);
      SqlSet := FDConX.Select(Reqsql);
      ComponentList := '';
      try
        SqlSet.First;
        while not (SqlSet.Eof) do
        begin
            if  SqlSet.FieldByName('int_id').Asinteger = ComponentId then  ChoosenComponentCode := SqlSet.FieldByName('code').Asstring;

            if ComponentList = '' then
              ComponentList :=  quotedstr(SqlSet.FieldByName('code').Asstring)
              else   ComponentList := ComponentList + ', '+ quotedstr(SqlSet.FieldByName('code').Asstring);
              SqlSet.Next;
        end;
      finally
        SqlSet.Free;
      end;
       Msg := format('Attention, il existe %d articles de matière %s  , épaisseur %s mm :'+ Chr(13) +'- Liste des articles : %s'+Chr(13)+'- Article sélectionné : %s',[NbComponent, quotedstr(RawMaterial), Thickness,ComponentList, quotedstr(ChoosenComponentCode)]);
       ShowMessage(Msg);
  end;
  Result := ComponentId;
end;


function CreateSqlList(str: string): string;
{-------------------------------------------------------------------------------
  Procedure: TExportJob.CreateSqlList
  Author:    pthongsoum
  DateTime:  2015.05.28
-------------------------------------------------------------------------------}
var
  ServiceList : string;

begin
  ServiceList := Trim(str);
  ServiceList := StringReplace(ServiceList,', ',',',[rfReplaceAll]) ;
  ServiceList := StringReplace(ServiceList,' ,',',',[rfReplaceAll]) ;
  Result := ''''+StringReplace(ServiceList,',',''',''',[rfReplaceAll])+ '''' ;
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
  Result:=Trim(Format('%g',[d], setting));
end;




function  GetIntId(FDConX : TFDConX; TableName : string):integer;
var
  Reqsql : string;

begin
  Reqsql := Format('select Get_Int_id(%s)',[QuotedStr(TableName)]);
  Result := FDConX.Select(Reqsql, Errorid);
end;



{-------------------------------------------------------------------------------
  Procedure: GetComponentCode
  Author:    pthongsoum
  DateTime:  2018.03.01
-------------------------------------------------------------------------------}

function GetMyDataLogFolder(FDConX : TFDConX) : string;
var
  Reqsql : string;

begin
  Reqsql := 'select str from user_parameter where users_id = 0 and par_id = 128' ;
  Result := FDConX.Select(Reqsql, '');
  if Result <> '' then Result := IncludeTrailingBackslash(Result) + 'log\interface WorkNC\log';
end;

{-------------------------------------------------------------------------------
  Procedure: GetComponentCode
  Author:    pthongsoum
  DateTime:  2018.03.01
-------------------------------------------------------------------------------}

function GetComponentCode(FDConX : TFDConX; ComponentId : integer; DefaultValue : string) : string;
var
  Reqsql : string;

begin
  Reqsql := 'select code from component where int_id =' + IntToStr(ComponentId);
  Result := FDConX.Select(Reqsql, DefaultValue);
end;


{-------------------------------------------------------------------------------
  Procedure: GetServiceId
  Author:    pthongsoum
  DateTime:  2015.03.09
-------------------------------------------------------------------------------}
function GetServiceId(FDConX : TFDConX; ServiceCode : string ; DefaultValue : integer) : Integer;

var
  Reqsql : string;

begin
  Reqsql := 'select int_id from service where code =' + QuotedStr(ServiceCode);
  Result := FDConX.Select(Reqsql, DefaultValue);
end;


procedure GetServiceInfos(FDConX : TFDConX; ServiceCode: string; var ServiceId: integer; var ServiceDesc: string);
{-------------------------------------------------------------------------------
  Procedure: GetServiceInfos
  Author:    pthongsoum
  DateTime:  2015.10.06
-------------------------------------------------------------------------------}
var
SqlSet : TSCQuery;
Reqsql : string;

begin
      ServiceId     := -1;
      ServiceDesc   := '';

      Reqsql := 'select int_id, code, description from service where code =' + QuotedStr(ServiceCode);
      SqlSet := FDConX.Select(Reqsql);
      try
        if SqlSet.RecordCount > 0 then
        begin
          SqlSet.First;
          ServiceId         := SqlSet.FieldByName('int_id').AsInteger;
          ServiceDesc       := SqlSet.FieldByName('description').AsString;
        end;
      finally
        SqlSet.Free;
      end;
end;

end.
