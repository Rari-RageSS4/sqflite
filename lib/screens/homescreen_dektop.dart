import 'package:flutter/material.dart';
import 'package:sqflite_db/db/functions/db_functions.dart';
import 'package:sqflite_db/responsive/responsive_layout.dart';
import 'package:sqflite_db/screens/add_student_widget.dart';
import 'package:sqflite_db/screens/addstudent_desktop.dart';
import 'package:sqflite_db/screens/list_student_widget.dart';
import 'package:sqflite_db/screens/studentlist_desktop.dart';

class HomescreenDesktop extends StatelessWidget {
  const HomescreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    DBFunctions.instance.getAllStudents();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(255, 169, 63, 255),
        title: const Text('Student\'s Database',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42
          ),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
             const ResponsiveLayout(mobileBody: AddStudentWidget(), desktopBody: AddstudentDesktop()),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResponsiveLayout(mobileBody: ListStudentWidget(), desktopBody: StudentlistDesktop()),
                    ),
                  );
                },
                icon: const Icon(Icons.view_agenda),
                label: const Text('View student list'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}