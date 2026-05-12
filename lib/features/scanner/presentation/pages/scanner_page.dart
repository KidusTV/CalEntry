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
            child: CameraScanner(controller: controller),
          ),
          // Positioned.fill(
          //   child: ColoredBox(
          //     color: Colors.black,
          //   ),
          // ),
          ScannerOverlay(),
          ScannerTopBar(
            controller: controller,
          ),
        ],
      ),
    );
  }
}