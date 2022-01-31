{***********************************************************
 Usefull when needing to work with .csv file using a TClientDataSet

 Author: Didier Cabalé
         'Bellefont'
         31800 Saint-Gaudens, France
         tél: +33 (0)5 61 89 72 92
         e-mail: didier.cabale+delphi@gmail.com
         web-page: http://didier.cabale.free.fr/delphi.htm

 version 1.1: bug fix when reading field size
 version 1.2: bug fix when writing Null NodeValue
 version 1.3: bug fix when writing several times to the stream when TStreamWriter was not closed
************************************************************}

unit uCsvTransform;

interface

uses
  System.Classes;

type
  TTransformationDirection = (CsvToDP, DPToCsv);

  TCsvTransform = class(TObject)
  private
    function GetResourceString(const ResName: string): AnsiString;
    procedure TransformToDP(const SS: TStream; out OS: TStringStream);
    procedure TransformToCsv(const SS: TStringStream; out OS: TStream);
  public
    constructor Create;
    procedure Transform(const TD: TTransformationDirection; const SS: TStream; out OS: TStream);
  published
  end;

implementation

{$R 'ResourceString.res' 'ResourceString.rc'}

uses
  System.SysUtils
  , Xml.XMLIntf, Xml.XMLDoc
  , System.Variants;

{ TCsvTransform }

constructor TCsvTransform.Create;
begin
  inherited Create;
//  FormatSettings := TFormatSettings.Create(); //as a record, no need to free
  FormatSettings.DecimalSeparator := '.';
end;

function TCsvTransform.GetResourceString(const ResName: string): AnsiString;
begin
  with TResourceStream.Create(HInstance, ResName, 'text') do
    try
      SetLength(result, Size);
      Read(result[1], Size);
    finally
      Free;
    end;
end;

procedure TCsvTransform.Transform(const TD: TTransformationDirection;
  const SS: TStream; out OS: TStream);
begin
  case TD of
    CsvToDP: TransformToDP(SS, TStringStream(OS));
    DPToCsv: TransformToCsv(TStringStream(SS), OS);
  end;
end;

procedure TCsvTransform.TransformToCsv(const SS: TStringStream;
  out OS: TStream);

  function GetFieldType(const FieldType: string): string;
  begin
    if FieldType = 'string' then
      result := '$'
    else
    if FieldType = 'boolean' then
      result := '!'
    else
    if FieldType = 'i4' then
      result := '%'
    else
    if FieldType = 'r4' then
      result := '&'
    else
    if FieldType = 'dateTime' then
      result := '@'
    else
      result := '$';
  end;

  function GetFieldSize(const aNode: IXMLNode): string;
  begin
     if aNode.AttributeNodes.FindNode('WIDTH') <> nil then
        result := aNode.AttributeNodes.FindNode('WIDTH').NodeValue
     else
        result := '';
  end;

var
  XMLDoc: IXMLDocument;
  ndeRoot,
  ndeMetaData,
  ndeFields,
  ndeRows: IXMLNode;
  SLFields: TStringList;
  SLRecord: TStringList;
  SW: TStreamWriter;

  procedure WriteFields;
  var
    ndeField: IXMLNode;
    i: Integer;
  begin
    SLFields.Clear;
    for i := 0 to ndeFields.ChildNodes.Count -1 do
    begin
      ndeField := ndeFields.ChildNodes[i];
      SLFields.Append(Format('%s:%s%s', [ndeField.AttributeNodes[0].NodeValue,
                                        GetFieldType(ndeField.AttributeNodes[1].NodeValue),
                                        GetFieldSize(ndeField)]
                                        ));
    end;
    SW.WriteLine(SLFields.CommaText);
    { Flush the contents of the writer to the stream. }
    SW.Flush;
  end;

  procedure WriteRecords;
  var
    ndeRecord: IXMLNode;
    i: Integer;
    ii: Integer;
  begin
    for i := 0 to ndeRows.ChildNodes.Count -1 do
    begin
      SLRecord.Clear;
      ndeRecord := ndeRows.ChildNodes[i];
      for ii := 0 to ndeRecord.AttributeNodes.Count-1 do
      begin
          SLRecord.Append(VarToStr(ndeRecord.AttributeNodes[ii].NodeValue));
      end;
      SW.WriteLine(SLRecord.CommaText);
    end;
    { Flush the contents of the writer to the stream. }
    SW.Flush;
    { Close the writer. }
    SW.Close;
  end;

begin
  Assert(Assigned(OS), 'OS not assigned');
  SLRecord := TStringList.Create;
  SS.Position := 0;
  SW := TStreamWriter.Create(OS, TEncoding.ANSI); //write text as ANSI
  try

    SLFields := TStringList.Create;
    try
    XMLDoc := TXMLDocument.Create(nil);
    //// load resource string to XMLDoc
    XMLDoc.XML.Text := SS.DataString;
    XMLDoc.Active := true;
    try
    ndeRoot := XMLDoc.DocumentElement;
    ndeMetaData := ndeRoot.ChildNodes.FindNode('METADATA');
    ndeFields := ndeMetaData.ChildNodes.FindNode('FIELDS');
    ndeRows := ndeRoot.ChildNodes.FindNode('ROWDATA');

    WriteFields;
    WriteRecords;

    finally
      XMLDoc := nil;
    end;
    finally
      SLFields.Free;
    end;
  finally
    SW.Free;
    SLRecord.Free;
  end;
end;

procedure TCsvTransform.TransformToDP(const SS: TStream; out OS: TStringStream);

  function GetFieldType(const symbol: Char): string;
  begin
    case symbol of
      '$': result := 'string';
      '!': result := 'boolean';
      '%': result := 'i4';
      '&': result := 'r4';
      '@': result := 'dateTime';
      else
        result := 'string';
    end;
  end;

  function GetFieldSize(const P: Pointer): string;
  var
    s: string;
  begin
    result := '25';
    s := PChar(P);
    if s <> '' then
      result := s;
  end;

var
  XMLDoc: IXMLDocument;
  ndeRoot,
  ndeMetaData,
  ndeFields,
  ndeField,
  ndeRows: IXMLNode;
  SLFields, SLField: TStringList;
  SLRecord: TStringList;
  SR: TStreamReader;

  procedure WriteFields;
  var
    sField: string;
  begin
    // loop in all fields
    SLRecord.Clear;
    SLRecord.CommaText := SR.ReadLine; //imply delimiter is comma
    SLField := TStringList.Create;
    try
    SLField.Delimiter := ':';
    for sField in SLRecord do
    begin
    /// add new Field node
      SLField.DelimitedText := sField;
      ndeField := ndeFields.ChildNodes[0].CloneNode(false); //clone 1st node as template
      ndeField.AttributeNodes[0].NodeValue := SLField[0]; //update cloned node
      if SLField.Count = 2 then
      begin
        ndeField.AttributeNodes[1].NodeValue := GetFieldType(SLField[1][1]);
        if Length(SLField[1]) > 1 then
          ndeField.AttributeNodes[2].NodeValue := GetFieldSize(@(SLField[1][2]));
      end else
        ndeField.AttributeNodes[1].NodeValue := 'string';
      ndeFields.ChildNodes.Add(ndeField); // add cloned node to ndeFields
      SLFields.Append(SLField[0]); // add fieldName to a TStringList
    end;
    // end loop fields
    finally
      SLField.Free;
    end;
    ndeFields.ChildNodes.Delete(0); //once copied from template node, delete it
  end;

  procedure WriteRecords;
  var
    i: byte;
  begin
    // loop in all records
    while not SR.EndOfStream do
    begin
      SLRecord.CommaText := SR.ReadLine; //imply delimiter is comma
      with ndeRows.AddChild('ROW') do
      begin
        // loop in all fields of current record
        for i := 0 to SLFields.Count -1 do
        begin
          SetAttribute(SLFields[i], SLRecord[i]);
        end;
        // end loop fields
      end;
    end;
    // end loop records
  end;

begin
  Assert(Assigned(OS), 'OS not assigned');
  SLRecord := TStringList.Create;
  SS.Position := 0;
  SR := TStreamReader.Create(SS, TEncoding.ANSI); //read text are ANSI in UltraEdit
  try

    SLFields := TStringList.Create;
    try
    XMLDoc := TXMLDocument.Create(nil);
    //// load resource string to XMLDoc
    XMLDoc.XML.Text := GetResourceString('tplDP');
    XMLDoc.Active := true;
    try
    ndeRoot := XMLDoc.DocumentElement;
    ndeMetaData := ndeRoot.ChildNodes.FindNode('METADATA');
    ndeFields := ndeMetaData.ChildNodes.FindNode('FIELDS');
    ndeRows := ndeRoot.ChildNodes.FindNode('ROWDATA');

    WriteFields;
    WriteRecords;

    XMLDoc.SaveToStream(OS);

    finally
      XMLDoc := nil;
    end;
    finally
      SLFields.Free;
    end;
  finally
    SR.Free;
    SLRecord.Free;
  end;
end;

end.
