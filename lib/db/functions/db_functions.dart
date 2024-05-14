import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_db/db/model/data_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

class DBFunctions extends ChangeNotifier{
  static final DBFunctions instance = DBFunctions();

  late Database _db; 

  Future<void> initializeDataBase() async{
    if (kIsWeb) {
  // Change default factory on the web
  databaseFactory = databaseFactoryFfiWeb;
}
  _db = await openDatabase('student.db', version: 1, 
                onCreate: (Database db, int version) async{
    await db.execute('CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, phoneNumber TEXT, branch TEXT)');
    });
  }

  Future<void> addStudent(StudentModel studentData) async{
  await _db.rawInsert('INSERT INTO student (name, age, phoneNumber, branch) VALUES (?,?,?,?)', [studentData.name, studentData.age, studentData.phoneNumber, studentData.branch]);
    getAllStudents();
  }

  Future<void> getAllStudents() async{
    final studentDataList = await _db.rawQuery('SELECT * FROM student');
    studentListNotifier.value.clear();
    if(studentDataList.isEmpty){
      studentListNotifier.value = [];
    }else{
      for(var studentData in studentDataList){ 
      final student = StudentModel.fromMap(studentData);
      studentListNotifier.value.add(student);
    }
    }
    studentListNotifier.notifyListeners();
  }

  Future<void> deleteStudent(int id) async{
    await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    getAllStudents();
  }

  Future<void> updateStudent({required StudentModel studentData}) async{
    await _db.rawUpdate('UPDATE student SET name = ?, age = ?, phoneNumber = ?, branch = ? WHERE id = ?',
    [studentData.name, studentData.age, studentData.phoneNumber, studentData.branch, studentData.id! + 1]);
    getAllStudents();
  }
}