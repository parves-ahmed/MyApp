import 'package:flutter/material.dart';
import './loginPage.dart';

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: LoginPage(),
  ));
}

// class HomePage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return  Scaffold(
//         appBar: AppBar(title: Text('Home'),),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               child: Text("home"),
//             )
//           ],
//         )
//       );
//   }
  // _form()=>Container(
  //   color: Colors.white,
  //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
  //   child: Form(
  //     key: ,
  //   ),
  // );

  // _list()=>{};
// }