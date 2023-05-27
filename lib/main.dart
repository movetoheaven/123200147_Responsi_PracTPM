import 'package:flutter/material.dart';
import 'package:responsi/list_match.dart';

// Nama: Ichvan Rachmawan 
// NIM : 123200147 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListMatch(),
    );
  }
}


