import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importez Cloud Firestore
import 'create_caissier_page.dart'; // Importe la page de création de caissier

class GestionCaissiersPage extends StatelessWidget {
  const GestionCaissiersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Caissiers'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('caissiers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          // Liste des documents de la collection 'caissiers'
          List<DocumentSnapshot> caissiers = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateCaissierPage()),
                    );
                  },
                  child: const Text('Créer Caissier'),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: caissiers.length,
                    itemBuilder: (context, index) {
                      var caissier = caissiers[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(caissier['nom'] + ' ' + caissier['prenom']),
                        subtitle: Text('Date de naissance: ${caissier['dateNaissance']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Logique pour modifier le caissier sélectionné
                                
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Logique pour supprimer le caissier sélectionné
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Logique pour afficher les détails complets du caissier sélectionné
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
