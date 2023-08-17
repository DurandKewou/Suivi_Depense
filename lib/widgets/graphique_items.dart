import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GraphiqueItems extends StatelessWidget {
  final double pourcentage;
  final IconData icone;
  const GraphiqueItems(
      {super.key, required this.pourcentage, required this.icone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          height: (177*pourcentage) + 3,
          width: 40,
          color: Colors.deepPurple[300],
        ),
        const Gap(14),
        Icon(
          icone,
        ),
      ],
    );
  }
}
