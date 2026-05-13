import 'package:calentry/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/widgets/home_day_header.dart';
import '../constants/app_spacing.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback previous;
  final VoidCallback next;
  final void Function(int) toOffset;

  const CustomAppBar({super.key, required this.title, required this.previous, required this.next, required this.toOffset});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// LEFT
              SizedBox(
                width: 64,
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await showDialog<DateTime>(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.45),
                        builder: (context) {
                          return _CalendarPopup(
                            initialDate: DateTime.now(),
                          );
                        },
                      );

                      if (picked != null) {
                        final now = DateTime.now();

                        final today = DateTime(
                          now.year,
                          now.month,
                          now.day,
                        );

                        final selected = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                        );

                        final offset = selected.difference(today).inDays;

                        toOffset(offset);
                      }
                    },
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 180),
                      tween: Tween(begin: 1, end: 1),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Container(
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
                            BoxShadow(
                              color: Colors.white.withOpacity(0.03),
                              blurRadius: 2,
                              spreadRadius: -1,
                              offset: const Offset(0, 1),
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
                  ),
                ),
              ),


              /// CENTER
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 10,
                  children: [
                    HeaderButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: previous,
                    ),

                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: () => toOffset(0),
                        child: Center(
                          child: Text(
                            title,
                            key: ValueKey(title),
                            style: buildTextTheme(Brightness.dark).bodyLarge,
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


              /// RIGHT
              SizedBox(
                width: 64,
                child: Center(
                  child: Icon(Icons.eighteen_mp),
                ),
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

  const _CalendarPopup({
    required this.initialDate,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 220),
        tween: Tween(begin: 0.92, end: 1),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF171717).withOpacity(0.94),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                surface: const Color(0xFF171717),
                onSurface: Colors.white,
              ),
            ),
            child: CalendarDatePicker(

              initialDate: initialDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
              onDateChanged: (date) {
                Navigator.pop(context, date);
              },
            ),
          ),
        ),
      ),
    );
  }
}