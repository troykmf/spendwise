import 'package:flutter/material.dart';

class NewTabBarView extends StatefulWidget {
  const NewTabBarView({Key? key}) : super(key: key);

  @override
  State<NewTabBarView> createState() => _NewTabBarViewState();
}

class _NewTabBarViewState extends State<NewTabBarView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [],
      ),
    );
  }
}
