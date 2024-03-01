unit uOSVerHelpers;

interface

uses
  System.SysUtils;

type
  TOSArchHelper = record helper for TOSVersion.TArchitecture
    function ToString: string;
  end;

  TOSPlatHelper = record helper for TOSVersion.TPlatform
    function ToString: string;
  end;

implementation

{ TOSArchitectureHelper }

function TOSArchHelper.ToString: string;
begin
  case self of
    arIntelX86: Result := 'IntelX86';
    arIntelX64: Result := 'IntelX64';
    arARM32: Result := 'ARM32';
    arARM64: Result := 'ARM64';
  else
    Result := 'Unknown OS Architecture';
  end;
end;

{ TOSPlatformHelper }

function TOSPlatHelper.ToString: string;
begin
  case self of
    pfWindows: Result := 'Windows';
    pfMacOS: Result := 'MacOS';
    pfiOS: Result := 'iOS';
    pfAndroid: Result := 'Android';
    pfWinRT: Result := 'WinRT';
    pfLinux: Result := 'Linux';
  else
    Result := 'Unknown OS Platform'
  end;
end;

end.
