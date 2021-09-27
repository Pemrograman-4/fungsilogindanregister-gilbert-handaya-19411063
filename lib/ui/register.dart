import 'package:gilbert_handaya_19411063/ui/login.dart';
import 'package:flutter/material.dart';

class registerview extends StatefulWidget {
  const registerview({Key? key}) : super(key: key);

  @override
  _registerviewState createState() => _registerviewState();
}

class _registerviewState extends State<registerview> {
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
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                // controller: controlleremail,
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
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                // controller: controllernama,
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
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                // controller: controllertelp,
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
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                // controller: controllerpassword,
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
                    // Submit(context);
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
}