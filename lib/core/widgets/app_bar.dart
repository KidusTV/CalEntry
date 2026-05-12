import 'package:calentry/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/widgets/home_day_header.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback previous;
  final VoidCallback next;
  final VoidCallback back;

  const CustomAppBar({super.key, required this.title, required this.previous, required this.next, required this.back});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// LEFT
            SizedBox(
              width: 64,
              child: Center(
                child: Icon(Icons.eighteen_mp),
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
                      onDoubleTap: back,
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
    );
  }
}
