unit SMS;

interface

uses
  SysUtils, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Net, Androidapi.JNI.JavaTypes, Androidapi.JNI.Telephony,
  Androidapi.Helpers;

function FetchSms: string;

implementation

function FetchSms: string;
var
  cursor: JCursor;
  uri: Jnet_Uri;
  address, person, msgdatesent, protocol, msgread, msgstatus, msgtype,
    msgreplypathpresent, subject, body, servicecenter, locked: string;
  msgunixtimestampms: int64;
  addressidx, personidx, msgdateidx, msgdatesentidx, protocolidx, msgreadidx,
    msgstatusidx, msgtypeidx, msgreplypathpresentidx, subjectidx, bodyidx,
    servicecenteridx, lockedidx: integer;
begin
  uri := StrToJURI('content://sms/sent');
  cursor := SharedActivity.getContentResolver.query(uri, nil, nil, nil, nil);
  addressidx := cursor.getColumnIndex(StringToJstring('address'));
  personidx := cursor.getColumnIndex(StringToJstring('person'));
  msgdateidx := cursor.getColumnIndex(StringToJstring('date'));
  msgdatesentidx := cursor.getColumnIndex(StringToJstring('date_sent'));
  protocolidx := cursor.getColumnIndex(StringToJstring('protocol'));
  msgreadidx := cursor.getColumnIndex(StringToJstring('read'));
  msgstatusidx := cursor.getColumnIndex(StringToJstring('status'));
  msgtypeidx := cursor.getColumnIndex(StringToJstring('type'));
  msgreplypathpresentidx := cursor.getColumnIndex
    (StringToJstring('reply_path_present'));
  subjectidx := cursor.getColumnIndex(StringToJstring('subject'));
  bodyidx := cursor.getColumnIndex(StringToJstring('body'));
  servicecenteridx := cursor.getColumnIndex(StringToJstring('service_center'));
  lockedidx := cursor.getColumnIndex(StringToJstring('locked'));

  while (cursor.moveToNext) do
  begin
    address := JStringToString(cursor.getString(addressidx));
    person := JStringToString(cursor.getString(personidx));
    msgunixtimestampms := cursor.getLong(msgdateidx);
    msgdatesent := JStringToString(cursor.getString(msgdatesentidx));
    protocol := JStringToString(cursor.getString(protocolidx));
    msgread := JStringToString(cursor.getString(msgreadidx));
    msgstatus := JStringToString(cursor.getString(msgstatusidx));
    msgtype := JStringToString(cursor.getString(msgtypeidx));
    msgreplypathpresent := JStringToString
      (cursor.getString(msgreplypathpresentidx));
    subject := JStringToString(cursor.getString(subjectidx));
    body := JStringToString(cursor.getString(bodyidx));
    servicecenter := JStringToString(cursor.getString(servicecenteridx));
    locked := JStringToString(cursor.getString(lockedidx));

    Result := person + ' ' + address +
      ' ' + body;
  end;

 // Result := IntToStr(cursor.getCount);
end;

end.
