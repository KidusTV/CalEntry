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
        if (codes.isNotEmpty) {
          final String? code = codes.first.rawValue;
          if (code != null) {
            // Stoppe den Scan-Vorgang sofort
            controller.stop();

            // Schließe die Kamera-Ansicht (Pop)
            Navigator.of(context).pop(code);

            // Zeige das Ergebnis kurz an (temporär)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Barcode erkannt: $code'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFFFF6B4A),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      },
    );
  }
}
