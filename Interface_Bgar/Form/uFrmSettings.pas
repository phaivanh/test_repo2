unit uFrmSettings;

interface

uses
  gnugettext,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  uFrmBase,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  //FireDac
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Phys.MySQL,

  //Sescoi
  SescoiFDConX,

  //Project
  uConneXion,
  cls.UserSettings,
  AdvExplorerTreeview,
  Vcl.Buttons,
  FolderDialog,
  Vcl.ComCtrls,
  //cls.DbUserSettings,
  AdvOfficePager, AdvOfficePagerStylers;

type
  TFrmSettings = class(TFrmBase)
    pnlBottom: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    FolderDialog1: TFolderDialog;
    stat1: TStatusBar;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvOfficePager1: TAdvOfficePager;
    tabExportMatiere: TAdvOfficePage;
    tabConfig: TAdvOfficePage;
    pnlMainConfig: TPanel;
    pnlConnectionDetail: TPanel;
    pnlHost: TPanel;
    lblHost: TLabel;
    edtHost: TEdit;
    pnlPort: TPanel;
    lblPort: TLabel;
    edtPort: TEdit;
    pnlCharset: TPanel;
    lblCharset: TLabel;
    cbbCharset: TComboBox;
    pnl1: TPanel;
    lblDBName: TLabel;
    edtDBName: TEdit;
    pnl_section_Employee: TPanel;
    pnlEmployeeDetail: TPanel;
    pnlEmployeeName: TPanel;
    lblEmployeeName: TLabel;
    cbbEmployeeName: TComboBox;
    pnl17: TPanel;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtDBNameChange(Sender: TObject);
    procedure edtPortChange(Sender: TObject);
    procedure edtHostChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
    FOnCreate:    Boolean;

    procedure LoadUserSettings;
    procedure SaveUserSettings();

    procedure ChangeConXInfo();

    procedure LoadCharset();
    procedure LoadIfConnect();
    procedure LoadEmployeeFromDB();

    function GetEmployeeID():Integer;
    procedure SetEmployeeID(AEmployeeID: Integer);
  public
    { Déclarations publiques }
  end;

var
  FrmSettings: TFrmSettings;

const  //From unit FireDAC.Phys.MySQL;
  S_FD_CharacterSets = 'big5;dec8;cp850;hp8;koi8r;latin1;latin2;swe7;ascii;ujis;' +
    'sjis;cp1251;hebrew;tis620;euckr;koi8u;gb2312;greek;cp1250;gbk;latin5;armscii8;' +
    'cp866;keybcs2;macce;macroman;cp852;latin7;cp1256;cp1257;binary;utf8';

implementation

{$R *.dfm}
{ TFrmSettings }
uses UFrmWorkncInterface;




procedure TFrmSettings.btnOKClick(Sender: TObject);
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.btnOKClick
  Author:    vdupuis
  DateTime:  2015.05.11
-------------------------------------------------------------------------------}
begin
  inherited;
  SaveUserSettings();
end;

procedure TFrmSettings.ChangeConXInfo;
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.ChangeConXInfo
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  if not FOnCreate then
  begin
    Disconnect;

    //btnOK.Enabled:=False;
    cbbEmployeeName.Clear;
  end;
end;

procedure TFrmSettings.edtDBNameChange(Sender: TObject);
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.edtDBNameChange
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  inherited;

  ChangeConXInfo();
end;

procedure TFrmSettings.edtHostChange(Sender: TObject);
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.edtHostChange
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  inherited;

  ChangeConXInfo();
end;

procedure TFrmSettings.edtPortChange(Sender: TObject);
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.edtPortChange
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  inherited;

  ChangeConXInfo();
end;

procedure TFrmSettings.FormActivate(Sender: TObject);
begin
  inherited;
  FrmSettings.Caption := frmWorkNCInterface.Vers + '  Settings' ;

end;

procedure TFrmSettings.FormCreate(Sender: TObject);
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.FormCreate
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  inherited;

  TranslateComponent(Self);

  FOnCreate:=True;
  LoadCharset();

  LoadUserSettings();

  stat1.Panels[0].Text := GUserSettings.IniFilePath;
  FOnCreate:=False;

end;

function TFrmSettings.GetEmployeeID():Integer;
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.GetEmployeeID
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  if cbbEmployeeName.ItemIndex=-1 then
  begin
    Result:=cbbEmployeeName.ItemIndex;
  end
  else
  begin
    Result:=Integer(cbbEmployeeName.Items.Objects[cbbEmployeeName.ItemIndex]);
  end;
end;

procedure TFrmSettings.LoadCharset;
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.LoadCharset
  Author:    vdupuis
  DateTime:  2015.05.21
-------------------------------------------------------------------------------}
begin
  cbbCharset.Items.Delimiter:=';';
  cbbCharset.Items.DelimitedText:=S_FD_CharacterSets;
  cbbCharset.Sorted:=True;
end;

procedure TFrmSettings.LoadEmployeeFromDB;
{ -------------------------------------------------------------------------------
  Procedure: TFrmSettings.LoadEmployee
  Author:    vdupuis
  DateTime:  2015.05.11
  ------------------------------------------------------------------------------- }
var
  Select:       string;
  SCQuery:      TSCQuery;
  i:            Integer;
  Description:  string;
begin
  cbbEmployeeName.Clear;

  Select:='         SELECT -1 AS int_id, '''' AS code, '''' AS last_name, '''' AS first_name FROM users ';
  Select:=Select + 'UNION ';
  Select:=Select + 'SELECT int_id, code, last_name, first_name FROM users ';
  Select:=Select + 'WHERE int_id>0 ';
  Select:=Select + 'ORDER BY code;';

  SCQuery:=GFDConX.Select(Select);

  for i := 0 to SCQuery.RecordCount-1 do
  begin
    Description:=Format('%s - %s %s', [SCQuery.FieldByName('code').AsString, SCQuery.FieldByName('last_name').AsString, SCQuery.FieldByName('first_name').AsString]);

    cbbEmployeeName.AddItem(Description, TObject(SCQuery.FieldByName('int_id').AsInteger));

    SCQuery.Next;
  end;

  SCQuery.Free;
end;

procedure TFrmSettings.LoadIfConnect();
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.LoadIfConnect
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
begin
  if GFDConX.Connected then
  begin
    LoadEmployeeFromDB();
  end;
end;

procedure TFrmSettings.LoadUserSettings;
{ -------------------------------------------------------------------------------
  Procedure: TFrmSettings.LoadUserSettings
  Author:    vdupuis
  DateTime:  2015.05.11
  ------------------------------------------------------------------------------- }
begin
  if GUserSettings.WPSIsInstalled then
  begin
    edtHost.Enabled:=False;
    edtPort.Enabled:=False;
    edtDBName.Enabled:=False;
  end;

  edtHost.Text:=GUserSettings.Host;
  edtPort.Text:=GUserSettings.Port.ToString();
  edtDBName.Text:=GUserSettings.Database;
  cbbCharset.ItemIndex:=cbbCharset.Items.IndexOf(GUserSettings.Charset);
  
end;

procedure TFrmSettings.SaveUserSettings;
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.SaveUserSettings

  DateTime:  2018.06.07
-------------------------------------------------------------------------------}
begin
  GUserSettings.Host:=edtHost.Text;
  GUserSettings.Port:= StrToIntDef(edtPort.Text, CDefaultPort);
  GUserSettings.Database:=edtDBName.Text;
  GUserSettings.Charset:=cbbCharset.Text;

  GUserSettings.Save();

end;

procedure TFrmSettings.SetEmployeeID(AEmployeeID: Integer);
{-------------------------------------------------------------------------------
  Procedure: TFrmSettings.SetEmployeeID
  Author:    vdupuis
  DateTime:  2015.05.12
-------------------------------------------------------------------------------}
var
  i:      Integer;
begin
  for i := 0 to cbbEmployeeName.Items.Count-1 do
  begin
    if Integer(cbbEmployeeName.Items.Objects[i])=AEmployeeID then
    begin
      cbbEmployeeName.ItemIndex:=i;
      Break;
    end;
  end;
end;

end.
