unit uDisplayMessage;

interface

uses
  Vcl.Forms,
  Vcl.Dialogs,
  System.SysUtils,
  Winapi.Windows,
  //project
  uTranslations;

  procedure DisplayMessage(ATitle: string; ADescription: string; AMainIcon: TTaskDialogIcon);

implementation

procedure DisplayMessageVistaUp(ATitle: string; ADescription: string; AMainIcon: TTaskDialogIcon);
{-------------------------------------------------------------------------------
  Procedure: DisplayMessage
  Author:    vdupuis
  DateTime:  2015.05.13
-------------------------------------------------------------------------------}
var
  {$WARN SYMBOL_PLATFORM OFF}
  TaskDialog:   TTaskDialog;
  {$WARN SYMBOL_PLATFORM ON}
begin
  {$WARN SYMBOL_PLATFORM OFF}
  TaskDialog:=TTaskDialog.Create(Application);
  TaskDialog.Caption:=Application.Title;
  TaskDialog.Title:=_(ATitle);
  TaskDialog.Text:=_(ADescription);
  TaskDialog.CommonButtons:=[tcbOK];
  TaskDialog.MainIcon:=AMainIcon;
  TaskDialog.Execute;
  TaskDialog.Free;
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure DisplayMessageXPDown(ATitle: string; ADescription: string; AMainIcon: TTaskDialogIcon);
{-------------------------------------------------------------------------------
  Procedure: DisplayMessage
  Author:    vdupuis
  DateTime:  2015.05.13
-------------------------------------------------------------------------------}
var
  ICON_NB:      ShortInt;
begin
  case AMainIcon of
    tdiWarning: ICON_NB:=MB_ICONWARNING;
    tdiError: ICON_NB:=MB_ICONERROR;
  else
    ICON_NB:=MB_ICONINFORMATION;
  end;
  Application.MessageBox(PWideChar(ADescription), PWideChar(Application.Title), MB_OK + ICON_NB);
end;

procedure DisplayMessage(ATitle: string; ADescription: string; AMainIcon: TTaskDialogIcon);
{-------------------------------------------------------------------------------
  Procedure: DisplayMessage
  Author:    vdupuis
  DateTime:  2015.05.13
-------------------------------------------------------------------------------}
begin
  if TOSVersion.Major>=6 then
  begin
    DisplayMessageVistaUp(ATitle, ADescription, AMainIcon);
  end
  else
  begin
    DisplayMessageXPDown(ATitle, ADescription, AMainIcon);
  end;
end;

end.
