import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todoalgoriza/styles/colors.dart';
import 'package:todoalgoriza/styles/dimensions.dart';
import 'package:todoalgoriza/view/Schedule/widgets/task_item.dart';
import '../../../modules/app_cubit.dart';
import '../../../model/task_model.dart';
import '../../../modules/app_state.dart';

class Buildbody extends StatelessWidget {
  const Buildbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      List<TaskModel> tasks = BlocProvider.of<AppCubit>(context).dailyTasks;
      return Column(
        children: <Widget>[
          SizedBox(
            height: context.height10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.height10),
            child: DatePicker(
              DateTime.now(),
              height: 80,
              width: 60,
              initialSelectedDate: DateTime.now(),
              selectionColor: green,
              monthTextStyle: TextStyle(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.grey
                      : Colors.black),
              dayTextStyle: TextStyle(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.grey
                      : Colors.black),
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              onDateChange: (value) {
                var selectedDate = value.toString().split(' ');
                BlocProvider.of<AppCubit>(context).selectDate(selectedDate[0]);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(context.height15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('EEEE').format(
                      DateTime.parse(BlocProvider.of<AppCubit>(context).date)),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  DateFormat.yMMMd().format(
                      DateTime.parse(BlocProvider.of<AppCubit>(context).date)),
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => Dismissible(
                      key: Key(tasks[index].title!),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        BlocProvider.of<AppCubit>(context)
                            .removeTask(tasks[index]);
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.trash,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                BlocProvider.of<AppCubit>(context)
                                    .removeTask(tasks[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                      child: TaskItem(
                          task: tasks[index],
                          onTap: () {
                            BlocProvider.of<AppCubit>(context).updateTask(
                              TaskModel(
                                title: tasks[index].title,
                                date: tasks[index].date,
                                start: tasks[index].start,
                                end: tasks[index].end,
                                reminder: tasks[index].reminder,
                                repeat: tasks[index].repeat,
                                status: "completed",
                              ),
                            );
                          }))))
        ],
      );
    }, listener: (context, state) {
      if (state is AppInitialState) {
        BlocProvider.of<AppCubit>(context).getTasks();
      }
    });
  }
}
