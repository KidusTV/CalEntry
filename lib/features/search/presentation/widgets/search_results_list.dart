import 'package:flutter/material.dart';

import 'search_result_tile.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 180),
      itemCount: 16,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        return const SearchResultTile();
      },
    );
  }
}