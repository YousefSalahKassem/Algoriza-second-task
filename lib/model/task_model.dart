import '../styles/strings.dart';

class TaskModel {
  final String? title;
  final String? start;
  final String? end;
  final String? reminder;
  final String? repeat;
  final String? date;
  final String? status;
  final String? favourite;

  TaskModel({
    this.title,
    this.start,
    this.end,
    this.reminder,
    this.repeat,
    this.date,
    this.status,
    this.favourite,
  });

  Map<String, dynamic> toMap() {
    return {
      columnTitle: title ?? "",
      columnStart: start ?? "",
      columnEnd: end ?? "",
      columnReminder: reminder ?? "",
      columnRepeat: repeat ?? "",
      columnStatus: status ?? "",
      columnDate: date ?? "",
      columnFavourite: favourite ?? "",
    };
  }
}
