unit uChess;

interface

type
  TChessPiece = record
    Name: string;
    Value: Double;
  end;

const
  Chess_pieces_count = 6;

  Chess_pieces: array[0..Chess_pieces_count-1] of TChessPiece =
    (
      (Name : 'Pawn'; Value : 1),
      (Name : 'Knight'; Value : 3),
      (Name : 'Bishop'; Value : 3),
      (Name : 'Rook'; Value : 5),
      (Name : 'Queen'; Value : 9),
      (Name : 'King'; Value : 0)
    ) ;

implementation

end.
