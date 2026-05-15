import 'dart:ui';
import 'package:calentry/core/constants/app_radius.dart';
import 'package:calentry/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FloatingIslandNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const FloatingIslandNavbar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: AppSpacing.md,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // Der "Island" Hintergrund
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white.withValues(alpha: 0.08),
                    // border: Border.all(
                    //   color: Colors.white.withValues(alpha: 0.12),
                    //   width: 0.5,
                    // ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _NavItem(
                          icon: Icons.grid_view_rounded,
                          label: "Home",
                          selected: currentIndex == 0,
                          onTap: () => onChanged(0),
                        ),
                        _NavItem(
                          icon: Icons.bar_chart_rounded,
                          label: "Stats",
                          selected: currentIndex == 1,
                          onTap: () => onChanged(1),
                        ),
                        _CenterButton(
                          onTap: () => onChanged(2),
                        ),
                        _NavItem(
                          icon: Icons.fastfood_rounded,
                          label: "Food",
                          selected: currentIndex == 3,
                          onTap: () => onChanged(3),
                        ),
                        _NavItem(
                          icon: Icons.person_2_rounded,
                          label: "Profile",
                          selected: currentIndex == 4,
                          onTap: () => onChanged(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Schwebender Center Button (Scanner)

          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          HapticFeedback.selectionClick();
          onTap();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected 
                    ? Colors.white.withValues(alpha: 0.1) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 24,
                color: selected ? Colors.white : Colors.white.withValues(alpha: 0.4),
              ),
            ),
            if (selected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CenterButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CenterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.1) ,
          // gradient: const LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color(0xFFFF8A65), // Warmer Peach-Ton
          //     Color(0xFFFF5722), // Strahlendes Orange
          //   ],
          // ),

          border: Border.all(
            color: Color(0xFFFFB36B),
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
