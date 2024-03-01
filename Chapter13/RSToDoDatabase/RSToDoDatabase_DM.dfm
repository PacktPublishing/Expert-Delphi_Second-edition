object TododatabaseResource1: TTododatabaseResource1
  Height = 600
  Width = 1200
  PixelsPerInch = 192
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Users\Public\Documents\ToDos.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 156
    Top = 128
  end
  object qryTodo: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from ToDos'
      '{if !SORT}order by !SORT{fi}')
    Left = 156
    Top = 256
    MacroData = <
      item
        Value = Null
        Name = 'SORT'
      end>
  end
  object dsrTodo: TEMSDataSetResource
    AllowedActions = [List, Get, Post, Put, Delete]
    DataSet = qryTodo
    Left = 156
    Top = 384
  end
end
