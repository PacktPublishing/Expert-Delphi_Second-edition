// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL
//  >Import : https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL>0
// Encoding : UTF-8
// Version  : 1.0
// (11/27/2023 9:10:05 PM - - $Rev: 112483 $)
// ************************************************************************ //

unit NumberConversion;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:unsignedLong    - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://www.dataaccess.com/webservicesserver/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : NumberConversionSoapBinding
  // service   : NumberConversion
  // port      : NumberConversionSoap
  // URL       : https://www.dataaccess.com/webservicesserver/NumberConversion.wso
  // ************************************************************************ //
  NumberConversionSoapType = interface(IInvokable)
  ['{A2E4D9CB-C96F-0965-87F0-E78269B29A8C}']
    function  NumberToWords(const ubiNum: Int64): string; stdcall;
    function  NumberToDollars(const dNum: TXSDecimal): string; stdcall;
  end;

function GetNumberConversionSoapType(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): NumberConversionSoapType;


implementation
  uses System.SysUtils;

function GetNumberConversionSoapType(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): NumberConversionSoapType;
const
  defWSDL = 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL';
  defURL  = 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso';
  defSvc  = 'NumberConversion';
  defPrt  = 'NumberConversionSoap';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as NumberConversionSoapType);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { NumberConversionSoapType }
  InvRegistry.RegisterInterface(TypeInfo(NumberConversionSoapType), 'http://www.dataaccess.com/webservicesserver/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(NumberConversionSoapType), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(NumberConversionSoapType), ioDocument);
  { NumberConversionSoapType.NumberToWords }
  InvRegistry.RegisterMethodInfo(TypeInfo(NumberConversionSoapType), 'NumberToWords', '',
                                 '[ReturnName="NumberToWordsResult"]');
  { NumberConversionSoapType.NumberToDollars }
  InvRegistry.RegisterMethodInfo(TypeInfo(NumberConversionSoapType), 'NumberToDollars', '',
                                 '[ReturnName="NumberToDollarsResult"]');

end.