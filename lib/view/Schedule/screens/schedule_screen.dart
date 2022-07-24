import 'package:flutter/material.dart';
import 'package:todoalgoriza/components/build_app_bar.dart';

import '../widgets/build_body.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Schedule"),
      body: const Buildbody(),
    );
  }
}
