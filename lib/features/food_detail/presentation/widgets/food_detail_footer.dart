import 'package:flutter/material.dart';

class FoodDetailFooter extends StatefulWidget {
  const FoodDetailFooter({super.key});

  @override
  State<FoodDetailFooter> createState() => _FoodDetailFooterState();
}

class _FoodDetailFooterState extends State<FoodDetailFooter> {
  double amount = 250;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0),
                Colors.black.withValues(alpha: 0.94),
              ],
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            Row(
            children: [
            Expanded(
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white.withValues(alpha: 0.05),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        amount = (amount - 10).clamp(0, 9999);
                      });
                    },
                    child: const Icon(
                      Icons.remove_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: amount),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        amount += 10;
                      });
                    },
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white.withValues(alpha: 0.05),
            ),
            child: const Row(
              children: [
                Text(
                  'Gramm',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white54,
                ),
              ],
            ),
          ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
            onTap: () {},
            child: Container(
                height: 68,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFA56B),
                        Color(0xFFFF7D54),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33FF8A5B),
                        blurRadius: 24,
                        spreadRadius: 2,
                        offset: Offset(0, 12),
                      ),
                    ],
                ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Zum Tagebuch hinzufügen',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
              ],
            ),
          ),
        ),
    );
  }
}