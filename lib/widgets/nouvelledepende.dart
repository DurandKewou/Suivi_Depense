import 'package:depense/models/depense.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

final formateur = DateFormat.yMd();

class NouvelleDepense extends StatefulWidget {
  final Function onAjouter;
  const NouvelleDepense({super.key, required this.onAjouter});

  @override
  State<NouvelleDepense> createState() => _NouvelleDepenseState();
}

class _NouvelleDepenseState extends State<NouvelleDepense> {
  final libeleController = TextEditingController();
  final montantController = TextEditingController();
  DateTime? date;
  var categorieChoisie = Categorie.loyer;

  @override
  void dispose() {
    libeleController.dispose();
    montantController.dispose();
    super.dispose();
  }

  void messageerreur() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Une erreur est survenue'),
        content: const Text('Assurez vous que tous les champs soit remplir'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                  color: Colors.deepPurple[900], fontWeight: FontWeight.bold),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void enregistre() {
    final libeleText = libeleController.text
        .trim(); //cette partie permet d'eliminer les espaces avant le premier et apres le dernier
    final libeleValide = libeleText.isNotEmpty && libeleText.length > 2;

    final montant = double.tryParse(montantController.text);
    var montantValide = false;
    if (montant != null) {
      montantValide = montant > 0 && montant < 1000000000;
    }
    final dateValide = date != null;
    if (libeleValide && montantValide && dateValide) {
      final aEnregitre = Depense(
        montant: montant!,
        libelle: libeleText,
        date: date!,
        categorie: categorieChoisie,
      );
      widget.onAjouter(aEnregitre);
      Navigator.of(context).pop();
    } else {
      messageerreur();
    }
  }

  void affichercalendrier() async {
    final dateChoisie = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (dateChoisie != null) {
      setState(() {
        date = dateChoisie;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nouvelle Depense',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Gap(16 * 2),
          TextField(
            maxLength: 20,
            decoration: const InputDecoration(
              label: Text('libelle'),
            ),
            controller: libeleController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    label: Text('montant'),
                    prefix: Text('FCFA '),
                  ),
                  controller: montantController,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(date != null
                        ? formateur.format(date!)
                        : 'Choisir une date'),
                    IconButton(
                      onPressed: affichercalendrier,
                      icon: const Icon(
                        Icons.date_range,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              DropdownButton<Categorie>(
                value: categorieChoisie,
                items: Categorie.values
                    .map(
                      (e) => DropdownMenuItem<Categorie>(
                        key: ValueKey(e),
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      categorieChoisie = value;
                    });
                  }
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text(
                  'Annuler',
                ),
              ),
              ElevatedButton(
                onPressed: enregistre,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple[900],
                ),
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
