import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoalgoriza/styles/dimensions.dart';
import '../../../modules/app_cubit.dart';
import '../../../components/button_app.dart';
import '../../../modules/app_state.dart';
import '../../../styles/colors.dart';
import '../../../model/task_model.dart';
import '../../../util/routes.dart';
import '../../Form/screens/form_screen.dart';
import '../widgets/task_item.dart';

class CompletedTasks extends StatelessWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(builder: (context, state) {
      List<TaskModel> tasks = BlocProvider.of<AppCubit>(context).doneTasks;

      return Column(
        children: [
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
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
                              favourite: tasks[index].favourite,
                            ),
                          );
                        },
                        onPressed: () {
                          BlocProvider.of<AppCubit>(context).updateTask(
                            TaskModel(
                              title: tasks[index].title,
                              date: tasks[index].date,
                              start: tasks[index].start,
                              end: tasks[index].end,
                              reminder: tasks[index].reminder,
                              repeat: tasks[index].repeat,
                              status: tasks[index].status,
                              favourite: "true",
                            ),
                          );
                        },
                      )))),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.height15),
            child: ButtonApp(
                color: green,
                text: "Add a Task",
                onPressed: () {
                  AppRoute.push(const FormScreen(), name: "form");
                }),
          ),
        ],
      );
    }, listener: (context, state) {
      if (state is AppInitialState) {
        debugPrint('AppInitialState');
      }
    });
  }
}
