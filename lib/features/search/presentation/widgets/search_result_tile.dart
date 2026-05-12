import 'package:flutter/material.dart';

class SearchResultTile extends StatefulWidget {
  const SearchResultTile({super.key});

  @override
  State<SearchResultTile> createState() => _SearchResultTileState();
}

class _SearchResultTileState extends State<SearchResultTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
      lowerBound: 0.97,
      upperBound: 1,
      value: 1,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        controller.reverse();
      },
      onTapUp: (_) {
        controller.forward();
      },
      onTapCancel: () {
        controller.forward();
      },
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.scale(
            scale: controller.value,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'food_image',
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.12),
                            Colors.white.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.fastfood_rounded,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'High Protein Pudding',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ehrmann',
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            _MacroPill(
                              title: '220 kcal',
                            ),
                            SizedBox(width: 8),
                            _MacroPill(
                              title: '20g Protein',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MacroPill extends StatelessWidget {
  final String title;

  const _MacroPill({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white70,
        ),
      ),
    );
  }
}