import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HistoriqueItem extends StatelessWidget {
  final String libelle;
  final double montant;
  final String texteDate;
  final IconData icone;

  const HistoriqueItem(
      {super.key,
      required this.libelle,
      required this.montant,
      required this.texteDate,
      required this.icone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            libelle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Text(
                '\ $montant FCFA',
              ),
              const Spacer(),
              Icon(icone),
              const Gap(16 / 2),
              Text(texteDate),
            ],
          ),
        ],
      ),
    );
  }
}
