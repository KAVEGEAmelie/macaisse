// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateCaissierPage extends StatefulWidget {
  @override
  _CreateCaissierPageState createState() => _CreateCaissierPageState();
}

class _CreateCaissierPageState extends State<CreateCaissierPage> {
  // Clé pour le formulaire
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Fonction pour créer le caissier dans Firebase
  void _createCaissier() async {
    String nom = _nameController.text.trim();
    String prenom = _surnameController.text.trim();
    String dateNaissance = _dobController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      // Créer l'utilisateur dans Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtenir l'ID de l'utilisateur créé
      String userId = userCredential.user!.uid;

      // Ajouter les informations du caissier à Firestore
      await FirebaseFirestore.instance.collection('caissiers').doc(userId).set({
        'nom': nom,
        'prenom': prenom,
        'dateNaissance': dateNaissance,
        'email': email,
        // Ajoutez d'autres champs selon vos besoins
      });

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Caissier créé avec succès'),
        duration: Duration(seconds: 3),
      ));

      // Naviguer vers la page principale ou toute autre page souhaitée après la création réussie
      Navigator.pop(context); 

    } catch (e) {
      // Gérer les erreurs lors de la création du caissier
      print('Erreur lors de la création du caissier: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erreur lors de la création du caissier: $e'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer Caissier'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Champ de texte pour le nom
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le nom';
                  }
                  return null;
                },
              ),
              // Champ de texte pour le prénom
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le prénom';
                  }
                  return null;
                },
              ),
              // Champ de texte pour la date de naissance
              TextFormField(
                controller: _dobController,
                decoration:
                    InputDecoration(labelText: 'Date de naissance (JJ/MM/AAAA)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer la date de naissance';
                  }
                  final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                  if (!dateRegex.hasMatch(value)) {
                    return 'Veuillez entrer une date valide (JJ/MM/AAAA)';
                  }
                  return null;
                },
              ),
              // Champ de texte pour l'email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer l\'email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
              ),
              // Champ de texte pour le mot de passe
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer le mot de passe';
                  }
                  return null;
                },
              ),
              // Champ de texte pour confirmer le mot de passe
              TextFormField(
                controller: _confirmPasswordController,
                decoration:
                    InputDecoration(labelText: 'Confirmer le mot de passe'),
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
              // Bouton pour soumettre le formulaire
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _createCaissier();
                  }
                },
                child: Text('Créer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
