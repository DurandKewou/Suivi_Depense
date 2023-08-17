import 'package:flutter/material.dart';

import 'hitoriqueitem.dart';
import '../models/depense.dart';

class Historique extends StatelessWidget {
  final List<Depense> listDepense;
  final Function onDismiss;

  const Historique({super.key, required this.listDepense, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listDepense.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(listDepense[index].id),
          onDismissed: (_) => onDismiss(listDepense[index].id),
          child: HistoriqueItem(
            libelle: listDepense[index].libelle,
            montant: listDepense[index].montant,
            texteDate: listDepense[index].dateFormatee,
            icone: categoryIcons[listDepense[index].categorie]!,
          ),
        ),
      ),
    );
  }
}
