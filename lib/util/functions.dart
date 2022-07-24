import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../model/task_model.dart';
import '../styles/strings.dart';

extension Functions on BuildContext {
  Color get randomColor => colors[Random().nextInt(colors.length)];
}

DateTime getTaskDate(TaskModel task) {
  int year = int.parse(task.date!.split('-')[0]);
  int month = int.parse(task.date!.split('-')[1]);
  int day = int.parse(task.date!.split('-')[2]);
  DateTime date = DateFormat.jm().parse(task.start.toString());
  var time = DateFormat("HH:mm").format(date);
  int hour = int.parse(time.toString().split(':')[0]);
  int minute = int.parse(time.toString().split(':')[1]);
  return DateTime(year, month, day, hour, minute);
}

DateTime getTimeBefore(TaskModel task) {
  DateTime date = getTaskDate(task);
  if (task.reminder == '10 minutes before') {
    return date.subtract(const Duration(minutes: 10));
  } else if (task.reminder == '30 minutes before') {
    return date.subtract(const Duration(minutes: 30));
  } else if (task.reminder == '1 hour before') {
    return date.subtract(const Duration(hours: 1));
  } else if (task.reminder == '1 day before') {
    return date.subtract(const Duration(days: 1));
  } else {
    return date;
  }
}
