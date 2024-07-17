import 'package:flutter/material.dart';
import 'package:macaisse/caissier_page.dart';
// ignore: unused_import
import 'creation_caisse_page.dart'; // Importe la page de création de caisse à créer

// ignore: use_key_in_widget_constructors
class GestionCaissesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Caisses'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigation pour ajouter une nouvelle caisse
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreationCaissePage()),
                );
              },
              child: const Text('Ajouter Caisse'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Modifier Caisse'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Supprimer Caisse'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreationCaissePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Création de Caisse'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CaissierPage()),
                );
              },
              child: const Text('Créer Caisse Mère avec Jumelles'),
            ),
          ],
        ),
      ),
    );
  }
}
