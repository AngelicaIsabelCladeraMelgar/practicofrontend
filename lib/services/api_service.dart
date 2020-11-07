import 'dart:convert';

import 'package:practicofrontend/models/cases.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ApiService {
  final String apiUrl =
      "https://appserviceisabel.azurewebsites.net/api/students";

  Future<List<Cases>> getCases() async {
    Response res = await get(apiUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cases> cases =
          body.map((dynamic item) => Cases.fromJson(item)).toList();
      return cases;
    } else {
      throw "Failed to load cases list";
    }
  }

  Future<Cases> getCaseById(int studentID) async {
    final response = await get('$apiUrl/$studentID');

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    print(cases);
    Map data = {
      'StudentID': cases.studentID,
      'LastName': cases.lastName,
      'FirstName': cases.firstName,
      'EnrollmentDate':
          DateFormat('yyyy-MM-dd HH:mm:ss').format(cases.enrollmentDate)
    };
    print(data);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

/*final response = await http.get(jobsListAPIUrl, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });*/
  //

  Future<Cases> updateCases(int studentID, Cases cases) async {
    print(cases);
    Map data = {
      'StudentID': cases.studentID,
      'LastName': cases.lastName,
      'FirstName': cases.firstName,
      'EnrollmentDate':
          DateFormat('yyyy-MM-dd HH:mm:ss').format(cases.enrollmentDate)
    };
    print(data);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    final Response response = await put(
      '$apiUrl/$studentID',
      headers: <String, String>{
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 204) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(String studentID) async {
    final String jobsListAPIUrl =
        'https://appserviceisabel.azurewebsites.net/api/students';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    Response res = await delete('$jobsListAPIUrl/$studentID', headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}
