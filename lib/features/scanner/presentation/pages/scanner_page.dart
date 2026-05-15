import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/widgets/premium_scaffold.dart';
import '../widgets/camera_scanner.dart';
import '../widgets/scanner_overlay.dart';
import '../widgets/scanner_top_bar.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final controller = MobileScannerController();
  MealType selectedMeal = MealType.snack; // Standardwert

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PremiumScaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraScanner(
              controller: controller,
              // Wir geben die Mahlzeit mit zurück, wenn ein Code erkannt wird
              // onResult: (code) {
              //   Navigator.of(context).pop({
              //     'code': code,
              //     'meal': selectedMeal,
              //   });
              // },
            ),
          ),
          const ScannerOverlay(),
          ScannerTopBar(
            controller: controller,
            // selectedMeal: selectedMeal,
            // onMealChanged: (meal) {
            //   setState(() {
            //     selectedMeal = meal;
            //   });
            // },
          ),
        ],
      ),
    );
  }
}
