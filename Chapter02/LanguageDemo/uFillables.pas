unit uFillables;

interface

type
  TFillable<T> = record
    Value: T;
    IsFilled: Boolean;
  end;

  TFillableString = TFillable<string>;
  TFillableInteger = TFillable<Integer>;

implementation

end.


