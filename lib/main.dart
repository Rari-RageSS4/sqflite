import 'package:flutter/material.dart';
import 'package:sqflite_db/db/functions/db_functions.dart';
import 'package:sqflite_db/responsive/desktop_body.dart';
import 'package:sqflite_db/responsive/mobile_body.dart';
import 'package:sqflite_db/responsive/responsive_layout.dart';
//import 'package:sqflite_db/db/model/data_model.dart';
import 'package:sqflite_db/screens/home_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBFunctions.instance.initializeDataBase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQflite Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ResponsiveLayout(desktopBody: const DesktopBody(), mobileBody: const MobileBody(),),
    );
  }
}