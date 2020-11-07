import 'package:flutter/material.dart';
import 'package:practicofrontend/services/api_service.dart';
import 'package:practicofrontend/studentlist.dart';
import 'models/cases.dart';
import 'dart:async';

class AddDataWidget extends StatefulWidget {
  AddDataWidget();

  @override
  _AddDataWidgetState createState() => _AddDataWidgetState();
}

class _AddDataWidgetState extends State<AddDataWidget> {
  _AddDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  final _studentIDController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  final _enrollmentDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cases'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    width: 440,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('StudentID'),
                              TextFormField(
                                controller: _studentIDController,
                                decoration: const InputDecoration(
                                  hintText: 'StudentID',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter full StudentID';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('LastName'),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  hintText: 'LastName',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter full LastName';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('FirstName'),
                              TextFormField(
                                controller: _firstNameController,
                                decoration: const InputDecoration(
                                  hintText: 'FirstName',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter full FirstName';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Text('EnrollmentDate'),
                              TextFormField(
                                controller: _enrollmentDateController,
                                decoration: const InputDecoration(
                                  hintText: 'EnrollmentDate',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter EnrollmentDate';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState.validate()) {
                                    _addFormKey.currentState.save();
                                    api.createCase(Cases(
                                        studentID: int.parse(
                                            _studentIDController.text),
                                        lastName: _lastNameController.text,
                                        firstName: _firstNameController.text,
                                        enrollmentDate: DateTime.parse(
                                            _enrollmentDateController.text)));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.lightBlue[900],
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }

  RefreshIndicatorState() {
    JobsListView();
  }
}
