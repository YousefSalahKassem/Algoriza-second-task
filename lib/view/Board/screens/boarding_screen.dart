import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/app_cubit.dart';
import '../widgets/board_app_bar.dart';
import '../widgets/build_body.dart';

class BoardingScreen extends StatelessWidget {
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: getAppBar(context),
            body: const BuildBody()
        ),
    );
  }
}
