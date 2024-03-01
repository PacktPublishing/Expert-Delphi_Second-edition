unit uPersonTList;

interface

procedure DoPersonsTList;

implementation

uses
  uPerson,
  System.Classes, // TList
  uFormDemo;

procedure DoPersonsTList;
var
  Persons: TList; P: TPerson;
begin
  Persons := TList.Create;
  try
    // not safe, can add any pointer
    Persons.Add(TPerson.Create('Kirk', 'Hammett'));
    Persons.Add(TPerson.Create('James', 'Hetfield'));
    Persons.Add(TPerson.Create('Lars', 'Ulrich'));
    Persons.Add(TPerson.Create('Robert', 'Trujillo'));

    for var I := 0 to Persons.Count-1 do
    begin
      P := Persons.Items[I];
      Log(p.Fullname);
    end;
  finally
    Persons.Free;
  end;
end;

end.
