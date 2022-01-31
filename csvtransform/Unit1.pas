unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Button6: TButton;
    ClientDataSet1: TClientDataSet;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uCsvTransform;

procedure TForm1.Button1Click(Sender: TObject);
var
  SS: TStringStream;
  OS: TStringStream;
begin
  SS := TStringStream.Create(ListBox1.Items.Text);
  OS := TStringStream.Create;
  try
    with TCsvTransform.Create do
    try
      Transform(CsvToDP, SS, TStream(OS));
    finally
      Free;
    end;

    OS.Position := 0;
    ClientDataSet1.LoadFromStream(OS);
  finally
    SS.Free;
    OS.Free;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  SS: TStringStream;
  OS: TFileStream;
begin
  if not SaveDialog1.Execute then
    exit;
  OS := TFileStream.Create(SaveDialog1.FileName, fmCreate);
  SS := TStringStream.Create;
  try
    ClientDataSet1.SaveToStream(SS, dfXML);
    with TCsvTransform.Create do
    try
      Transform(DPToCsv, SS, TStream(OS));
    finally
      Free;
    end;

  finally
    SS.Free;
    OS.Free;
  end;
end;

end.
