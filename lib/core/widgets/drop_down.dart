import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown({required this.levelList, required this.onChanged, required this.selectedLevel, this.hintText, super.key});
  final List<String> levelList;
  final String? selectedLevel;
  final void Function(String?)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLevel,
          hint: Text(hintText ?? 'Select Experience Level'),
          isExpanded: true,
          dropdownColor: Colors.white, // Set dropdown menu color
          borderRadius: BorderRadius.circular(8), // Set dropdown menu border radius
          items: levelList.map((String level) {
            return DropdownMenuItem<String>(
              value: level,
              child: Text(level),
            );
          }).toList(),
          onChanged: onChanged,
          // onChanged: (String? newValue) {
          //   setState(() {
          //     selectedExperienceLevel = newValue;
          //   });
          // },
        ),
      ),
    );
  }
}
