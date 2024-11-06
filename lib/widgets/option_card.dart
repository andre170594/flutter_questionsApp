import 'package:flutter/material.dart';
import 'package:my_quesions_app/constants.dart';

class OptionCard extends StatelessWidget {
  final String option;
  final VoidCallback onTap;
  final bool isSelected;

  const OptionCard({
    super.key,
    required this.option,
    required this.onTap,
    required this.isSelected
  });





  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? optSelected: neutral,
        child: ListTile(
            title: Text(
                option,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22.0)),
        ),
      ),
    );
  }
}