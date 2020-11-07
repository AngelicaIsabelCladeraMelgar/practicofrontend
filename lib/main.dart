import 'package:flutter/material.dart';
import 'package:practicofrontend/login.dart';
import 'dart:async';
import 'package:practicofrontend/models/cases.dart';
import 'package:practicofrontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practicofrontend/studentlist.dart';
import 'package:practicofrontend/addstudent.dart';
//import 'package:studentapp/detailstudent.dart';
//import 'package:studentapp/editstudent.dart';

void main() => runApp(StudentApp());

class StudentApp extends StatelessWidget {
  const StudentApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);
  final ApiService api = ApiService();

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "StudentApp de Isabel",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              // ignore: deprecated_member_use
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
          FlatButton(
            onPressed: () {
              print("Refresh");
              // ignore: deprecated_member_use
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => StudentApp()),
                  (Route<dynamic> route) => false);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Center(child: JobsListView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.lightBlue[900],
      ),
    );
    drawer:
    Drawer();
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
