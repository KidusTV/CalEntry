import 'package:flutter/material.dart';

import '../../../../core/widgets/premium_scaffold.dart';
import '../widgets/search_input.dart';
import '../widgets/search_results_list.dart';
import '../widgets/search_top_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumScaffold(
      body: Column(
        children: [
          SearchTopBar(),
          SearchInput(),
          Expanded(
            child: SearchResultsList(),
          ),
        ],
      ),
    );
  }
}