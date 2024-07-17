import 'package:flutter/material.dart';

class CreationCaissePage extends StatefulWidget {
  @override
  _CreationCaissePageState createState() => _CreationCaissePageState();
}

class _CreationCaissePageState extends State<CreationCaissePage> {
  TextEditingController _caisseMereController = TextEditingController();
  List<TextEditingController> _jumelleControllers = [TextEditingController(), TextEditingController()];

  @override
  void dispose() {
    _caisseMereController.dispose();
    for (var controller in _jumelleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addJumelleField() {
    setState(() {
      _jumelleControllers.add(TextEditingController());
    });
  }

  void _removeJumelleField(int index) {
    setState(() {
      if (_jumelleControllers.length > 2) {
        _jumelleControllers[index].dispose();
        _jumelleControllers.removeAt(index);
      }
    });
  }

  void _createCaisse() {
    // Logique pour créer la caisse mère avec ses caisses jumelles
    String caisseMere = _caisseMereController.text;
    List<String> caissesJumelles = _jumelleControllers.map((controller) => controller.text).toList();

    if (caisseMere.isNotEmpty && caissesJumelles.every((jumelle) => jumelle.isNotEmpty)) {
      // Logique de création des caisses (peut-être une requête API ou une sauvegarde locale)
      // Exemple de retour à la page précédente après création
      Navigator.pop(context);
    } else {
      // Affiche une boîte de dialogue si les champs ne sont pas remplis
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erreur'),
          content: Text('Veuillez remplir tous les champs.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Création de Caisse'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _caisseMereController,
                decoration: InputDecoration(labelText: 'Nom de la Caisse Mère'),
              ),
              SizedBox(height: 20),
              Text('Caisses Jumelles:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ..._jumelleControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(labelText: 'Nom de la Caisse Jumelle ${index + 1}'),
                      ),
                    ),
                    if (_jumelleControllers.length > 2) // Affiche le bouton de suppression uniquement si plus de 2 champs
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () => _removeJumelleField(index),
                      ),
                  ],
                );
              }).toList(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addJumelleField,
                child: Text('Ajouter une Caisse Jumelle'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createCaisse,
                child: Text('Créer la Caisse Mère avec ses Jumelles'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
