unit Notification;

interface

uses System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Layouts, FMX.Memo, FMX.DateTimeCtrls, DateUtils,
  FMX.ListBox,
  FMX.Controls.Presentation, FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Platform,
  FMX.Notification;

var
  NotificationArray: Array[0..100] of TNotification;
  NotificationCounter: Integer;

implementation

procedure Initialize();
begin
  NotificationCounter := -1;
end;

procedure ScheduleNotification(notifyCenter: TNotificationCenter; fireTime: TDateTime);
var
  Notification: TNotification;
begin
  Notification := notifyCenter.CreateNotification;
  try
    Inc(NotificationCounter);

    if (NotificationCounter > 100) then
    begin
        ShowMessage('Too many notifications');
        Exit;
    end;

    Notification.Name := 'TestName';
    Notification.AlertBody := 'TestBody';

    // fire at fireTime
    Notification.FireDate := fireTime;
    notifyCenter.ScheduleNotification(Notification);

    NotificationArray[NotificationCounter] := Notification;
  finally
    Notification.DisposeOf;
  end;
end;

end.
