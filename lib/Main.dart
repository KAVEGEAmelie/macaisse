// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importer Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_page.dart';
import 'configuration_page.dart';
import 'login_page.dart'; // Importer la nouvelle page de connexion
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ma Caisse',
      theme: ThemeData(
        primaryColor: Colors.purple[200],
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainPage(),
    );
  }
}