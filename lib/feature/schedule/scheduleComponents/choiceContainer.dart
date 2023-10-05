import 'package:flutter/material.dart';
import 'package:naraakom/config/theme/colors.dart';
import 'package:naraakom/core/widgets/text400normal.dart';

class ChoiceContainer extends StatefulWidget {
  final Function(String) onChoiceSelected;

  const ChoiceContainer({super.key, required this.onChoiceSelected});

  @override
  _ChoiceContainerState createState() => _ChoiceContainerState();
}

class _ChoiceContainerState extends State<ChoiceContainer> {
  String selectedChoice = 'Upcoming';

  void selectChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
    widget.onChoiceSelected(selectedChoice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: homebackgrey,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          ChoiceItem(
            choice: 'Upcoming',
            isSelected: selectedChoice == 'Upcoming',
            onSelect: () => selectChoice('Upcoming'),
          ),
          ChoiceItem(
            choice: 'Completed',
            isSelected: selectedChoice == 'Completed',
            onSelect: () => selectChoice('Completed'),
          ),
          ChoiceItem(
            choice: 'Canceled',
            isSelected: selectedChoice == 'Canceled',
            onSelect: () => selectChoice('Canceled'),
          ),
        ],
      ),
    );
  }
}

class ChoiceItem extends StatelessWidget {
  final String choice;
  final bool isSelected;
  final VoidCallback onSelect;

  const ChoiceItem({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onSelect,
        child: Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.cyan : homebackgrey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: text400normal(
              text: choice, color: isSelected ? cyan : grey, fontsize: 16),
        ),
      ),
    );
  }
}
