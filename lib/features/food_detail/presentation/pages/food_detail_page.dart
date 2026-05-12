import 'package:flutter/material.dart';

import '../../../../core/widgets/premium_scaffold.dart';
import '../widgets/food_detail_footer.dart';
import '../widgets/food_detail_header.dart';
import '../widgets/food_macro_section.dart';

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumScaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(24, 24, 24, 180),
            child: Column(
              children: [
                FoodDetailHeader(),
                SizedBox(height: 28),
                FoodMacroSection(),
              ],
            ),
          ),
          FoodDetailFooter(),
        ],
      ),
    );
  }
}