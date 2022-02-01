unit CommandLine;

interface

uses
  GpCommandLineParser;

type
  TCommandLine = class

  strict private
    FLangCode: string;
    FWorkNCZonePath: string;
    FConfigMode: Boolean;

  public
//    [CLPPosition( 1 ), CLPDescription( 'Path to input MDB file ( "c:\tmp\report.mdb" )', '<MDBFilePath>' ), CLPRequired]
//    property MDBFilePath: string read FMDBFilePath write FMDBFilePath;
//
//    [CLPPosition( 2 ), CLPDescription( 'Path to CSV output file ( "c:\tmp\result.csv" )' ), CLPRequired]
//    property CSVFilePath: string read FCSVFilePath write FCSVFilePath;
//
//    //[CLPPosition( 3 ), CLPDescription( 'Path to SQL query file' ), CLPRequired]
//    [CLPPosition( 3 ), CLPDescription( 'Path to SQL query file ( "Query.sql" )' )]
//    property QueryFilePath: string read FQueryFilePath write FQueryFilePath;

    [CLPName( 'l' ), CLPLongName( 'lang' ), CLPDescription( 'Input code lang', '<lang>' )]
    property LangCode: string read FLangCode write FLangCode;

    [CLPName( 'p' ), CLPLongName( 'path' ), CLPDescription( 'Input workNC path', '<WorkNC path>' )]
    property WorkNCZonePath: string read FWorkNCZonePath write FWorkNCZonePath;

    [CLPName( 'c' ), CLPLongName( 'config' ), CLPDescription( 'Display settings screen' )]
    property ConfigMode: boolean read FConfigMode write FConfigMode;
  end;

var
  CommandLine1 : TCommandLine;

implementation

end.
