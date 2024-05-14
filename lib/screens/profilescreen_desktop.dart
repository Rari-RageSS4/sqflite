import 'package:flutter/material.dart';
import 'package:sqflite_db/db/model/data_model.dart';
import 'package:sqflite_db/responsive/responsive_layout.dart';
import 'package:sqflite_db/screens/edit_screen.dart';
import 'package:sqflite_db/screens/editscreen_desktop.dart';

class ProfilescreenDesktop extends StatelessWidget {

  final StudentModel data;
  final int index;
  const ProfilescreenDesktop({
    super.key, required this.data, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(255, 169, 63, 255),
        title: const Text('Student Database',
        style: TextStyle(
            color: Colors.white,
            fontSize: 28
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    radius: 90,
                    backgroundImage: NetworkImage('https://purepng.com/public/uploads/large/purepng.com-ninjashinobininjacovert-agentassassinationguerrilla-warfaresamuraiclip-art-1421526960633owjjy.png'),
                  ),
                  Text('Name: ${data.name}',
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
                            builder: (context) => ResponsiveLayout(mobileBody: EditScreen(data: data, index: index), desktopBody: EditscreenDesktop(data: data, index: index)),
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