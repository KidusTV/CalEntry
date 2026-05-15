import 'package:flutter/material.dart';

class WaterPicker extends StatelessWidget {
  final FixedExtentScrollController pickerController;
  final int pickerTemporaryValue;
  final Function(int) onSelectedItemChanged;

  static const double _kItemExtent = 44.0;

  const WaterPicker({super.key, required this.pickerController, required this.onSelectedItemChanged, required this.pickerTemporaryValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const ValueKey('picker'),
      width: 120,
      height: 120,
      child: ListWheelScrollView.useDelegate(
        controller: pickerController,
        itemExtent: _kItemExtent,
        perspective: 0.003,
        diameterRatio: 4.0,
        physics: const FixedExtentScrollPhysics(),
        clipBehavior: Clip.none,
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 101,
          builder: (context, index) {
            final value = index * 50;
            final isSelected = value == pickerTemporaryValue;
            return Center(
              child: Text(
                "$value",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isSelected ? 22 : 18,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
                  height: 1.0,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
