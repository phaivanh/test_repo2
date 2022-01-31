object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 277
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 217
    Width = 303
    Height = 13
    Caption = 'if TClientDataSet changed, call MergeChangeLog before saving'
  end
  object Button1: TButton
    Left = 26
    Top = 82
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 26
    Top = 16
    Width = 247
    Height = 60
    ItemHeight = 13
    Items.Strings = (
      'field1:%, field2:$15, field3:@, field4:!, field5:&'
      '1, didier, 19621117, true, 15.5'
      '2, "tom, cabal'#233'", 19971029, false, 30'
      '3, l'#233'a, 19941212, false, 40.62')
    TabOrder = 1
  end
  object Button6: TButton
    Left = 26
    Top = 233
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 2
    OnClick = Button6Click
  end
  object DBGrid1: TDBGrid
    Left = 26
    Top = 113
    Width = 247
    Height = 98
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 34
    Top = 151
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 98
    Top = 151
  end
  object SaveDialog1: TSaveDialog
    FileName = '.\save.csv'
    Filter = 'csv|*.csv'
    Left = 168
    Top = 152
  end
end
