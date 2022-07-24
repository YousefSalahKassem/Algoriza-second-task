import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todoalgoriza/model/task_model.dart';

class NotificationApi {
  static var notifications;
  static String? selectedNotificationPayload;

  static late AndroidInitializationSettings initializationSettingsAndroid;
  static late InitializationSettings initializationSettings;

  static Future init() async {
    notifications = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    initializationSettings = InitializationSettings(
      android: NotificationApi.initializationSettingsAndroid,
    );
    _configureLocalTimezone();
  }

  static Future _notificationDetails(channelId) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        '$channelId',
        '$channelId Notifications',
        channelDescription: '$channelId Description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  static Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    notifications.show(
        id, title, body, await _notificationDetails("channel Id"),
        payload: payload);
  }

  static Future scheduleNotification(
      TaskModel task, DateTime time, int taskChannelId) async {
    notifications = FlutterLocalNotificationsPlugin();
    await notifications.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        selectedNotificationPayload = taskChannelId.toString().trim();
        debugPrint('payload :$selectedNotificationPayload');
      }
    });
    await notifications.zonedSchedule(
        taskChannelId,
        task.title!,
        "You have a Event At ${task.start}",
        _convertTime(time),
        await _notificationDetails(taskChannelId),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _convertTime(DateTime time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  static Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
