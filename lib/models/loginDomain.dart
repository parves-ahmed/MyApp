class User{

  static const tblUser = 'users';
  static const colId = 'id';
  static const colName = 'name';
  static const colPassword = 'password';

  User({this.id, this.name, this.password});

  User.fromMap(Map<String, dynamic>map){
    id = map[colId];
    name = map[colName];
    password = map[colPassword];
  }

  int id;
  String name;
  String password;
  
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{colName: name, colPassword: password};
    if(id != null) map[colId] = id;
    return map;
  }

}