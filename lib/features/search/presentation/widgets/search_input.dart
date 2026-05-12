import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/search_query_provider.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final controller = TextEditingController();

  Timer? debounce;

  @override
  void dispose() {
    controller.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white.withValues(alpha: 0.06),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.04),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              color: Colors.white54,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Suche nach Lebensmitteln...',
                  hintStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
                onChanged: (value) {
                  debounce?.cancel();

                  debounce = Timer(
                    const Duration(milliseconds: 250),
                        () {
                      ref
                          .read(searchQueryProvider.notifier)
                          .state = value;
                    },
                  );
                },
              ),
            ),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
              child: const Icon(
                Icons.mic_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}