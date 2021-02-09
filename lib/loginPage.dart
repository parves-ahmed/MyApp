import 'package:flutter/material.dart';
import './models/loginDomain.dart';
import './utils/database_helper.dart';
import './registerPage.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  User _user = User();
  DatabaseHelper _dbHelper;
  String msg = "gj";
  @override
  void initState(){
    super.initState();
    setState(() {
          _dbHelper = DatabaseHelper.instance;
        });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _form()
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
            onChanged: (val) => setState(()=> _user.name = val),
            validator: (val)=>(val.length == 0 ? "This field is required" : null),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
            onChanged: (val) => setState(()=> _user.password = val),
            validator: (val)=>(val.length < 8 ? "This field is required minimum 8 character" : null), 
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child:Text(msg, style: TextStyle(color: Colors.red)), 
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: ()=> _onSubmit(),
              child: Text("Login"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: ()=> _register(),
              child: Text("Don't Have Account?  Register"),
            ),
          )
        ],
      ),
    ),
  );

  _register(){
     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            );
  }

  _onSubmit() async{
    var form = _formKey.currentState;
    if(form.validate()){
      var result = await _dbHelper.fetchUserByNameAndPassword(_user.name, _user.password);
      if(result.length != 0){
        print("ok");
         Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
      }
      else{
        setState(() {
                  msg = "Invalid Username or Password";
                });
      }
    }
  }
}