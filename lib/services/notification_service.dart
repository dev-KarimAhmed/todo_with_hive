// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import '../models/task_model.dart';

// class NotifyHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   String selectNotificationPayload = '';
//   final BehaviorSubject<String> selectNotificationSubject =
//       BehaviorSubject<String>();
//   initilaizeNotifications() async {
//     tz.initializeTimeZones();
//     //tz.setLocalLocation(tz.getLocation(timeZoneName));

//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('appicon');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//       onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             macOS: initializationSettingsDarwin,
//             linux: initializationSettingsLinux);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//   }

//   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

//   final LinuxInitializationSettings initializationSettingsLinux =
//       LinuxInitializationSettings(defaultActionName: 'Open notification');

//   void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     // await Get.to(NotificationScreen(
//     //   pyload: payload!,
//     // ));
//   }

//   displayNotifications({required String title, required String body}) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: false);
//     DarwinNotificationDetails iosNotificationDetails =
//         DarwinNotificationDetails();

//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);

//     await flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: 'Default_Sound');
//   }

//   scheduleNotifications(int hour , int minutes , TaskModel task) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         task.id,
//         task.title,
//         task.note,
//        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         _nextInstanceOfTenAM(hour, minutes),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 'your channel id', 'your channel name',
//                 channelDescription: 'your channel description')),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//             matchDateTimeComponents: DateTimeComponents.time,
//             payload: '${task.title}|${task.note}|${task.startTime}',

//             );
//   }

//   tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   requestIosPermession() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           sound: true,
//           alert: true,
//           badge: true,
//         );
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//    // Get.dialog(Text(body!));
//   }

//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String payload) async {
//       debugPrint('My payload is ' + payload);
//       // await Get.to(NotificationScreen(
//       //   pyload: payload,
//       // ));
//     });
//   }
// }

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//    // Instance of Flutternotification plugin
//    static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//       static void initialize() {
//     // Initialization  setting for android
//     const InitializationSettings initializationSettingsAndroid =
//         InitializationSettings(
//             android: AndroidInitializationSettings("@drawable/ic_launcher"));
//     _notificationsPlugin.initialize(
//       initializationSettingsAndroid,
//       // to handle event when we receive notification
//       onDidReceiveNotificationResponse: (details) {
//         if (details.input != null) {}
//       },
//     );
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');
    DarwinInitializationSettings initializationIos =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationIos,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Cannel_id', 'Channel_title',
            priority: Priority.high,
            importance: Importance.high,
            icon: 'flutter_logo',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await notificationsPlugin.show(0, 'Simple Notification',
        'New user send a message', notificationDetails);
  }
}
