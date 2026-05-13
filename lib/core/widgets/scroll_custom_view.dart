import 'package:calentry/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

List<Widget> join(List<Widget> list, Widget seperator) {
  final result = <Widget>[];
  for (int i = 0; i < list.length; i++) {
    result.add(list[i]);
    if (i != list.length - 1) {
      result.add(seperator);
    }
  }
  return result;
}

class ScrollCustomView extends StatelessWidget {
  final EdgeInsets padding;
  final List<Widget> slivers;

  const ScrollCustomView({super.key, required this.slivers, required this.padding});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = slivers.map((e) => SliverPadding(padding: EdgeInsets.only(left: padding.left, right: padding.right), sliver: e)).toList();
    children = join(children, SliverPadding(padding: EdgeInsets.symmetric(vertical: AppSpacing.md)));
    children.insert(0,SliverPadding(padding: EdgeInsets.only(top: padding.top)));
    children.add(SliverPadding(padding: EdgeInsets.only(bottom: padding.bottom)));

    return CustomScrollView(

      physics: const BouncingScrollPhysics(),
      slivers: children
    );
  }
}
