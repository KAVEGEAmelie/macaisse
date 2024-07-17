import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'main_page.dart';

class ConfigurationPage extends StatefulWidget {
  final VoidCallback onConfigurationCompleted;

  ConfigurationPage({required this.onConfigurationCompleted});

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateNaissanceController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();

  bool _isUserRegistered = false;

  @override
  void dispose() {
    _emailController.dispose();
    _dateNaissanceController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  bool _isValidDateFormat(String input) {
    final pattern = r'^\d{1,2}/\d{1,2}/\d{4}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(input);
  }

  Future<void> _registerUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String name = _nameController.text.trim();
    String surname = _surnameController.text.trim();
    String dateNaissance = _dateNaissanceController.text.trim();

    if (!_isValidDateFormat(dateNaissance)) {
      _showErrorDialog('Format de Date Incorrect', 'Veuillez saisir une date au format jj/mm/aaaa.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog('Mots de passe ne correspondent pas', 'Veuillez saisir le même mot de passe dans les deux champs.');
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'name': name,
          'surname': surname,
          'dateNaissance': dateNaissance,
          'role': 'caissier',
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isUserRegistered', true);

        setState(() {
          _isUserRegistered = true;
        });

        widget.onConfigurationCompleted();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (e) {
      _showErrorDialog('Erreur d\'Inscription', e.toString());
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: _dateNaissanceController,
                decoration: InputDecoration(labelText: 'Date de Naissance (jj/mm/aaaa)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirmer Mot de passe'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
