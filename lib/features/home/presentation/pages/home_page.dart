import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

import '../../../../core/widgets/app_bar.dart';
import '../../../scanner/presentation/pages/scanner_page.dart';
import 'home_page_view.dart';
import 'package:intl/intl.dart';

String resolveTitle(DateTime baseDate, int offset) {
  final date = baseDate.add(Duration(days: offset));

  Intl.defaultLocale = 'de_DE';

  String topTitle;
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

  final pages = [
    const HomePage(),
    null, //const SearchPage(),
    const ScannerPage(),
    null,
    null // const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: resolveTitle(baseDate, offset),
          next: next,
          toOffset: toOffset,
          previous: previous,
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        itemBuilder: (context, index) {
          final dayOffset = index - baseIndex;
          return HomePageView(dayOffset: dayOffset);
        },
      )
    );
  }
}