import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formaDeDate = DateFormat.yMd();

const categoryIcons = {
  Categorie.loyer: Icons.house,
  Categorie.maison: Icons.house_siding_sharp,
  Categorie.nourriture: Icons.restaurant,
  Categorie.scolarite: Icons.book,
  Categorie.vehicule: Icons.car_repair_outlined,
  Categorie.vetement: Icons.shopping_cart,
};

enum Categorie {
  nourriture,
  vetement,
  vehicule,
  loyer,
  maison,
  scolarite,
}

class Depense {
  final String id;
  final double montant;
  final DateTime date;
  final String libelle;
  final Categorie categorie;

  Depense(
      {required this.montant,
      required this.libelle,
      required this.date,
      required this.categorie})
      : id = uuid.v4();

  String get dateFormatee {
    return formaDeDate.format(date);
  }
}
