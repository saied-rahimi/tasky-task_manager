import 'package:flutter/material.dart';

class LevelDropDown extends StatelessWidget {
  const LevelDropDown({required this.levelList, required this.onChanged, required this.selectedLevel, this.hintText, super.key});
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

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({required this.dropItems, required this.onChanged, required this.selectedItem, this.hintText, this.leadingIcon, super.key});
  final List<String> dropItems;
  final String? selectedItem;
  final void Function(String?)? onChanged;
  final String? hintText;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 60,
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          leadingIcon ?? Container(),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Image.asset(
                  'assets/icons/arrow_down.png',
                  height: 30,
                ),
                value: selectedItem,
                style: TextStyle(color: theme.primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                hint: Text(
                  hintText ?? 'Select an Item',
                ),
                isExpanded: true,
                dropdownColor: Colors.white, // Set dropdown menu color
                borderRadius: BorderRadius.circular(8), // Set dropdown menu border radius
                items: dropItems.map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
