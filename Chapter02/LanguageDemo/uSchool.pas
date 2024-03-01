unit uSchool;

interface

implementation

var
  Grade: Integer;

//{$SCOPEDENUMS ON}
//type
//  TSchoolGrade = (VeryGood, Good, Sufficient, Insufficient);

type
  TSchoolGrade = (sgVeryGood, sgGood, sgSufficient, sgInsufficient);
  TSchoolGrades = set of TSchoolGrade;

const
  Qualifying_Grades: TSchoolGrades = [sgVeryGood, sgGood, sgSufficient];

type
  TSchoolGradeHelper = record helper for TSchoolGrade
  public
    function ToString: string;
    function ToInteger: Integer;
    function IsQualifying: Boolean;
  end;

{ TSchoolGradeHelper }

function TSchoolGradeHelper.IsQualifying: Boolean;
begin
  Result := self in Qualifying_Grades;
end;

function TSchoolGradeHelper.ToInteger: Integer;
begin
  case self of
    sgVeryGood: Result := 5;
    sgGood: Result := 4;
    sgSufficient: Result := 3;
    sgInsufficient: Result := 2;
  end;
end;

function TSchoolGradeHelper.ToString: string;
begin
  case self of
    sgVeryGood: Result := 'Very Good';
    sgGood: Result := 'Good';
    sgSufficient: Result := 'Sufficient';
    sgInsufficient: Result := 'Insufficient';
  end;
end;

end.
