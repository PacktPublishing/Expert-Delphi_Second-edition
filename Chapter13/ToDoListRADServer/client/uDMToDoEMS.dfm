object DMToDoEMS: TDMToDoEMS
  Height = 580
  Width = 836
  PixelsPerInch = 192
  object EMSProvider1: TEMSProvider
    ApiVersion = '1'
    URLHost = '127.0.0.1'
    URLPort = 8080
    Left = 64
    Top = 48
  end
  object BeToDoList: TBackendEndpoint
    Provider = EMSProvider1
    Params = <>
    Resource = 'ToDo'
    Response = RrespToDo
    Left = 88
    Top = 176
  end
  object RrespToDo: TRESTResponse
    Left = 560
    Top = 128
  end
  object BeToDoRead: TBackendEndpoint
    Provider = EMSProvider1
    Params = <>
    Resource = 'ToDo'
    ResourceSuffix = 'item'
    Response = RrespToDo
    Left = 256
    Top = 176
  end
  object BeToDoCreate: TBackendEndpoint
    Provider = EMSProvider1
    Method = rmPOST
    Params = <
      item
        Name = 'title'
        Value = 't'
      end
      item
        Name = 'category'
        Value = 'c'
      end>
    Resource = 'ToDo'
    Response = RrespToDo
    Left = 128
    Top = 368
  end
  object BeToDoUpdate: TBackendEndpoint
    Provider = EMSProvider1
    Method = rmPUT
    Params = <>
    Resource = 'ToDo'
    Response = RrespToDo
    Left = 304
    Top = 320
  end
  object BeToDoDelete: TBackendEndpoint
    Provider = EMSProvider1
    Method = rmDELETE
    Params = <>
    Resource = 'ToDo'
    ResourceSuffix = 'item'
    Response = RrespToDo
    Left = 496
    Top = 304
  end
end
