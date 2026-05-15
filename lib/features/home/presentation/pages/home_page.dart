import 'package:flutter/material.dart';

import 'home_page_view.dart';
import 'package:intl/intl.dart';

String resolveTitle(DateTime baseDate, int offset) {
  final date = baseDate.add(Duration(days: offset));

  Intl.defaultLocale = 'de_DE';

  final sameYear = date.year == DateTime.now().year;

  switch (offset) {
    case 0:
      return "Heute";
    case -1:
      return "Gestern";
    case 1:
      return "Morgen";
    case -2:
      return "Vorgestern";
    case 2:
      return "Übermorgen";
    default:
      return sameYear ? DateFormat('E, d. MMM').format(date) : DateFormat('E, d. MMM yyyy').format(date);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int baseIndex = 10000;
  int currentIndex = baseIndex;
  int get offset => currentIndex - baseIndex;
  DateTime baseDate = DateTime.now();

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final PageController _controller = PageController(initialPage: baseIndex);

  void next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void toOffset(int offset) {
    _controller.animateToPage(
      baseIndex + offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void previous() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final dayOffset = index - baseIndex;
          return HomePageView(
            dayOffset: dayOffset,
            title: resolveTitle(baseDate, dayOffset),
            onNext: next,
            onPrevious: previous,
            toOffset: toOffset,
          );
        },
      ),
    );
  }
}
