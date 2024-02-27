import 'package:flutter/material.dart';
import 'package:sqflite_db/db/functions/db_functions.dart';
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
      title: 'SQflite Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}