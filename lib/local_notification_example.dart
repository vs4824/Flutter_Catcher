// import 'package:catcher/catcher.dart';
// import 'package:catcher/model/platform_type.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// void main() {
//   CatcherOptions debugOptions = CatcherOptions(NotificationReportMode(), [
//     EmailManualHandler(["recipient@email.com"]),
//     ConsoleHandler()
//   ]);
//   CatcherOptions releaseOptions = CatcherOptions(PageReportMode(), [
//     EmailManualHandler(["recipient@email.com"])
//   ]);
//
//   Catcher(
//     rootWidget: const MyApp(),
//     debugConfig: debugOptions,
//     releaseConfig: releaseOptions,
//   );
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: Catcher.navigatorKey,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: const ChildWidget(),
//       ),
//     );
//   }
// }
//
// class ChildWidget extends StatelessWidget {
//   const ChildWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         child: const Text("Generate error"), onPressed: () => generateError());
//   }
//
//   void generateError() async {
//     Catcher.sendTestException();
//   }
// }
//
// class NotificationReportMode extends ReportMode {
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//   late Report _lastReport;
//
//   final String channelId;
//   final String channelName;
//   final String channelDescription;
//   final String icon;
//
//   NotificationReportMode(
//       {this.channelId = "Catcher",
//         this.channelName = "Catcher",
//         this.channelDescription = "Catcher default channel",
//         this.icon = "@mipmap/ic_launcher"});
//
//   @override
//   setReportModeAction(ReportModeAction reportModeAction) {
//     _initializeNotificationsPlugin();
//     return super.setReportModeAction(reportModeAction);
//   }
//
//   /// We need to init notifications plugin after constructor. If we init
//   /// in constructor, and there will be 2 catcher options which uses this report
//   /// mode, only notification report mode from second catcher options will be
//   /// initialized correctly. That's why init is delayed.
//   void _initializeNotificationsPlugin() {
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     var initializationSettingsAndroid = AndroidInitializationSettings(icon);
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectedNotification);
//   }
//
//   @override
//   void requestAction(Report report, BuildContext? context) {
//     _lastReport = report;
//     _sendNotification();
//   }
//
//   Future onSelectedNotification(String? payload) {
//     onActionConfirmed(_lastReport);
//     return Future<int>.value(0);
//   }
//
//   void _sendNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         channelId, channelName,
//         channelDescription: channelDescription,
//         importance: Importance.defaultImportance,
//         priority: Priority.defaultPriority);
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//
//     await _flutterLocalNotificationsPlugin.show(
//         0,
//         localizationOptions.notificationReportModeTitle,
//         localizationOptions.notificationReportModeContent,
//         platformChannelSpecifics,
//         payload: "");
//   }
//
//   @override
//   List<PlatformType> getSupportedPlatforms() =>
//       [PlatformType.android, PlatformType.iOS];
// }