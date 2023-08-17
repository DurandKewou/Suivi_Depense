import 'package:flutter/material.dart';

import '../models/depense.dart';
import 'graphique_items.dart';

class Graphique extends StatelessWidget {
  final List<Depense> depenses;
  const Graphique({super.key, required this.depenses});

  double sommeDepense() {
    var somme = 0.0;
    for (var depense in depenses) {
      somme = somme + depense.montant;
    }
    return somme;
  }

  double sommeCategorie(Categorie cat) {
    final depensecat = depenses.where(
      (element) => element.categorie == cat,
    );
    var somme = 0.0;
    for (var depense in depensecat) {
      somme = somme + depense.montant;
    }
    return somme;
  }

  @override
  Widget build(BuildContext context) {
    final depensesTotal = sommeDepense();

    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[400],
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...Categorie.values.map(
            (categorie) => GraphiqueItems(
              pourcentage: sommeCategorie(categorie)/depensesTotal,
              icone: categoryIcons[categorie]!,
            ),
          ),
        ],
      ),
    );
  }
}
