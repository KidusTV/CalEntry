import 'package:flutter/material.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';


class HomeItem extends StatelessWidget {
  final bool padding;
  final Widget child;

  const HomeItem({super.key, required this.child, this.padding = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ? const EdgeInsets.symmetric(horizontal: AppSpacing.lg) : EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.10),
              Colors.white.withOpacity(0.04),
            ],
          ),
        ),
        child: child
      )
    );
  }
}
