unit uFrmBase;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls;

type
  TFrmBase = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}

procedure TFrmBase.FormCreate(Sender: TObject);
{ -------------------------------------------------------------------------------
  Procedure: TFrmBase.FormCreate
  Author:    vdupuis
  DateTime:  2015.05.11
  ------------------------------------------------------------------------------- }
var
  i:          Integer;
  Component:  TComponent;
begin
  // Caption:='AutoBom';
  for i:=0 to ComponentCount-1 do
  begin
    Component:=Components[i];
    if Component is TPanel then
    begin
      if Component.Tag=1 then
      begin
        (Component as TPanel).Color := $00D7D7D7;
      end
      else
      begin
        (Component as TPanel).Color := clBtnFace;
      end;
    end;
  end;

end;

end.
