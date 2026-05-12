import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CameraScanner extends StatelessWidget {
  final MobileScannerController controller;

  const CameraScanner({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (capture) {
        final codes = capture.barcodes;

        for (final code in codes) {
          debugPrint(code.rawValue);
        }
      },
    );
  }
}
