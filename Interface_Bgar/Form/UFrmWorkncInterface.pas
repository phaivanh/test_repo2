unit UFrmWorkncInterface;

{*
  V1.3  traduction
  V1.4  desactivation du log, pour activer il faut crééer la clé de registre de type entier
  HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Sescoi\WorkNC interface\debug_mode = 1
  V1.5  Changement de synjtaxe et ajout de parametre suplémentaire, WorkNCPath
      s'il est défini et s'il existe, MAJ de la tabe Workzone

      Task_id = tâche sélectionnée
      Zonepath = chemin de la zone donné en paramètre
      Description = dernier répertoire dans le chemin de la zone
      Typ = 0 (valeur pour WorkNC)


      workncgettaskid /config
      workncgettaskid  /lang:fra /path:"c:\temp tempo\rude"

  V1.7  Accès à au choix du chardet UTF8 en selectionnant dans la forme de configuration
  V1.8  Connection a la base en UTF8 par défaut si pas de fichier ini
  V1.9  Renommer repertoire Vero SoftWare en Hexagon\WORKPLAN dans ProgramData
*}


interface

uses
  gnugettext,
  CommandLine,
  SescoiFDConX,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uGFunctions,
  cls.usersettings,
  ufrmsettings,
  udbaccess,
  cls.mydate,
  cls.log,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, AdvUtil, Data.DB,
  Vcl.Grids, AdvObj, BaseGrid, AdvGrid, DBAdvGrid, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.CheckLst, AdvPicture,   System.Generics.Defaults,
  Vcl.ExtCtrls, Winapi.ShellAPI, Vcl.Menus,
  uConneXion  ;


type
    TfrmWorkNCInterface = class(TForm)


    pnl1: TPanel;
    pnl3: TPanel;
    datasource2: TDataSource;
    dbdvgrd1: TDBAdvGrid;
    fdqry1: TFDQuery;
    fdqry1assembly_id: TIntegerField;
    fdqry1line_job_id: TIntegerField;
    dtfldfdqry1line_job_delay: TDateField;
    task_id: TIntegerField;
    dtfldfdqry1delay: TDateField;
    fmtbcdfldfdqry1line_hob_qty: TFMTBCDField;
    fmtbcdfldfdqry1task_qty: TFMTBCDField;
    pnl10: TPanel;
    pnl18: TPanel;
    btn1: TButton;
    btn2: TButton;
    pnl19: TPanel;
    lblNbRec: TLabel;
    fdqry1task_description: TWideStringField;
    fdqry1service_code: TWideStringField;
    fdqry1job_code: TWideStringField;
    fdqry1company_code: TWideStringField;
    fdqry1assembly_code: TWideStringField;
    fdqry1line_code: TWideStringField;
    fdqry1assembly_desc: TWideStringField;
    fdqry1line_desc: TWideStringField;
    fdqry1project_desc: TWideStringField;
    GridPanel1: TGridPanel;
    lst_customer: TCheckListBox;
    pnl5: TPanel;
    lbl6: TLabel;
    advpctr2: TAdvPicture;
    lst_job: TCheckListBox;
    pnl6: TPanel;
    lbl7: TLabel;
    advpctr3: TAdvPicture;
    lst_service: TCheckListBox;
    pnl7: TPanel;
    lbl8: TLabel;
    pnl20: TPanel;
    lbl9: TLabel;
    lst_assembly: TCheckListBox;
    pnl21: TPanel;
    lbl10: TLabel;
    lst_delay: TCheckListBox;
    pnlClient: TPanel;
    pnlAffaire: TPanel;
    pnlPrestation: TPanel;
    pnlEnsemble: TPanel;
    pnlDelai: TPanel;
    procedure FilterModified(Sender: TObject);
    procedure ReturnTaskId(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lblNbRecDblClick(Sender: TObject);
    procedure mniExplorer1Click(Sender: TObject);

  const


    Vers = 'WORKNC Interface V1.9';

    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
      FDateList :TDateList;
    { Déclarations privées }
    procedure   ShowSettingsForm();
    function    LicensesOK():boolean;
    procedure   InitLog();
    procedure   ExecuteTreatment();
    procedure   UpdateCaption();
    procedure   InitEnv();
    procedure   RetrieveData();
    procedure   RefreshData();

    function  CreateStringCondition(Lst : TCheckListBox; Fieldname : string): string;
    function  CreateDateSQLCondition(): string;
    function  CompleteCondition(CondCmul, cond : string) : string;
    procedure FillSearchListBoxStr( DataSet : TFDQuery);
    procedure FillSearchListBoxDate( DataSet : TFDQuery);

    procedure FreeObjects();

    var
      FExecuteCde       : string;
      FLogFolder        : string;

  public
    { Déclarations publiques }
  end;

var
  frmWorkNCInterface: TfrmWorkNCInterface;
  FLog : clLog;

implementation

{$R *.dfm}

procedure TfrmWorkNCInterface.ReturnTaskId(Sender: TObject);
begin
  if fdqry1.RecordCount > 0 then
  begin
    fdqry1.First;
    fdqry1.MoveBy(dbdvgrd1.Row-1);
    ExitCode := fdqry1.FieldByName('task_id').AsInteger  ;

    UpdateWorkZone(GFDConX, ExitCode, CommandLine1.WorkNCZonePath);

    Close;
  end;
end;

procedure TfrmWorkNCInterface.btn2Click(Sender: TObject);
begin
  close;
end;

function TfrmWorkNCInterface.CompleteCondition(CondCmul, cond: string): string;
begin
  if CondCmul = '' then
  begin
    RESULT := cond;
  end
  else begin
    if cond <> '' then
    begin
      RESULT := CondCmul + ' and ' + cond;
    end
    else begin
      Result := CondCmul;
    end;
  end;
end;


function TfrmWorkNCInterface.CreateDateSQLCondition: string;
var
  i : integer;
  Criteria : string;
  MyFormatSettings : TFormatSettings;
  NUllDateSelected : Boolean;

begin
  NUllDateSelected := False;
  MyFormatSettings := TFormatSettings.Create;
  MyFormatSettings.TimeSeparator :=  ':';

  Criteria := '';
  for i := 0 to lst_delay.Count -1 do
  begin
      if lst_delay.Checked[i] then
      begin
        if lst_delay.Items[i] <> '' then
        begin
          if Criteria = '' then
          begin
            Criteria := QuotedStr(DateToStr(TElementDate (lst_delay.Items.Objects[i]).Mydate, MyFormatSettings)) ;
          end
          else begin
            Criteria := Criteria + ',' + QuotedStr(DateToStr(TElementDate (lst_delay.Items.Objects[i]).Mydate, MyFormatSettings));
          end;
        end
        else begin
            NUllDateSelected := True;
        end;
      end;
  end;

  if Criteria <> '' then
  begin
      Criteria := ' delay in ( '+ Criteria + ')';
  end;
  if NUllDateSelected then
  begin
    if Criteria <> '' then
    begin
       Criteria := '( delay is null or ' + Criteria + ')';
    end
    else begin
       Criteria := ' delay is null ';
    end;
  end;

  Result := Criteria;
end;

function TfrmWorkNCInterface.CreateStringCondition(Lst: TCheckListBox;
  Fieldname: string): string;
var
  i : integer;
  Criteria : string;
begin
  Criteria := '';
  for i := 0 to Lst.Count -1 do
    begin
      if Lst.Checked[i] then
      begin
        if Criteria = '' then
        begin
          Criteria := quotedstr(Lst.Items[i]);
        end
        else begin
          Criteria := Criteria + ',' + QuotedStr(Lst.Items[i]);
        end;
      end;
    end;

    if Criteria <> '' then
    begin
      Criteria := Fieldname + ' in ('+ Criteria + ')'
    end;
    Result := Criteria;
end;

procedure TfrmWorkNCInterface.ExecuteTreatment;
begin
      InitEnv( );
      Application.ProcessMessages;
      UpdateCaption();
      RetrieveData;
      FillSearchListBoxStr(fdqry1);
      FillSearchListBoxDate(fdqry1);
end;

procedure TfrmWorkNCInterface.FillSearchListBoxDate(DataSet: TFDQuery);
var

  Mydate : Tdate;
  index : Integer;
  ElementDate : TElementDate;

begin
    Dataset.First;
    while not (Dataset.Eof) do
    begin
        Mydate := Dataset.FieldByName('delay').AsDateTime;

        ElementDate  := TElementDate.Create(Mydate);
        index := FDateList.Exists(ElementDate);
        if (index = -1) then
        begin
          FDateList.Add(ElementDate);
        end
        else begin
          ElementDate.Free;
        end;
        Dataset.Next;
    end;

   FDateList.Sort(TComparer<TElementDate>.Construct(
       function (const L, R: TElementDAte): integer
       begin
         if L.mydate  =R.Mydate  then
          Result:=0
         else
         if L.MyDate < R.Mydate then
          Result:=-1
         else
          Result:=1;
       end ));

    for ElementDate in FDateList  do
    begin
       if ElementDate.IsNull then
       begin
          lst_delay.AddItem('', ElementDate );
       end
       else begin
          lst_delay.AddItem(ElementDate.MydateStrg, ElementDate );
       end;
    end;
end;

procedure TfrmWorkNCInterface.FillSearchListBoxStr(DataSet: TFDQuery);
var
  Val : string;
  index : Integer;
  ValueList1, ValueList2, ValueList3, ValueList4 : TStringList;
//  Stopwatch1: TStopwatch;

begin
    ValueList1 := TStringList.Create;
    ValueList2 := TStringList.Create;
    ValueList3 := TStringList.Create;
    ValueList4 := TStringList.Create;

    Dataset.First;
    while not (Dataset.Eof) do
    begin
        Val := Dataset.FieldByName('job_code').AsString ;
        index := ValueList1.IndexOf(Val);
        if (index = -1) then
        begin
          ValueList1.Add(Val);
        end;

        Val := Dataset.FieldByName('company_code').AsString ;
        index := ValueList2.IndexOf(Val);
        if (index = -1) then
        begin
          ValueList2.Add(Val);
        end;

        Val := Dataset.FieldByName('service_code').AsString ;
        index := ValueList3.IndexOf(Val);
        if (index = -1) then
        begin
          ValueList3.Add(Val);
        end;

        Val := Dataset.FieldByName('assembly_code').AsString ;
        index := ValueList4.IndexOf(Val);
        if (index = -1) then
        begin
          ValueList4.Add(Val);
        end;

        Dataset.Next;
    end;

    ValueList1.Sorted := True;
    ValueList1.Sort;
    ValueList2.Sorted := True;
    ValueList2.Sort;
    ValueList3.Sorted := True;
    ValueList3.Sort;
    ValueList4.Sorted := True;
    ValueList4.Sort;

    lst_job.Items := ValueList1;
    lst_customer.Items := ValueList2;
    lst_service.Items := ValueList3;
    lst_assembly.Items := ValueList4;

    ValueList1.Free;
    ValueList2.Free;
    ValueList3.Free;
    ValueList4.Free;

end;

procedure TfrmWorkNCInterface.FormActivate(Sender: TObject);
VAR
FCommonFolder : string;

begin
    If not GetWPCommonFolder(SYS_COMMON_APPDATA, 'Vero Software', 'WorkPLAN Solutions', 'WorkNC Interface',FCommonFolder) then showmessage(Format(_('Not enable to access common data folder : %s'),[FCommonFolder]));

    If Connect(GUserSettings.Host, GUserSettings.Port, GUserSettings.Database, GUserSettings.Charset)  then
    begin

        InitLog();
        fdqry1.Connection := GFDConX;
        FDateList := TDateList.Create;
        ExitCode := -99;

        if CommandLine1.ConfigMode  then
        begin
            ShowSettingsForm();
            Application.Terminate;
        end
        else begin
            if LicensesOK() then
            begin
                ExecuteTreatment();
            end;
        end;
    end
    else begin
        InitLog();
        ExitCode := -1;
        ShowSettingsForm();
        Application.Terminate;
    end;
end;



procedure TfrmWorkNCInterface.FormCreate(Sender: TObject);
begin
  TranslateComponent(Self);
  lblNbRec.Caption := _('Recherche des taches dans les projets WPS en cours ...');
  UpdateCaption();
end;

procedure TfrmWorkNCInterface.FormDestroy(Sender: TObject);
begin

  FLog.write('Return value : ' + IntToStr(ExitCode) );
  FreeObjects;
end;

procedure TfrmWorkNCInterface.FreeObjects;
begin
  FreeAndNil(GUserSettings);
  Disconnect();
  FreeAndNil(FLog);
end;


procedure TfrmWorkNCInterface.InitEnv;
begin
    FLogFolder := GetMyDataLogFolder(GFDConX);
    if not DirectoryExists(FLogFolder) then FLogFolder := GUserSettings.LocalLogFolder;
end;

procedure TfrmWorkNCInterface.InitLog();
var
LogFileName : string;
i : Integer;
cmd : string;

begin
    if  GFDConX.Connected then
    begin
      FLogFolder := GetMyDataLogFolder(GFDConX);
      ForceDirectories(FLogFolder);
      if not DirectoryExists(FLogFolder) then FLogFolder := GUserSettings.LocalLogFolder;
    end
    else
    begin
      if not DirectoryExists(FLogFolder) then FLogFolder := GUserSettings.LocalLogFolder;
    end;
    LogFileName := 'WorkNCGetTaskId';
    LogFileName := formatDateTime('yyyy-mm-dd_hh_mm_ss',now) +'['+ LogFileName +']'+ GetLocalComputerName + '.log' ;
    if not DirectoryExists(FLogFolder) then ForceDirectories(FLogFolder);
    FLog := clLog.create(FLogFolder, LogFileName);
    FLog.write('Start WorkNC interface');


  cmd := '';
  for i := 0 to ParamCount do
  begin
    if cmd = '' then
      cmd := ParamStr(i)
    else cmd := cmd +' ' +ParamStr(i);
  end;

  FLog.write('Command line : ' + cmd);

end;



procedure TfrmWorkNCInterface.lblNbRecDblClick(Sender: TObject);
begin
    ShellExecute(frmWorkNCInterface.Handle, 'open', 'notepad.exe', PWideChar(FLog.LogName), Nil, SW_ShowNormal);
end;

function TfrmWorkNCInterface.LicensesOK: boolean;
begin
     Result := true;
end;

procedure TfrmWorkNCInterface.mniExplorer1Click(Sender: TObject);
begin
    ShellExecute(Application.Handle, 'open', 'explorer.exe',
    PChar(FLogFolder ), nil, SW_NORMAL);
end;

procedure TfrmWorkNCInterface.FilterModified(Sender: TObject);
begin
    Refreshdata;
end;

procedure TfrmWorkNCInterface.RefreshData;
var
  ConditionGen : string;
  Condition1 : string;
  Condition2 : string;
  Condition3 : string;
  Condition4 : string;
  Condition5 : string;
  showfiltre : string;

begin
  ConditionGen := '';
  Condition1 := CreateStringCondition(lst_job, 'job_code');
  Condition2 := CreateStringCondition(lst_customer,'company_code' );
  Condition3 := CreateStringCondition(lst_service,'service_code' );
  Condition4 := CreateStringCondition(lst_assembly,'assembly_code' );
  Condition5 := CreateDateSQLCondition;

  ConditionGen := CompleteCondition(ConditionGen, Condition1);
  ConditionGen := CompleteCondition(ConditionGen, Condition2);
  ConditionGen := CompleteCondition(ConditionGen, Condition3);
  ConditionGen := CompleteCondition(ConditionGen, Condition4);
  ConditionGen := CompleteCondition(ConditionGen, Condition5);

  dbdvgrd1.BeginUpdate;
  try
    dbdvgrd1.PageMode := True;
  finally
    dbdvgrd1.EndUpdate;
  end;

  fdqry1.Filter := ConditionGen;
  fdqry1.Filtered := True;

  dbdvgrd1.PageMode := False ;

  showfiltre := '';

  if Flog.ActiveLog then showfiltre := Format(_('Filter : %s      '), [ ConditionGen]);
    lblNbRec.Caption := showfiltre + Format(_(' %d records'), [ fdqry1.RecordCount ]);
end;

procedure TfrmWorkNCInterface.RetrieveData;
var
  reqsql    :string;
begin

  reqsql := ' SELECT   task.int_id AS task_id '+
            ' ,task.description AS task_description '+
            ' ,service.code AS service_code '+
            ' ,CONCAT(job.code,''.'',index_job.code,''.'',LPAD(line_job.ord,3,''0'')) AS project_desc '+
            ' ,job.code + job.description AS project_desc '+
            ' ,job.code AS job_code '+
            ' ,company.code AS company_code '+
            ' ,job.company_id '+
            ' ,index_job.code AS index_code '+
            ' ,line_job.code AS line_code '+
            ' ,line_job.description AS line_desc '+
            ' ,IF(line_job.qty IS NULL OR line_job.qty = 0, 1, line_job.qty) AS line_job_qty '+
            ' ,IFNULL(assembly.code,'''') AS assembly_code '+
            ' ,assembly.description AS assembly_desc '+
            ' ,task.line_job_id AS line_job_id '+
            ' ,task.assembly_id AS assembly_id '+
            ' ,unproductive_task '+
            ' ,task.unit_required_qty AS task_qty '+
            ' ,task.typ '+
            ' ,task.service_id '+
            ' ,task.STATUS '+
            ' ,task.forecasted_date AS task_delay '+
            ' ,assembly.need_date AS assembly_delay '+
            ' ,line_job.internal_delay AS line_job_internal_delay '+
            ' ,line_job.DELAY AS line_job_delay '+
            ' ,CAST( IFNULL(assembly.need_date, IFNULL(line_job.internal_delay, line_job.DELAY)) AS DATE ) AS DELAY '+
            ' FROM task '+
            ' INNER JOIN line_job ON line_job.int_id = task.line_job_id '+
            ' INNER JOIN index_job ON index_job.int_id = line_job.index_job_id '+
            ' INNER JOIN job ON job.int_id = job_id '+
            ' LEFT JOIN assembly ON assembly.int_id = task.assembly_id '+
            ' LEFT JOIN company ON company.int_id = job.company_id '+
            ' LEFT JOIN service ON service.int_id = task.service_id '+
            ' WHERE task.int_id > 0 and task.STATUS IN (''2'',''3'') ' +
            ' and service.workzone = 1' ;
  FLog.write('Retrieve clause : ' + reqsql);
  fdqry1.SQL.Text := reqsql;
  fdqry1.Open;

  lblNbRec.Caption := Format(_('%d enregistrements'), [fdqry1.RecordCount]);
end;


procedure TfrmWorkNCInterface.ShowSettingsForm;
begin
  FLog.write('Display setting form ...');
  FrmSettings:=TFrmSettings.Create(Self);
  if FrmSettings.ShowModal=mrOk then
  begin
    UpdateCaption();
  end;
  FreeAndNil(FrmSettings);
end;


procedure TfrmWorkNCInterface.UpdateCaption;
begin
  if UpperCase(GUserSettings.Database) <> 'MYWORKPLAN' then
    Caption:=Format(Vers + '  %s:%d (%s)', [GUserSettings.Host, GUserSettings.Port, GUserSettings.Database])
  else   Caption:=Format(Vers + '  %s:%d', [GUserSettings.Host, GUserSettings.Port])
end;

end.
