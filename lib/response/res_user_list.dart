/// code : 200
/// message : "OK"
/// data : {"header":{"requestCode":"1001","total":1,"search":"email","searchValue":"test01@test.test"},"body":[{"id":1,"email":"test01@test.test","password":"test01","name":"tom1","age":21,"mobile":"01010001000","create_date":"2023-02-14T02:13:02.000Z","modify_date":"2023-02-14T02:13:04.000Z"}]}

class ResUserList {
  ResUserList({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  ResUserList.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
ResUserList copyWith({  num? code,
  String? message,
  Data? data,
}) => ResUserList(  code: code ?? _code,
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

/// header : {"requestCode":"1001","total":1,"search":"email","searchValue":"test01@test.test"}
/// body : [{"id":1,"email":"test01@test.test","password":"test01","name":"tom1","age":21,"mobile":"01010001000","create_date":"2023-02-14T02:13:02.000Z","modify_date":"2023-02-14T02:13:04.000Z"}]

class Data {
  Data({
      Header? header, 
      List<Body>? body,}){
    _header = header;
    _body = body;
}

  Data.fromJson(dynamic json) {
    _header = json['header'] != null ? Header.fromJson(json['header']) : null;
    if (json['body'] != null) {
      _body = [];
      json['body'].forEach((v) {
        _body?.add(Body.fromJson(v));
      });
    }
  }
  Header? _header;
  List<Body>? _body;
Data copyWith({  Header? header,
  List<Body>? body,
}) => Data(  header: header ?? _header,
  body: body ?? _body,
);
  Header? get header => _header;
  List<Body>? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_header != null) {
      map['header'] = _header?.toJson();
    }
    if (_body != null) {
      map['body'] = _body?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// email : "test01@test.test"
/// password : "test01"
/// name : "tom1"
/// age : 21
/// mobile : "01010001000"
/// create_date : "2023-02-14T02:13:02.000Z"
/// modify_date : "2023-02-14T02:13:04.000Z"

class Body {
  Body({
      num? id, 
      String? email, 
      String? password, 
      String? name, 
      num? age, 
      String? mobile, 
      String? createDate, 
      String? modifyDate,}){
    _id = id;
    _email = email;
    _password = password;
    _name = name;
    _age = age;
    _mobile = mobile;
    _createDate = createDate;
    _modifyDate = modifyDate;
}

  Body.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _password = json['password'];
    _name = json['name'];
    _age = json['age'];
    _mobile = json['mobile'];
    _createDate = json['create_date'];
    _modifyDate = json['modify_date'];
  }
  num? _id;
  String? _email;
  String? _password;
  String? _name;
  num? _age;
  String? _mobile;
  String? _createDate;
  String? _modifyDate;
Body copyWith({  num? id,
  String? email,
  String? password,
  String? name,
  num? age,
  String? mobile,
  String? createDate,
  String? modifyDate,
}) => Body(  id: id ?? _id,
  email: email ?? _email,
  password: password ?? _password,
  name: name ?? _name,
  age: age ?? _age,
  mobile: mobile ?? _mobile,
  createDate: createDate ?? _createDate,
  modifyDate: modifyDate ?? _modifyDate,
);
  num? get id => _id;
  String? get email => _email;
  String? get password => _password;
  String? get name => _name;
  num? get age => _age;
  String? get mobile => _mobile;
  String? get createDate => _createDate;
  String? get modifyDate => _modifyDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['password'] = _password;
    map['name'] = _name;
    map['age'] = _age;
    map['mobile'] = _mobile;
    map['create_date'] = _createDate;
    map['modify_date'] = _modifyDate;
    return map;
  }

}

/// requestCode : "1001"
/// total : 1
/// search : "email"
/// searchValue : "test01@test.test"

class Header {
  Header({
      String? requestCode, 
      num? total, 
      String? search, 
      String? searchValue,}){
    _requestCode = requestCode;
    _total = total;
    _search = search;
    _searchValue = searchValue;
}

  Header.fromJson(dynamic json) {
    _requestCode = json['requestCode'];
    _total = json['total'];
    _search = json['search'];
    _searchValue = json['searchValue'];
  }
  String? _requestCode;
  num? _total;
  String? _search;
  String? _searchValue;
Header copyWith({  String? requestCode,
  num? total,
  String? search,
  String? searchValue,
}) => Header(  requestCode: requestCode ?? _requestCode,
  total: total ?? _total,
  search: search ?? _search,
  searchValue: searchValue ?? _searchValue,
);
  String? get requestCode => _requestCode;
  num? get total => _total;
  String? get search => _search;
  String? get searchValue => _searchValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestCode'] = _requestCode;
    map['total'] = _total;
    map['search'] = _search;
    map['searchValue'] = _searchValue;
    return map;
  }

}