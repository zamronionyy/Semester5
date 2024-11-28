import 'package:flutter/material.dart';
import './dependency_management.dart'; // Import file dependency_management.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'management dependescy getx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DependencyManagementPage(), // Ganti LoginPage() dengan DependencyManagementPage()
    );
  }
}