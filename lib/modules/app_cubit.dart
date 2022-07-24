import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoalgoriza/service/notification.dart';
import '../model/task_model.dart';
import '../service/database_tasks.dart';
import 'dart:math';
import '../util/functions.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  DatabaseTasks dbHelper = DatabaseTasks.db;
  bool? isDark = true;
  String date = DateTime.now().toString().split(' ')[0];

  List<TaskModel> allTasks = [];
  List<TaskModel> unCompletedTasks = [];
  List<TaskModel> doneTasks = [];
  List<TaskModel> favouriteTasks = [];
  List<TaskModel> dailyTasks = [];

  void initDatabase() async {
    await dbHelper.initDatabase();
    getTasks();
    emit(AppDatabaseInitialized());
  }

  void addTask(TaskModel task) async {
    await dbHelper.insertTask(task);
    NotificationApi.scheduleNotification(
        task, getTimeBefore(task), Random().nextInt(10000));
    NotificationApi.scheduleNotification(
        task, getTaskDate(task), Random().nextInt(10000));
    getTasks();
    emit(AppInsertDatabaseState());
  }

  void selectDate(String date) {
    this.date = date;
    getTasks();
    emit(AppSelectDateState());
  }

  void getTasks() async {
    emit(AppGetDatabaseLoadingState());
    final List<TaskModel> tasks = await dbHelper.getTasks();
    allTasks.clear();
    unCompletedTasks.clear();
    doneTasks.clear();
    favouriteTasks.clear();
    dailyTasks.clear();
    allTasks.addAll(tasks);
    unCompletedTasks
        .addAll(tasks.where((task) => task.status == 'uncompleted').toList());
    doneTasks
        .addAll(tasks.where((task) => task.status == 'completed').toList());
    favouriteTasks
        .addAll(tasks.where((task) => task.favourite == 'true').toList());
    dailyTasks.addAll(tasks.where((task) => task.date == date).toList());
    emit(AppGetDatabaseLoadedState());
  }

  void removeTask(TaskModel task) async {
    await dbHelper.deleteTask(task.title!);
    emit(AppDeleteDatabaseState());

    getTasks();
  }

  void updateTask(TaskModel task) async {
    await dbHelper.updateTask(task);
    emit(AppUpdateDatabaseState());
    getTasks();
  }
}
