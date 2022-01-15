import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/Screen/Favs.dart';
import 'package:task_app/Screen/news.dart';
import 'package:task_app/Screen/sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
   List<dynamic> Favrs = [];
  final List<Widget> _pages = [const News(), Favs([])];
  void tapBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.remove('email');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignIn()));
        },
        child: const Icon(Icons.logout),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: tapBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.toc_outlined), label: "News"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favs")
        ],
      ),
    );
  }
}
