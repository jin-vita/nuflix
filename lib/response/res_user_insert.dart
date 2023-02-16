/// code : 200
/// message : "OK"
/// data : {"header":{"requestCode":"1002"},"body":{"fieldCount":0,"affectedRows":1,"insertId":3,"serverStatus":2,"warningCount":0,"message":"","protocol41":true,"changedRows":0}}

class ResUserInsert {
  ResUserInsert({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  ResUserInsert.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
ResUserInsert copyWith({  num? code,
  String? message,
  Data? data,
}) => ResUserInsert(  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get code => _code;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// header : {"requestCode":"1002"}
/// body : {"fieldCount":0,"affectedRows":1,"insertId":3,"serverStatus":2,"warningCount":0,"message":"","protocol41":true,"changedRows":0}

class Data {
  Data({
      Header? header, 
      Body? body,}){
    _header = header;
    _body = body;
}

  Data.fromJson(dynamic json) {
    _header = json['header'] != null ? Header.fromJson(json['header']) : null;
    _body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }
  Header? _header;
  Body? _body;
Data copyWith({  Header? header,
  Body? body,
}) => Data(  header: header ?? _header,
  body: body ?? _body,
);
  Header? get header => _header;
  Body? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_header != null) {
      map['header'] = _header?.toJson();
    }
    if (_body != null) {
      map['body'] = _body?.toJson();
    }
    return map;
  }

}

/// fieldCount : 0
/// affectedRows : 1
/// insertId : 3
/// serverStatus : 2
/// warningCount : 0
/// message : ""
/// protocol41 : true
/// changedRows : 0

class Body {
  Body({
      num? fieldCount, 
      num? affectedRows, 
      num? insertId, 
      num? serverStatus, 
      num? warningCount, 
      String? message, 
      bool? protocol41, 
      num? changedRows,}){
    _fieldCount = fieldCount;
    _affectedRows = affectedRows;
    _insertId = insertId;
    _serverStatus = serverStatus;
    _warningCount = warningCount;
    _message = message;
    _protocol41 = protocol41;
    _changedRows = changedRows;
}

  Body.fromJson(dynamic json) {
    _fieldCount = json['fieldCount'];
    _affectedRows = json['affectedRows'];
    _insertId = json['insertId'];
    _serverStatus = json['serverStatus'];
    _warningCount = json['warningCount'];
    _message = json['message'];
    _protocol41 = json['protocol41'];
    _changedRows = json['changedRows'];
  }
  num? _fieldCount;
  num? _affectedRows;
  num? _insertId;
  num? _serverStatus;
  num? _warningCount;
  String? _message;
  bool? _protocol41;
  num? _changedRows;
Body copyWith({  num? fieldCount,
  num? affectedRows,
  num? insertId,
  num? serverStatus,
  num? warningCount,
  String? message,
  bool? protocol41,
  num? changedRows,
}) => Body(  fieldCount: fieldCount ?? _fieldCount,
  affectedRows: affectedRows ?? _affectedRows,
  insertId: insertId ?? _insertId,
  serverStatus: serverStatus ?? _serverStatus,
  warningCount: warningCount ?? _warningCount,
  message: message ?? _message,
  protocol41: protocol41 ?? _protocol41,
  changedRows: changedRows ?? _changedRows,
);
  num? get fieldCount => _fieldCount;
  num? get affectedRows => _affectedRows;
  num? get insertId => _insertId;
  num? get serverStatus => _serverStatus;
  num? get warningCount => _warningCount;
  String? get message => _message;
  bool? get protocol41 => _protocol41;
  num? get changedRows => _changedRows;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fieldCount'] = _fieldCount;
    map['affectedRows'] = _affectedRows;
    map['insertId'] = _insertId;
    map['serverStatus'] = _serverStatus;
    map['warningCount'] = _warningCount;
    map['message'] = _message;
    map['protocol41'] = _protocol41;
    map['changedRows'] = _changedRows;
    return map;
  }

}

/// requestCode : "1002"

class Header {
  Header({
      String? requestCode,}){
    _requestCode = requestCode;
}

  Header.fromJson(dynamic json) {
    _requestCode = json['requestCode'];
  }
  String? _requestCode;
Header copyWith({  String? requestCode,
}) => Header(  requestCode: requestCode ?? _requestCode,
);
  String? get requestCode => _requestCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestCode'] = _requestCode;
    return map;
  }

}