import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/Screen/homepage.dart';
import 'package:task_app/Screen/sign_up.dart';
import 'package:task_app/Widgets/background_image.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

 

  @override
  Widget build(BuildContext context) {
    final mailField = TextFormField(
        autofocus: false,
        controller: emailC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailC.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passField = TextFormField(
        autofocus: false,
        controller: passwordC,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password");
          }
        },
        onSaved: (value) {
          passwordC.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    var expanded = const Expanded(
        child: Divider(
      color: Colors.black,
      thickness: 0.8,
    ));
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        const BackgroungImage(),
        const Padding(
          padding: EdgeInsets.only(left: 50, top: 100),
          child: Text(
            "Welcome!!",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 450,
            width: 400,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: mailField,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: passField,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 240, top: 10),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFF1565C0)),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      primary: const Color(0xFF64B5F6),
                      side: const BorderSide(width: 2, color: Colors.cyan),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    login();
                  },
                  child: const Text('Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .7,
                  child: Row(
                    children: [
                      expanded,
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Or Sign In With",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      expanded
                    ],
                  ),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.09,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('google.png'))),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.09,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('facebook.png'))),
                      ),
                    ]),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
  
   Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              "https://reqres.in/api/login"),
          body: json.encode({'email': emailC.text, 'password': passwordC.text}),
          headers: {'Content-Type':'application/json'}
          );
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
             final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
            sharedPreferences.setString("email", emailC.text);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User Not Found!!")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }
}
