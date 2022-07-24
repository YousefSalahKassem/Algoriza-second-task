import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoalgoriza/modules/app_cubit.dart';
import 'package:todoalgoriza/components/build_app_bar.dart';
import 'package:todoalgoriza/view/Form/widgets/build_body.dart';
import '../../../modules/app_state.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      return Scaffold(
          appBar: buildAppBar(context, 'Add task'),
          body: const BuildBody(),
          resizeToAvoidBottomInset: false);
    }, listener: (context, state) {
      if (state is AppInitialState) {
        debugPrint('AppInitialState');
      }
    });
  }
}
