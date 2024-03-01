object DMToDo: TDMToDo
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 594
  Width = 842
  PixelsPerInch = 192
  object AzureConnectionInfo1: TAzureConnectionInfo
    BlobEndpoint = '.blob.core.windows.net'
    QueueEndpoint = '.queue.core.windows.net'
    TableEndpoint = '.table.core.windows.net'
    Left = 168
    Top = 128
  end
end
