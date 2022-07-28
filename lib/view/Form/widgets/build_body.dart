import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todoalgoriza/components/text_form_app.dart';
import 'package:todoalgoriza/styles/dimensions.dart';
import 'package:todoalgoriza/model/task_model.dart';
import '../../../modules/app_cubit.dart';
import '../../../components/button_app.dart';
import '../../../modules/app_state.dart';
import '../../../styles/colors.dart';
import '../../../styles/strings.dart';

class BuildBody extends StatelessWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController date = TextEditingController();
    TextEditingController start = TextEditingController();
    TextEditingController end = TextEditingController();
    TextEditingController remind = TextEditingController();
    TextEditingController repeat = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, state) {
      return Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(context.height20),
            child: Column(
              children: <Widget>[
                TextFormApp(
                    valid: "Title is required",
                    label: "Title",
                    hint: "Design team meeting",
                    onPressed: () {},
                    type: TextInputType.text,
                    icon: Icons.ice_skating,
                    haveIcon: false,
                    controller: title),
                SizedBox(height: context.height20),
                TextFormApp(
                    label: "Deadline",
                    valid: "Date is required",
                    hint: DateTime.now().toString(),
                    onPressed: () async {
                      await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2030-12-12'))
                          .then((value) {
                        var selectedDate = value.toString().split(' ');
                        date.text = selectedDate[0];
                      });
                    },
                    type: TextInputType.datetime,
                    icon: Icons.keyboard_arrow_down_rounded,
                    haveIcon: true,
                    controller: date),
                SizedBox(height: context.height30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormApp(
                          label: "Start time",
                          valid: "time is required",
                          hint: DateTime.now().hour.toString(),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) => start.text =
                                    value!.format(context).toString());
                          },
                          type: TextInputType.datetime,
                          icon: Icons.access_time,
                          haveIcon: true,
                          controller: start),
                    ),
                    SizedBox(width: context.width30),
                    Expanded(
                      child: TextFormApp(
                          label: "End time",
                          valid: "time is required",
                          hint: DateTime.now().hour.toString(),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) => end.text =
                                    value!.format(context).toString());
                          },
                          type: TextInputType.datetime,
                          icon: Icons.access_time,
                          haveIcon: true,
                          controller: end),
                    ),
                  ],
                ),
                SizedBox(height: context.height20),
                TextFormApp(
                    label: "Remind",
                    valid: "time is required",
                    hint: "10 minutes early",
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: context.height20 * 13,
                              child: ListView.builder(
                                  itemCount: timeSelected.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(timeSelected[index]),
                                      onTap: () {
                                        Navigator.pop(context);
                                        remind.text = timeSelected[index];
                                      },
                                    );
                                  }),
                            );
                          });
                    },
                    type: TextInputType.text,
                    icon: Icons.keyboard_arrow_down_rounded,
                    haveIcon: true,
                    controller: remind),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height15),
                  child: ButtonApp(
                      color: green,
                      text: "Create a Task",
                      onPressed: () {
                        var format = DateFormat("HH:mm aa");
                        var startTime = format.parse(start.text);
                        var endTime = format.parse(end.text);

                        if (endTime.isBefore(startTime)){
                          Fluttertoast.showToast(
                            msg: "end time should after start time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else if (formKey.currentState!.validate()) {
                          BlocProvider.of<AppCubit>(context).addTask(
                            TaskModel(
                              title: title.text,
                              date: date.text,
                              start: start.text,
                              end: end.text,
                              reminder: remind.text,
                              repeat: repeat.text,
                              status: "uncompleted",
                              favourite: "false",
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }),
                ),
              ],
            ),
          ));
    }, listener: (BuildContext context, state) {
      if (state is AppInitialState) {
        debugPrint('InitialState');
      }
    });
  }
}
