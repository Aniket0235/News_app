import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/Screen/homepage.dart';
import 'package:task_app/Screen/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var email = sharedPreferences.getString("email");
  runApp(MaterialApp(
    home: email == null ? const SignIn() : const HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
