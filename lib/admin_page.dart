import 'package:flutter/material.dart';
import 'gestion_caissiers_page.dart'; // Importe la page de gestion des caissiers
// ignore: unused_import
import 'gestion_produits_page.dart'; // Importe la page de gestion des produits
// ignore: unused_import
import 'gestion_caisses_page.dart'; // Importe la page de gestion des caisses
// ignore: unused_import
import 'visualisation_transactions_page.dart'; // Importe la page de visualisation des transactions

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GestionCaissiersPage()),
                );
              },
              child: const Text('Gestion des Caissiers'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GestionProduitsPage()),
                );
              },
              child: const Text('Gestion des Produits'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GestionCaissesPage()),
                );
              },
              child: const Text('Gestion des Caisses'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VisualisationTransactionsPage()),
                );
              },
              child: const Text('Visualisation des Transactions'),
            ),
          ],
        ),
      ),
    );
  }
}

class GestionProduitsPage extends StatelessWidget {
  const GestionProduitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Produits'),
      ),
      body: const Center(
        child: Text('Page de gestion des produits'),
      ),
    );
  }
}

class GestionCaissesPage extends StatelessWidget {
  const GestionCaissesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Caisses'),
      ),
      body: const Center(
        child: Text('Page de gestion des caisses'),
      ),
    );
  }
}

class VisualisationTransactionsPage extends StatelessWidget {
  const VisualisationTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualisation des Transactions'),
      ),
      body: const Center(
        child: Text('Page de visualisation des transactions'),
      ),
    );
  }
}
