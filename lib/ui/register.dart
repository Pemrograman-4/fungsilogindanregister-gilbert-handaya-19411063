import 'dart:async';
import 'package:gilbert_handaya_19411063/const/collor.dart';
import 'package:gilbert_handaya_19411063/ui/login.dart';
import 'package:gilbert_handaya_19411063/server/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class registerview extends StatefulWidget {
  @override
  _registerviewState createState() => _registerviewState();
}

class _registerviewState extends State<registerview> {
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  TextEditingController controllernama = new TextEditingController();
  TextEditingController controllertelp = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  void ShowSnackbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Signup() async {
    var url = UrlServer + "users/sign-up";

    String email = controlleremail.text;
    String nama = controllernama.text;
    String telp = controllertelp.text;
    String password = controllerpassword.text;

    if (email.isEmpty||nama.isEmpty||telp.isEmpty||password.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      ShowSnackbar(context, 'Field Cannot be empty', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "email": email,
        "nama": nama,
        "telp": telp,
        "password": password
      });
      var result = convert.jsonDecode(response.body);

      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        ShowSnackbar(context, Message, SuccesColor);
        print(Message);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => loginview()));
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // new Form(child: null,),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 15),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image(
                    image: AssetImage('assets/LOGO-UBL.png'),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Register Account',
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controlleremail,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Email',
                    hintText: 'Enter Email'),
                // controller: contr,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllernama,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Name',
                    hintText: 'Enter Your Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllertelp,
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Phone Number',
                    hintText: 'Enter Phone Number'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllerpassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(5.0))),
                    labelText: 'Password',
                    hintText: 'Enter Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Submit(context);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => loginview()));
                },
                child: Text('Have an Account? Sign In'),
              ),
            )
          ],
        ),
      ),
    );



    // );
  }

  Future<void> Submit(BuildContext context) async{
    try {
      Signup();
    } catch (error) {
      print(error);
    }
  }
}