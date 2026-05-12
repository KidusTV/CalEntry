import 'dart:ui';

import 'package:flutter/material.dart';

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
          left: 24,
          right: 24,
          bottom: 14,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 28,
              sigmaY: 28,
            ),
            child: Container(
              height: 86,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: Colors.white.withValues(alpha: 0.06),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    icon: Icons.home_rounded,
                    selected: currentIndex == 0,
                    onTap: () => onChanged(0),
                  ),
                  _NavItem(
                    icon: Icons.insights_rounded,
                    selected: currentIndex == 1,
                    onTap: () => onChanged(1),
                  ),
                  _CenterButton(
                    onTap: () => onChanged(2),
                  ),
                  _NavItem(
                    icon: Icons.restaurant_menu_rounded,
                    selected: currentIndex == 3,
                    onTap: () => onChanged(3),
                  ),
                  _NavItem(
                    icon: Icons.settings_rounded,
                    selected: currentIndex == 4,
                    onTap: () => onChanged(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.white54,
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
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFB36B),
              Color(0xFFFF7D54),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x33FF8A5B),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}