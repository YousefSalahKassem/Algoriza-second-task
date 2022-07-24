import 'package:flutter/material.dart';
import 'package:todoalgoriza/view/Tasks/screens/all_screen.dart';

import '../../Tasks/screens/complete_screen.dart';
import '../../Tasks/screens/favourite_screen.dart';
import '../../Tasks/screens/uncomplete_screen.dart';

class BuildBody extends StatelessWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        AllTasks(),
        UnCompletedTasks(),
        CompletedTasks(),
        FavoriteTasks(),
      ],
    );
  }
}
