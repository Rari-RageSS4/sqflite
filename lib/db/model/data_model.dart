

class StudentModel{

  int? id;
  final String name;
  final String age;
  final String phoneNumber;
  final String branch;

  StudentModel({
      this.id,
      required this.name,
      required this.age, 
      required this.phoneNumber,
      required this.branch,
    });

  static StudentModel fromMap(Map<String, dynamic> map){ // from db(Map) to class
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final phoneNumber = map['phoneNumber'] as String;
    final branch = map['branch'] as String;

    return StudentModel(id:id, name:name, age:age, phoneNumber: phoneNumber, branch: branch);
  }
}