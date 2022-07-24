import 'package:flutter/material.dart';
import 'package:todoalgoriza/styles/dimensions.dart';
import 'package:todoalgoriza/util/functions.dart';

import '../../../model/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  VoidCallback onTap;

  TaskItem({Key? key, required this.task, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(context.height10),
        child: ListTile(
          title: Text(task.end!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          subtitle: Text(task.title!,
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.white)),
          trailing: GestureDetector(
            onTap: onTap,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: task.status == "uncompleted"
                  ? Container()
                  : const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    ),
            ),
          ),
          tileColor: context.randomColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.height20),
          ),
        ));
  }
}
