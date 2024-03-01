object DMToDo: TDMToDo
  Height = 594
  Width = 842
  PixelsPerInch = 192
  object FdconnToDos: TFDConnection
    Params.Strings = (
      'Database=C:\Users\Public\Documents\ToDos.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    AfterConnect = FdconnToDosAfterConnect
    BeforeConnect = FdconnToDosBeforeConnect
    Left = 64
    Top = 48
  end
  object FdqToDoInsert: TFDQuery
    Connection = FdconnToDos
    SQL.Strings = (
      'INSERT INTO ToDos (Id, Title, Category)'
      'VALUES (:Id, :Title, :Category)'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 432
    Top = 48
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'TITLE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CATEGORY'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object FdqToDoSelect: TFDQuery
    Connection = FdconnToDos
    SQL.Strings = (
      'SELECT Title, Category '
      'FROM ToDos '
      'WHERE Id = :Id'
      ''
      ''
      ''
      ''
      '')
    Left = 624
    Top = 48
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FdqToDoUpdate: TFDQuery
    Connection = FdconnToDos
    SQL.Strings = (
      'UPDATE ToDos SET '
      'Title = :Title, '
      'Category = :Category'
      'WHERE Id = :Id'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 240
    Top = 192
    ParamData = <
      item
        Name = 'TITLE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CATEGORY'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FdqToDoDelete: TFDQuery
    Connection = FdconnToDos
    SQL.Strings = (
      'DELETE FROM ToDos WHERE Id = :Id'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 432
    Top = 192
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object FdqToDoSelectAll: TFDQuery
    Connection = FdconnToDos
    SQL.Strings = (
      'SELECT * FROM ToDos'
      'ORDER BY Id DESC'
      ''
      ''
      '')
    Left = 624
    Top = 192
  end
  object FdqToDoMaxId: TFDQuery
    Connection = FdconnToDos
    SQL.Strings = (
      'SELECT MAX(Id) AS MaxId FROM ToDos')
    Left = 240
    Top = 48
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 608
    Top = 384
  end
end
