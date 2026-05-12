import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerTopBar extends StatefulWidget {
  final MobileScannerController controller;
  const ScannerTopBar({super.key, required this.controller});

  @override
  State<ScannerTopBar> createState() => _ScannerTopBarState();
}

class _ScannerTopBarState extends State<ScannerTopBar> {
  bool torchEnabled = false;

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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: torchEnabled ? 0.7 : 0.08),
              ),

              child: IconButton(
                onPressed: () async {
                  await widget.controller.toggleTorch();
                  setState(() {torchEnabled = !torchEnabled;});
                },
                icon: Icon(
                  torchEnabled
                      ? Icons.flash_on
                      : Icons.flash_off,
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}