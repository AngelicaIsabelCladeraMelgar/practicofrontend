class Cases {
  final int studentID;
  final String lastName;
  final String firstName;
  final DateTime enrollmentDate;

  Cases({this.studentID, this.lastName, this.firstName, this.enrollmentDate});

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      studentID: json['StudentID'],
      lastName: json['LastName'],
      firstName: json['FirstName'],
      enrollmentDate: DateTime.parse(json['EnrollmentDate']),
    );
  }

  /*@override
  String toString() {
    return 'Trans{id: $id, name: $name, age: $age}';
  }*/
}
