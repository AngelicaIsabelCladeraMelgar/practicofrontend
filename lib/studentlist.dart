import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practicofrontend/models/cases.dart';
import 'package:practicofrontend/detailstudent.dart';
//import 'package:studentapp/detailstudent.dart';
//import 'package:http/http.dart';
//import 'package:studentapp/main.dart';

/*class Job {
  final int studentID;
  final String lastName;
  final String firstName;
  final DateTime enrollmentDate;

  Job({this.studentID, this.lastName, this.firstName, this.enrollmentDate});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      studentID: json['StudentID'],
      lastName: json['LastName'],
      firstName: json['FirstName'],
      enrollmentDate: DateTime.parse(json['EnrollmentDate']),
    );
  }
}

class JobsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cases>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Cases> data = snapshot.data;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }*/
class JobsListView extends StatefulWidget {
  JobsListView({Key key}) : super(key: key);

  @override
  _JobsListViewState createState() => _JobsListViewState();
}

class _JobsListViewState extends State<JobsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cases>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        //builder:  lo que pasa mientras carga un  future
        if (snapshot.hasData) {
          //hasData: true si es un valor no nulo//snapshot: los datos??
          //snapshot: Representación inmutable de la interacción más reciente con un cálculo asincrónico.
          List<Cases> data = snapshot.data; //snapshot.data??
          return _jobsListView(data); //
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Cases>> _fetchJobs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final jobsListAPIUrl =
        'https://appserviceisabel.azurewebsites.net/api/students';
    final response = await http.get(jobsListAPIUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((cases) => new Cases.fromJson(cases)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].lastName, data[index].firstName,
              Icons.person, data[index]);
          //lo que muestra
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon, Cases data) =>
      ListTile(
        //lo que muestra

        title: Text(title,
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle,
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontWeight: FontWeight.w500,
              fontSize: 18,
            )),
        leading: Icon(
          icon,
          color: Colors.blueGrey[600],
        ),
        onTap: () {
          //Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute( builder: (BuildContext context) => StudentApp()),(Route<dynamic> route) => false);
          final result = Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailWidget(data)));
        },
      );
}
