import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';


void main() {
  CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [
      HttpHandler(HttpRequestType.post,
          Uri.parse("https://jsonplaceholder.typicode.com/posts"),
          printLogs: true),
      ConsoleHandler()
    ],
  );

  CatcherOptions releaseOptions = CatcherOptions(
    PageReportMode(),
    [
      SentryHandler(
        SentryClient(
          SentryOptions(dsn: "<DSN>"),
        ),
      ),
      ConsoleHandler(),
    ],
  );

  Catcher(
    runAppFunction: () {
      runApp(const MyApp());
    },
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Catcher.navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Catcher example"),
        ),
        body: const ChildWidget(),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  const ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text("Generate error"),
      onPressed: () => generateError(),
    );
  }

  ///Simply just trigger some error.
  void generateError() async {
    Catcher.sendTestException();
  }
}