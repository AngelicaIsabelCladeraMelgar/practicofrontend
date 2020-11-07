import 'package:flutter/material.dart';
import 'package:practicofrontend/services/api_service.dart';
import 'models/cases.dart';

class EditDataWidget extends StatefulWidget {
  EditDataWidget(this.cases);

  final Cases cases;

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  _EditDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  int id = 0;
  final _lastNameController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _enrollmentDateController = TextEditingController();

  @override
  void initState() {
    id = widget.cases.studentID;
    _lastNameController.text = widget.cases.lastName;
    _firstNameController.text = widget.cases.firstName;

    _enrollmentDateController.text = widget.cases.enrollmentDate.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Cases'),
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
                              Text('LastName'),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: const InputDecoration(
                                  hintText: 'LastName',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter LastName';
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
                                    return 'Please enter FirstName';
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
                                    api.updateCases(
                                        id,
                                        Cases(
                                            studentID: id,
                                            lastName: _lastNameController.text,
                                            firstName:
                                                _firstNameController.text,
                                            enrollmentDate: DateTime.parse(
                                                _enrollmentDateController
                                                    .text)));

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
}
