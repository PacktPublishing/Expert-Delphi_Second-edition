unit uArrays;

interface

implementation

procedure DoFruits;
var
  Fruits: array of string;
begin
  Fruits := ['Apple', 'Pear'];
  Fruits := Fruits + ['Banana', 'Orange'];
end;

end.
