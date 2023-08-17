import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'graphique.dart';
import 'historique.dart';
import '../models/depense.dart';
import 'nouvelledepende.dart';

class PageAcceuil extends StatefulWidget {
  const PageAcceuil({super.key});

  @override
  State<PageAcceuil> createState() => _PageAcceuilState();
}

class _PageAcceuilState extends State<PageAcceuil> {
  final List<Depense> depenses = [];

  void ajouterdepense(Depense depenseAAjouter) {
    setState(() {
      // on pouvait utiliser depense.insert(0,depenseAAjouter)
      depenses.add(depenseAAjouter);
    });
  }

  

  void supprimerDepense(String id) {
    final aSupprimer = depenses.firstWhere(
      (chaqueDepense) => chaqueDepense.id == id,
    );
    final index = depenses.indexOf(aSupprimer);
    setState(() {
      depenses.remove(aSupprimer);
    });
    //Vous avez supprimer
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Vous avez supprimer cette depense!'),
        action: SnackBarAction(
          label: 'ANNULER',
          onPressed: () {
            setState(() {
              depenses.insert(index, aSupprimer);
            });
          },
        ),
      ),
    );
  }

  void afficherformulaire() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => NouvelleDepense(onAjouter: ajouterdepense));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: const Text('suivi des depense flutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: afficherformulaire,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: depenses.isEmpty ? const Center(
          child: Text('Aucune depense enregistre !'),
        ) :
        Column(children: [
         Graphique(depenses: depenses,),
          const Gap(16),
          Historique(
            listDepense: depenses,
            onDismiss: supprimerDepense,
          ),
        ]),
      ),
    );
  }
}
