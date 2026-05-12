
import 'dart:ui';

import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.75),
            width: 2,
          ),
        ),
        child: Center(
          child: Row(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _line(70),
              _line(100),
              _line(45),
              _line(85),
              _line(110),
              _line(75),
              _line(55),
              _line(85),
              _line(110),
              _line(70),
              _line(45),
              _line(100),
              _line(72),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line(double height) {
    return Container(
      width: 4,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: Colors.white.withValues(alpha: 0.55),
      ),
    );
  }
}