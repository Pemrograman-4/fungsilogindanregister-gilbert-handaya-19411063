import 'dart:async';

import 'package:gilbert_handaya_19411063/ui/home.dart';
import 'package:gilbert_handaya_19411063/ui/register.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:gilbert_handaya_19411063/const/collor.dart';
import 'package:gilbert_handaya_19411063/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginview extends StatefulWidget {
  @override
  _loginviewState createState() => _loginviewState();
}

class _loginviewState extends State<loginview> {

  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();

  void ShowSnackbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Signin() async {
    String email = controlleremail.text;
    String password = controllerpassword.text;
    var url = UrlServer + "users/sign-in";
    if (email.isEmpty||password.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      ShowSnackbar(context, 'Field Cannot be Empty', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "email": email,
        "password": password
      });
      var result = convert.jsonDecode(response.body);
      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        ShowSnackbar(context, Message, SuccesColor);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('_id', result['user']['id']);
        await prefs.setString('nama', result['user']['nama']);
        await prefs.setString('email', result['user']['email']);
        await prefs.setInt('telp', result['user']['telp']);
        await prefs.setString('password', result['user']['password']);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => homepage()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        ShowSnackbar(context, Message, ErrorColor);
        print(Message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final urlImage1='assets/LOGO-UBL.png';

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    offset: Offset(0, 10),
                    blurRadius: 20,
                  )
                ]
              ),
              child: Center(
                child: SizedBox(
                    width: 150,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image(
                      image: AssetImage('assets/LOGO-UBL.png'),)
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Log In',
                  style: (TextStyle(
                      color: Colors.blue, fontSize: 25, fontFamily: 'Raleway')),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controlleremail,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    labelText: 'Email',
                    hintText: 'Enter Email'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerpassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0))),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // FlatButton(
            //   onPressed: () {
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            // child: Text(
            //   'Forgot Password',
            //   style: TextStyle(color: Colors.blue, fontSize: 15),
            // ),
            // ),
            Container(
              // padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20.0),
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Submit(context);
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => registerview()));
                },
                child: const Text(
                  'Do not have an account yet? Register',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                )),
            // Text('Do not have an account yet? Register')
          ],
        ),
      ),

    );
  }

  Future<void> Submit(BuildContext context) async {
    try{
      Signin();
    } catch (error) {
      print(error);
    }
  }
}