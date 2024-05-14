import 'package:flutter/material.dart';
import 'package:sqflite_db/screens/homescreen_dektop.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomescreenDesktop(),
    );
  }
}