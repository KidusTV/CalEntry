import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

enum MealType { breakfast, lunch, dinner, snack }

class ScannerTopBar extends StatefulWidget {
  final MobileScannerController controller;
  const ScannerTopBar({super.key, required this.controller});

  @override
  State<ScannerTopBar> createState() => _ScannerTopBarState();
}

class _ScannerTopBarState extends State<ScannerTopBar> {
  bool torchEnabled = false;
  late MealType selectedMeal;

  @override
  void initState() {
    super.initState();
    selectedMeal = _getDefaultMealByTime();
  }

  MealType _getDefaultMealByTime() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) return MealType.breakfast;
    if (hour >= 11 && hour < 16) return MealType.lunch;
    if (hour >= 16 && hour < 22) return MealType.dinner;
    return MealType.snack;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Close Button
            _TopBarButton(
              onTap: () => Navigator.of(context).pop(),
              icon: Icons.close_rounded,
            ),

            // Meal Selection Pill
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  children: [
                    _MealOption(
                      label: "Früh",
                      isSelected: selectedMeal == MealType.breakfast,
                      onTap: () => _selectMeal(MealType.breakfast),
                    ),
                    _MealOption(
                      label: "Mittag",
                      isSelected: selectedMeal == MealType.lunch,
                      onTap: () => _selectMeal(MealType.lunch),
                    ),
                    _MealOption(
                      label: "Abend",
                      isSelected: selectedMeal == MealType.dinner,
                      onTap: () => _selectMeal(MealType.dinner),
                    ),
                    _MealOption(
                      label: "Snack",
                      isSelected: selectedMeal == MealType.snack,
                      onTap: () => _selectMeal(MealType.snack),
                    ),
                  ],
                ),
              ),
            ),

            // Torch Button
            _TopBarButton(
              onTap: () async {
                await widget.controller.toggleTorch();
                setState(() {
                  torchEnabled = !torchEnabled;
                });
              },
              icon: torchEnabled ? Icons.flash_on_rounded : Icons.flash_off_rounded,
              isActive: torchEnabled,
            ),
          ],
        ),
      ),
    );
  }

  void _selectMeal(MealType type) {
    if (selectedMeal == type) return;
    HapticFeedback.selectionClick();
    setState(() {
      selectedMeal = type;
    });
  }
}

class _TopBarButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool isActive;

  const _TopBarButton({
    required this.onTap,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: isActive ? 0.2 : 0.08),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class _MealOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _MealOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isSelected ? Colors.white.withValues(alpha: 0.12) : Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.4),
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
