object DMToDoWebBrokREST: TDMToDoWebBrokREST
  Height = 580
  Width = 836
  PixelsPerInch = 192
  object RClientToDo: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://127.0.0.1:8080'
    Params = <>
    SynchronizedEvents = False
    Left = 128
    Top = 80
  end
  object RRespToDo: TRESTResponse
    ContentType = 'application/json'
    Left = 320
    Top = 80
  end
  object RReqToDoCreate: TRESTRequest
    Client = RClientToDo
    Params = <
      item
        Name = 'title'
      end
      item
        Name = 'category'
      end>
    Resource = 'ToDo/Create'
    Response = RRespToDo
    SynchronizedEvents = False
    Left = 128
    Top = 224
  end
  object RReqToDoRead: TRESTRequest
    Client = RClientToDo
    Params = <
      item
        Name = 'id'
      end>
    Resource = 'ToDo/Read'
    Response = RRespToDo
    SynchronizedEvents = False
    Left = 320
    Top = 224
  end
  object RReqToDoUpdate: TRESTRequest
    Client = RClientToDo
    Params = <
      item
        Name = 'id'
      end
      item
        Name = 'title'
      end
      item
        Name = 'category'
      end>
    Resource = 'ToDo/Update'
    Response = RRespToDo
    SynchronizedEvents = False
    Left = 512
    Top = 224
  end
  object RReqToDoDelete: TRESTRequest
    Client = RClientToDo
    Params = <
      item
        Name = 'id'
      end>
    Resource = 'ToDo/Delete'
    Response = RRespToDo
    SynchronizedEvents = False
    Left = 112
    Top = 384
  end
  object RReqToDoList: TRESTRequest
    Client = RClientToDo
    Params = <>
    Resource = 'ToDo/List'
    Response = RRespToDo
    SynchronizedEvents = False
    Left = 320
    Top = 384
  end
end
