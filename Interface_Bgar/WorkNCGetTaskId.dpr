program WorkNCGetTaskId;

uses
  gnugettext,
  Vcl.Forms,
  UFrmWorkncInterface in 'Form\UFrmWorkncInterface.pas' {Form1},
  uFrmSettings in 'Form\uFrmSettings.pas' {FrmSettings},
  uFrmBase in 'Form\Generics\uFrmBase.pas' {FrmBase},
  UGlobal in 'include\UGlobal.pas',
  uGFunctions in '..\MyLIB\uGFunctions.pas',
  cls.UserSettings in 'Class\cls.UserSettings.pas',
  cls.MyDate in 'Class\cls.MyDate.pas',
  cls.Log in 'Class\cls.Log.pas',
  System.SysUtils,
  Vcl.Dialogs,
  Data.DB,
  Vcl.ExtCtrls,
  vcl.Controls,
  vcl.Graphics,
  SescoiRegistry in 'Lib\SescoiRegistry.pas',
  SescoiRegistryKeys in 'Lib\SescoiRegistryKeys.pas',
  CommandLine in 'Lib\CommandLine.pas',
  GpCommandLineParser in 'Lib\GpCommandLineParser.pas',
  UDbAccess in 'Class\UDbAccess.pas';

{$R *.res}

procedure GlobalIgnore();
{-------------------------------------------------------------------------------
  Procedure: GlobalIgnore
  Author:    vdupuis
  DateTime:  2016.08.23
-------------------------------------------------------------------------------}
begin
  // DefaultInstance.DebugLogToFile('c:\dxgettext-log.txt',True);
  { VCL, important ones }
  // TP_GlobalIgnoreClassProperty(TAction,'Category');
  TP_GlobalIgnoreClassProperty(TControl, 'HelpKeyword');
  TP_GlobalIgnoreClassProperty(TNotebook, 'Pages');
  { VCL, not so important }
  TP_GlobalIgnoreClassProperty(TControl, 'ImeName');
  TP_GlobalIgnoreClass(TFont);
  { Database (DB unit) }
  TP_GlobalIgnoreClassProperty(TField, 'DefaultExpression');
  TP_GlobalIgnoreClassProperty(TField, 'FieldName');
  TP_GlobalIgnoreClassProperty(TField, 'KeyFields');
  TP_GlobalIgnoreClassProperty(TField, 'DisplayName');
  TP_GlobalIgnoreClassProperty(TField, 'LookupKeyFields');
  TP_GlobalIgnoreClassProperty(TField, 'LookupResultField');
  TP_GlobalIgnoreClassProperty(TField, 'Origin');
  TP_GlobalIgnoreClass(TParam);
  TP_GlobalIgnoreClassProperty(TFieldDef, 'Name');
  { MIDAS/Datasnap }
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'CommandText');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'Filename');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'Filter');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'IndexFieldnames');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'IndexName');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'MasterFields');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'Params');
//  TP_GlobalIgnoreClassProperty(TClientDataSet, 'ProviderName');
  { Database controls }
//  TP_GlobalIgnoreClassProperty(TDBComboBox, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBCheckBox, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBEdit, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBImage, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBListBox, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBLookupControl, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBLookupControl, 'KeyField');
//  TP_GlobalIgnoreClassProperty(TDBLookupControl, 'ListField');
//  TP_GlobalIgnoreClassProperty(TDBMemo, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBRadioGroup, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBRichEdit, 'DataField');
//  TP_GlobalIgnoreClassProperty(TDBText, 'DataField');
  { ADO components }
//  TP_GlobalIgnoreClass(TADOConnection);
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'CommandText');
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'ConnectionString');
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'DatasetField');
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'Filter');
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'IndexFieldNames');
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'IndexName');
//  TP_GlobalIgnoreClassProperty(TADOQuery, 'MasterFields');
//  TP_GlobalIgnoreClassProperty(TADOTable, 'IndexFieldNames');
//  TP_GlobalIgnoreClassProperty(TADOTable, 'IndexName');
//  TP_GlobalIgnoreClassProperty(TADOTable, 'MasterFields');
//  TP_GlobalIgnoreClassProperty(TADOTable, 'TableName');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'CommandText');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'ConnectionString');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'DatasetField');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'Filter');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'IndexFieldNames');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'IndexName');
//  TP_GlobalIgnoreClassProperty(TADODataSet, 'MasterFields');
  { TMS Components }
//  TP_GlobalIgnoreClass(TDBAdvStringGrid);
  // TMS Software TAdvStringGrid
  { ActiveX stuff }
  // TP_GlobalIgnoreClass (TWebBrowser);
  { Turbopower Orpheus }
  // TP_GlobalIgnoreClassProperty(TO32FlexEdit,'About');
  // TP_GlobalIgnoreClassProperty(TO32FlexEdit,'Validation');
  // TP_GlobalIgnoreClassProperty(TOvcTimeEdit,'About');
  // TP_GlobalIgnoreClassProperty(TOvcTimeEdit,'NowString');
  { Turbopower Essentials }
  // TP_GlobalIgnoreClassProperty(TEsDateEdit,'TodayString');
end;


function ConvertCodeLang(Lang: string): string;

var NewCode : string;

begin

  if (UpperCase(Lang)= uppercase('ang')) then NewCode := 'en' // Anglais
  else if (UpperCase(Lang)= uppercase('fra')) then NewCode := 'fr' // Français
  else if (UpperCase(Lang)= uppercase('all')) then NewCode := 'de' // Deutsch

//  else if (UpperCase(Lang)= uppercase('esp')) then NewCode := '' // Espanol
//  else if (UpperCase(Lang)= uppercase('por')) then NewCode := '' // Portugues
//  else if (UpperCase(Lang)= uppercase('ita')) then NewCode := '' // Italiano
//  else if (UpperCase(Lang)= uppercase('jpn')) then NewCode := '' // Japanese
//  else if (UpperCase(Lang)= uppercase('cze')) then NewCode := '' // Czech
//  else if (UpperCase(Lang)= uppercase('sv')) then NewCode := '' // Sweden
//  else if (UpperCase(Lang)= uppercase('chi')) then NewCode := '' // Chinese
//  else if (UpperCase(Lang)= uppercase('tai')) then NewCode := '' // Taiwanese
//  else if (UpperCase(Lang)= uppercase('kor')) then NewCode := '' // Korean
//  else if (UpperCase(Lang)= uppercase('ptb')) then NewCode := '' // Brasilan
//  else if (UpperCase(Lang)= uppercase('nl')) then NewCode := '' // Dutch//
//  else if (UpperCase(Lang)= uppercase('pl')) then NewCode := '' // Polish
//  else if (UpperCase(Lang)= uppercase('ru')) then NewCode := '' // Russian
//  else if (UpperCase(Lang)= uppercase('svk')) then NewCode := '' // Slovak
//  else if (UpperCase(Lang)= uppercase('tr')) then NewCode := '' // Turkish
//  else if (UpperCase(Lang)= uppercase('fi')) then NewCode := '' // Finish
//  else if (UpperCase(Lang)= uppercase('hu')) then NewCode := '' // Hungarian

else  NewCode := 'en'; // Lang defaut anglais

Result := NewCode;
end;

procedure ShowParam();
var
  cmd : string;
  i : Integer;
begin
  for i := 0 to ParamCount do
    ShowMessage('Parameter '+IntToStr(i)+' = '+ParamStr(i));
end;


function CheckSyntax(var lang : string) : boolean;
var par1, par2 : string;
syntaxok : boolean;


begin

  par1 := UpperCase(Trim(ParamStr(1)));
  par2 := UpperCase(Trim(ParamStr(2)));

  lang := ConvertCodeLang('lang par deault');
  syntaxok := FALSE;


   CommandLine1 := TCommandLine.Create( ) ;
   try
    if not CommandLineParser.Parse( CommandLine1 ) then
    begin
        ShowMessage(_('Parametres incorrects ! Syntaxe : WorkNCGetTaskId [/config]  OU WorkNCGetTaskId /lang:codelang /path:"d:\temp"' ));
    end
    else
    begin
      try
	    // Fonction pour traitement ici !
        syntaxok := true;
        CommandLine1.LangCode :=  ConvertCodeLang(CommandLine1.LangCode) ;
      except
        on E: Exception do
        begin
          Writeln( E.ClassName, ': ', E.Message );
        end;
      end;
    end;
  finally
    //CommandLine1.Free;
  end;

  Result := syntaxok;

end;

Var FLang : string;
    SyntaxOk : boolean;
    s : string;
begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //ShowParam;
  SyntaxOk := CheckSyntax(FLang) ;

  GlobalIgnore();
  UseLanguage(CommandLine1.LangCode);
  TranslateComponent(Application);

  if SyntaxOk then
  begin
    Application.CreateForm(TfrmWorkNCInterface, frmWorkNCInterface);
  Application.Run;
    //CommandLine1.Free;
    FreeAndNil(CommandLine1);
  end;

end.
