import 'package:flutter/material.dart';
import 'package:sqflite_db/db/model/data_model.dart';
import 'package:sqflite_db/screens/edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  //const StudentData({super.key});

  final StudentModel data;
  final int index;
  const ProfileScreen({
    super.key, required this.data, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Database'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage('https://purepng.com/public/uploads/large/purepng.com-ninjashinobininjacovert-agentassassinationguerrilla-warfaresamuraiclip-art-1421526960633owjjy.png'),
                  ),
                  Text('name: ${data.name}',
                  style: const TextStyle(fontSize: 20),
                  ),
                  Text('Age: ${data.age}',
                  style: const TextStyle(fontSize: 20),
                  ),
                  Text('Phone Number: ${data.phoneNumber}',
                  style: const TextStyle(fontSize: 20),
                  ),
                  Text('Branch: ${data.branch}',
                  style: const TextStyle(fontSize: 20),
                  ),
                      
                  const SizedBox(height: 20,),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditScreen(data: data,index: index),
                          ),
                        );
                      },
                      icon: const  Icon(Icons.edit),
                      label: const Text('Update details'),
                  )
                ],
              ),
            ),
          ),
          )),
    );
  }
}