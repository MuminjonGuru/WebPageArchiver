unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Effects,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TForm1 = class(TForm)
    Rectangle1: TRectangle;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Button2: TButton;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    NetHTTPClient1: TNetHTTPClient;
    NetHTTPRequest1: TNetHTTPRequest;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure DownloadFile(FURL: String; FFileName: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}



procedure TForm1.Button1Click(Sender: TObject);
begin
  DownloadFile('https://api.screenshotlayer.com/api/capture?access_key='
                + Edit4.Text + '&url='
                + Edit1.Text + '&viewport=1440x900&fullpage='
                + Edit3.Text, 'screenshot.png');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DownloadFile('http://api.pdflayer.com/api/convert?access_key='
                + Edit6.Text + '&document_url='
                + Edit5.Text, 'my_file.pdf');
end;

procedure TForm1.DownloadFile(FURL, FFileName: String);
var
  HTTPClient: TNetHTTPClient;
  HTTPRequest: TNetHTTPRequest;
  Response: IHTTPResponse;
begin
  HTTPClient := TNetHTTPClient.Create(nil);
  HTTPRequest := TNetHTTPRequest.Create(nil);
  var MemoryStream := TMemoryStream.Create;
  try
    // Set up the client and request
    HTTPClient.Accept := 'application/json';
    HTTPRequest.Client := HTTPClient;

    // Make the request
    HTTPRequest.URL := FURL;
    Response := HTTPRequest.Get(FURL, MemoryStream);

    // Check the response status code
    if Response.StatusCode = 200 then
    begin
      // Save the image to a file
      MemoryStream.Seek(0, soFromBeginning);
      MemoryStream.SaveToFile(FFileName);
    end
    else
    begin
      Writeln('Error: ', Response.StatusCode, ' ', Response.StatusText);
    end;
  finally
    HTTPRequest.Free;
    HTTPClient.Free;
    MemoryStream.Free;
  end;
end;

end.
