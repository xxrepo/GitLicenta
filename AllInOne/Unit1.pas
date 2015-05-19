unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.TabControl, FMX.StdCtrls, FMX.Layouts, FMX.Memo,
  FMX.DateTimeCtrls, DateUtils, FMX.ListBox, FMX.Controls.Presentation,
  FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Platform, FMX.Notification,
  Notification, FMX.ListView.Types, FMX.ListView;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Create_titleLbl: TLabel;
    Create_TextLbl: TLabel;
    Memo1: TMemo;
    Create_dateLbl: TLabel;
    DateEdit1: TDateEdit;
    Create_createBtn: TButton;
    ResultLbl: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    NumberBox1: TNumberBox;
    NumberBox2: TNumberBox;
    NotificationCenter1: TNotificationCenter;
    AllNotifications: TListView;
    Button1: TButton;
    Label3: TLabel;
    procedure Create_createBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ScheduleNotification(fireTime: TDateTime);
    procedure AddToNotificationList(Notification: TNotification);
  end;

var
  Form1: TForm1;

implementation

uses
  SMS;

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm1.AddToNotificationList(Notification: TNotification);
var
  item: TListViewItem;
begin
  item := AllNotifications.Items.Add;

  item.Text := Notification.Name;
  item.Detail := Notification.AlertBody;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  result: string;
begin
//  result := FetchSms();
//  Label3.Text := result;

ShowMessage(FetchSms());
end;

procedure TForm1.Create_createBtnClick(Sender: TObject);
var
  Text: String;
  datePicked: TDateTime;
  hourPicked, minutesPicked: String;
  year, month, day: Word;
begin
  Text := Memo1.Text;
  datePicked := DateEdit1.DateTime;
  hourPicked := NumberBox2.Text;
  minutesPicked := NumberBox1.Text;

  DecodeDate(datePicked, year, month, day);
  datePicked := EncodeDateTime(year, month, day, StrToInt(hourPicked),
    StrToInt(minutesPicked), 0, 0);

  // ResultLbl.Text := DateTimeToStr(datePicked);

  if (CompareDateTime(datePicked, Now) < 0) then
    ResultLbl.Text := 'Data invalida'
  else
  begin
    ResultLbl.Text := 'Notificare programata la data: ' +
      DateTimeToStr(datePicked);
    ScheduleNotification(datePicked);
  end;
end;

procedure TForm1.ScheduleNotification(fireTime: TDateTime);
var
  Notification: TNotification;
begin
  Notification := NotificationCenter1.CreateNotification;
  try
    Notification.Name := 'TestName';
    Notification.AlertBody := 'TestBody';
    Notification.EnableSound := true;

    // fire at fireTime
    Notification.FireDate := fireTime;
    NotificationCenter1.ScheduleNotification(Notification);
    AddToNotificationList(Notification);
  finally
    Notification.DisposeOf;
  end;
end;

end.
