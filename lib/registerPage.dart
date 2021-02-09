import 'package:flutter/material.dart';
import './models/loginDomain.dart';
import './utils/database_helper.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  User _user = User();
  List<User> _users = [];
  DatabaseHelper _dbHelper;
  @override
  void initState(){
    super.initState();
    setState(() {
          _dbHelper = DatabaseHelper.instance;
        });
  _userList();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _form(),_list()
        ],
      ),
    );
  }
  _form()=>Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: "Username or Email"),
            onSaved: (val) => setState(()=> _user.name = val),
            validator: (val)=>(val.length == 0 ? "This field is required" : null),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
            onChanged: (val) => setState(()=> _user.password = val),
            validator: (val)=>(val.length < 8 ? "This field is required minimum 8 character" : null),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: "Confirm Password"),
            validator: (val)=>(val != _user.password ? "Password Not Matched" : null),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: ()=> _onSubmit(),
              child: Text("Register"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: ()=> _login(),
              child: Text("Already Have Account. Login"),
            ),
          )
        ],
      ),
    ),
  );

  _userList() async{
    List<User> x = await _dbHelper.fetchUser();
    print(x);
    setState(() {
          _users = x;
        });
  }

  _login(){
    Navigator.pop(context);
  }

  _onSubmit() async{
    var form = _formKey.currentState;
    if(form.validate()){
      form.save();
      await _dbHelper.insertUser(_user);
      _userList();
      print(_userList());
      //  Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => SecondRoute()),
      //       );
    }
  }

  _list()=>Expanded(
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, index){
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(_users[index].name),
              )
            ],
          );
        },
        itemCount: _users.length,
      ),
    ),
  );
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}