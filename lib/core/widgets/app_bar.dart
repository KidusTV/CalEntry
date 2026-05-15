import 'package:flutter/material.dart';

import '../../features/home/presentation/widgets/header_button.dart';
import '../constants/app_spacing.dart';

class SliverCustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback previous;
  final VoidCallback next;
  final void Function(int) toOffset;

  const SliverCustomAppBar({
    super.key,
    required this.title,
    required this.previous,
    required this.next,
    required this.toOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false, // AppBar scrollt weg
      floating: true, // Erscheint sofort beim Hochscrollen
      snap: true, // Schnappt komplett auf beim Hochscrollen
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,

      flexibleSpace: CustomAppBar(
          title: title,
          previous: previous,
          next: next,
          toOffset: toOffset,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback previous;
  final VoidCallback next;
  final void Function(int) toOffset;

  const CustomAppBar({super.key, required this.title, required this.previous, required this.next, required this.toOffset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// LEFT: Kalender
              GestureDetector(
                onTap: () async {
                  final picked = await showDialog<DateTime>(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.45),
                    builder: (context) => _CalendarPopup(initialDate: DateTime.now()),
                  );

                  if (picked != null) {
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    final selected = DateTime(picked.year, picked.month, picked.day);
                    final offset = selected.difference(today).inDays;
                    toOffset(offset);
                  }
                },
                child: Container(
                  width:  44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.09),
                        Colors.white.withOpacity(0.03),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    size: 19,
                    color: Colors.white.withOpacity(0.92),
                  ),
                ),
              ),

              /// CENTER: Navigation
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: Row(
                    children: [
                      HeaderButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: previous,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onDoubleTap: () => toOffset(0),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Text(
                                title,
                                key: ValueKey(title),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      HeaderButton(
                        icon: Icons.arrow_forward_ios_rounded,
                        onTap: next,
                      ),
                    ],
                  ),
                ),
              ),

              /// RIGHT: Platzhalter/Profil
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.09),
                      Colors.white.withOpacity(0.03),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.22),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(Icons.person_outline_rounded, color: Colors.white70)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarPopup extends StatelessWidget {
  final DateTime initialDate;
  const _CalendarPopup({required this.initialDate});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF171717).withOpacity(0.94),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.white,
              surface: Color(0xFF171717),
              onSurface: Colors.white,
            ),
          ),
          child: CalendarDatePicker(
            initialDate: initialDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2035),
            onDateChanged: (date) => Navigator.pop(context, date),
          ),
        ),
      ),
    );
  }
}