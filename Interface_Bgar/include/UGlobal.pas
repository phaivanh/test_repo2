unit UGlobal;

interface
  uses SescoiFDConX, uConneXion, System.SysUtils,
  FireDAC.Comp.Client;


type
  TParAmComponentCodeDesc = record
      AssemblyId : integer;
      AssemblyCode : string;
      AssemblyDesc : string;
      LineCode: string;
      LineDesc: string;
  end;


procedure GetComponentCodeDesc(const AParam : TParAmComponentCodeDesc ; var ACode,ADesc : string);
procedure GetComponentCodeDescReference(const AQuery : TSCQuery ; var ACode,ADesc : string);
procedure GetComponentPictureAndId(AAssemblyId, AAssemblyComponentId, ALineJobComponentId  : integer; var AComponentId : integer; var APicturePath : string) ;


implementation


procedure GetComponentPictureAndId(AAssemblyId, AAssemblyComponentId, ALineJobComponentId : integer ; var AComponentId : integer; var APicturePath : string) ;
var
  ReqSql      : string;
  res         : Double;
  SqlSet      : TSCQuery;

begin

      APicturePath := '';
      AComponentId := -1;

      if (AAssemblyId > 0) then
      begin
        if (AAssemblyComponentId > 0 )  then
        begin
          Reqsql := format('select int_id, picture_path from component where int_id = %d ',[ AAssemblyComponentId]);
          SqlSet := GFDConX.Select(Reqsql);
        end
      end
      else begin
          if (ALineJobComponentId > 0) then
          begin
            Reqsql  := format('select int_id, picture_path from component where int_id = %d ',[ALineJobComponentId ]);
            SqlSet := GFDConX.Select(Reqsql);
          end;
      end;
      if assigned(SqlSet) = true then
      begin
        if (SqlSet.RecordCount > 0) then
        begin

          SqlSet.First;
          AComponentId := SqlSet.FieldByName('int_id').AsInteger;
          APicturePath := SqlSet.FieldByName('picture_path').AsString;
        end;
        SqlSet.Free;
      end;
end;





function GetQtyLineAssembly(ALineJobId, AAssemblyId: integer): extended;
var
  ReqSql      : string;
  res         : Double;

begin
  ReqSql := Format('SELECT f_get_total_qty_line(%d,0,%d)',[ ALineJobId, AAssemblyId ]);
   res :=   GFDConX.Select(Reqsql, 0.0);
  Result := res;
end;

function GetProducedQty(ATaskId: Integer): extended;
{-------------------------------------------------------------------------------
  Procedure: TExportJob.GetProducedQty
  Author:    pthongsoum
  DateTime:  2015.05.28
-------------------------------------------------------------------------------}
var
  ReqSql      : string;
  res         : Double;

begin
  ReqSql := Format('SELECT sum(qty) from completed_time_cost where task_id= %d',[ATaskId ]);
   res := GFDConX.Select(Reqsql, 0.0);
  Result := res;
end;

function GetForecastedQty(ATaskId: integer): extended;
{-------------------------------------------------------------------------------
  Procedure: TExportJob.GetForecastedQty
  Author:    pthongsoum
  DateTime:  2015.05.28
-------------------------------------------------------------------------------}
var
  ReqSql      : string;
  res         : Double;

begin
  ReqSql := Format('SELECT sum(radan_piece.forecasted_qty * radan_imbrication.nb_part) from radan_piece'+
                   ' LEFT JOIN  radan_imbrication ON  radan_imbrication.int_id = radan_imbrication_id '+
                   ' where radan_imbrication.status = 0 and radan_piece.task_id= %d',[ATaskId ]);
   res := GFDConX.Select(Reqsql, 0.0);
  Result := res;

end;


procedure GetComponentCodeDesc(const AParam : TParAmComponentCodeDesc ; var ACode,ADesc : string);

begin
     if AParam.AssemblyId <= 0 then
      begin
        ACode := AParam.LineCode;
        ADesc := ACode;
      end
      else
      begin
        ACode := AParam.AssemblyCode;
        if IntToStr(AParam.AssemblyId) = AParam.AssemblyCode then
          {   assembly code contient l'identifiant de assembly   }
           ADesc := AParam.AssemblyDesc
        else ADesc := AParam.AssemblyCode;
      end;
end;


procedure GetComponentCodeDescReference(const AQuery : TSCQuery ; var ACode,ADesc : string);

begin
     if AQuery.FieldByName('assembly_id').IsNull then
      begin
        if AQuery.FieldByName('line_code').AsString <> '' then
            ACode := AQuery.FieldByName('line_code').AsString
        else ACode := AQuery.FieldByName('line_desc').AsString;
        ADesc := ACode;
      end
      else
      begin
        ACode := AQuery.FieldByName('assembly_code').AsString;
        if AQuery.FieldByName('assembly_id').AsString = AQuery.FieldByName('assembly_code').AsString then
          {   assembly code contient l'identifiant de assembly   }
           ADesc := AQuery.FieldByName('assembly_desc').Asstring
        else ADesc := AQuery.FieldByName('assembly_code').Asstring;
      end;
end;

end.
