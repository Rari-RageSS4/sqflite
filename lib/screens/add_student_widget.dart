import 'package:flutter/material.dart';
import 'package:sqflite_db/db/functions/db_functions.dart';
import 'package:sqflite_db/db/model/data_model.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _name = TextEditingController();

  final _age = TextEditingController();

  final _phoneNumber = TextEditingController();

  final _branch = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(

                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                        // image: const DecorationImage(
                        //   image: NetworkImage('https://purepng.com/public/uploads/large/purepng.com-ninjashinobininjacovert-agentassassinationguerrilla-warfaresamuraiclip-art-1421526960633owjjy.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        
                      ),
                      child: Image.network('https://purepng.com/public/uploads/large/purepng.com-ninjashinobininjacovert-agentassassinationguerrilla-warfaresamuraiclip-art-1421526960633owjjy.png'),
                    ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter full name';
                } else if (value.contains('12345678910')) {
                  return 'Name must be in letters';
                } else if (value.length < 3) {
                  return 'Name must be atleast 3 character';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10,),
            
      
            TextFormField(
              controller: _age,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your age';
                } else if (value.length > 2) {
                  return 'Enter a valid age';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10,),
      
            TextFormField(
              controller: _phoneNumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone Number'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Phone number';
                } else if (value.length != 10) {
                  return 'Enter a valid phone number';
                } else {
                  return null;
                }
              }
            ),
            const SizedBox(height: 10,),
      
            TextFormField(
              controller: _branch,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Branch'
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your Branch';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 10,),
      
            ElevatedButton.icon(
              onPressed: (){
              onAddStudentButtonClicked();
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Student'),
            ),
          ]
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
  final name = _name.text.trim();
  final age = _age.text.trim();
  final phoneNumber = _phoneNumber.text.trim();
  final branch = _branch.text.trim();

  if(name.isEmpty || age.isEmpty || phoneNumber.isEmpty || branch.isEmpty){
    return;
  }else{
   final student = StudentModel(
      name: name, 
      age: age, 
      phoneNumber: phoneNumber,
      branch: branch,
    );
    
    await DBFunctions.instance.addStudent(student);
    _age.clear();
    _name.clear();
    _phoneNumber.clear();
    _branch.clear();
    setState(() {});
  }
}
}

