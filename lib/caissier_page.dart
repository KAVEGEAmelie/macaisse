import 'package:flutter/material.dart';
import 'gestion_caisses_page.dart'; // Importe la page de gestion des caisses à créer

// ignore: use_key_in_widget_constructors
class CaissierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Caissier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue, Caissier!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Gestion des Transactions'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigation pour ouvrir la caisse
              },
              child: const Text('Ouverture de la Caisse'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigation pour fermer la caisse
              },
              child: const Text('Fermeture de la Caisse'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigation pour visualiser les transactions
              },
              child: const Text('Visualisation des Transactions'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigation vers la gestion des caisses
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GestionCaissesPage()),
                );
              },
              child: const Text('Gestion des Caisses'),
            ),
          ],
        ),
      ),
    );
  }
}
