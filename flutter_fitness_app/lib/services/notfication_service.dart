import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_native_timezone/flutter_native_timezone.dart';
//import 'package:timezone/data/latest.dart' as tz;
//import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Future initNotification() async {
  //   //_configureLocalTimeZone();
  //   AndroidInitializationSettings androidInitializationSettings =
  //       const AndroidInitializationSettings('barbell');

  //   var iosInitializationSettings = DarwinInitializationSettings(
  //       requestAlertPermission: true,
  //       requestBadgePermission: true,
  //       requestSoundPermission: true,
  //       onDidReceiveLocalNotification:
  //           (int id, String? title, String? body, String? payload) async {});

  //   var initializationSettings = InitializationSettings(
  //       android: androidInitializationSettings, iOS: iosInitializationSettings);

  //   await notificationsPlugin.initialize(initializationSettings,
  //       onDidReceiveNotificationResponse:
  //           (NotificationResponse notificationResponse) async {});
  // }

  // notificationDetails() {
  //   return const NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName',
  //           importance: Importance.max, priority: Priority.high),
  //       iOS: DarwinNotificationDetails());
  // }

  // Future showNotification(
  //     {int id = 0, String? title, String? body, String? payLoad}) async {
  //   return notificationsPlugin.show(
  //       id, title, body, await notificationDetails());
  // }

  // Future _configureLocalTimeZone() async {
  //   tz.initializeTimeZones();
  //   //final String timezone = await FlutterNativeTimezone.getLocalTimezone();
  //   //tz.setLocalLocation(tz.getLocation(timezone));
  // }

  // Future scheduleNotification(
  //     {int id = 1,
  //     String? title,
  //     String? body,
  //     String? payLoad,
  //     required DateTime scheduledNotificationDateTime}) async {
  //   var a = tz.local;
  //   return notificationsPlugin.zonedSchedule(
  //       id,
  //       title,
  //       body,
  //       tz.TZDateTime.from(
  //         scheduledNotificationDateTime.add(Duration(
  //             hours: scheduledNotificationDateTime.timeZoneOffset.inHours)),
  //         tz.getLocation('Europe/Minsk'),
  //       ),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('channelId', 'channelName',
  //               importance: Importance.max, priority: Priority.high),
  //           iOS: DarwinNotificationDetails()),
  //       // ignore: deprecated_member_use
  //       androidAllowWhileIdle: true,
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  Future<bool> instantNotify(String title, String body) async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return awesomeNotifications.createNotification(
        content: NotificationContent(
            id: Random().nextInt(0x7FFFFFF1),
            channelKey: "instant_notifications",
            title: title,
            body: body));
  }

  Future<bool> scheduleNotification(
      String title, String body, DateTime dateTime, int id) async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return await awesomeNotifications.createNotification(
        schedule: NotificationCalendar(
            day: dateTime.day,
            month: dateTime.month,
            hour: dateTime.hour,
            minute: dateTime.minute,
            second: dateTime.second),
        content: NotificationContent(
            id: id,
            channelKey: "scheduled_notifications",
            title: title,
            body: body));
  }

  Future<void> cancelScheduledNotification(int id) async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    await awesomeNotifications.cancel(id);
  }
}
