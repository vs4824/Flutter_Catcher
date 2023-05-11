# Flutter Catcher

Catcher is Flutter plugin which automatically catches error/exceptions and handle them. Catcher offers multiple way to handle errors. Catcher is heavily inspired from ACRA: https://github.com/ACRA/acra. Catcher supports Android, iOS, Web, Linux, Windows and MacOS platforms.

## Install

Add this line to your pubspec.yaml:

   ```
   dependencies:
  catcher: ^0.7.0
   ```

Then run this command:

   ```
   $ flutter packages get
   ```

Then add this import:

   ```
   import 'package:catcher/catcher.dart';
   ```

## Basic example

Basic example utilizes debug config with Dialog Report Mode and Console Handler and release config with Dialog Report Mode and Email Manual Handler.

To start using Catcher, you have to:

1. Create Catcher configuration (you can use only debug config at start)

2. Create Catcher instance and pass your root widget along with catcher configuration

3. Add navigator key to MaterialApp or CupertinoApp

Here is complete example:

   ```
   import 'package:flutter/material.dart';
import 'package:catcher/catcher.dart';

main() {
  /// STEP 1. Create catcher configuration. 
  /// Debug configuration with dialog report mode and console handler. It will show dialog and once user accepts it, error will be shown   /// in console.
  CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
      
  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler(["support@email.com"])
  ]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  Catcher(rootWidget: MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions);
}

class MyApp extends StatefulWidget {
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
      /// STEP 3. Add navigator key from Catcher. It will be used to navigate user to report page or to show dialog.
      navigatorKey: Catcher.navigatorKey,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ChildWidget()),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
            child: TextButton(
                child: Text("Generate error"),
                onPressed: () => generateError()));
  }

  generateError() async {
    throw "Test exception";
  }
}
   ```

If you run this code you will see screen with "Generate error" button on the screen. After clicking on it, it will generate test exception, which will be handled by Catcher. Before Catcher process exception to handler, it will show dialog with information for user. This dialog is shown because we have used DialogReportHandler. Once user confirms action in this dialog, report will be send to console handler which will log to console error informations.

   ```
   I/flutter ( 7457): [2019-02-09 12:40:21.527271 | ConsoleHandler | INFO] ============================== CATCHER LOG ==============================
I/flutter ( 7457): [2019-02-09 12:40:21.527742 | ConsoleHandler | INFO] Crash occured on 2019-02-09 12:40:20.424286
I/flutter ( 7457): [2019-02-09 12:40:21.527827 | ConsoleHandler | INFO] 
I/flutter ( 7457): [2019-02-09 12:40:21.527908 | ConsoleHandler | INFO] ------- DEVICE INFO -------
I/flutter ( 7457): [2019-02-09 12:40:21.528233 | ConsoleHandler | INFO] id: PSR1.180720.061
I/flutter ( 7457): [2019-02-09 12:40:21.528337 | ConsoleHandler | INFO] androidId: 726e4abc58dde277
I/flutter ( 7457): [2019-02-09 12:40:21.528431 | ConsoleHandler | INFO] board: goldfish_x86
I/flutter ( 7457): [2019-02-09 12:40:21.528512 | ConsoleHandler | INFO] bootloader: unknown
I/flutter ( 7457): [2019-02-09 12:40:21.528595 | ConsoleHandler | INFO] brand: google
I/flutter ( 7457): [2019-02-09 12:40:21.528694 | ConsoleHandler | INFO] device: generic_x86
I/flutter ( 7457): [2019-02-09 12:40:21.528774 | ConsoleHandler | INFO] display: sdk_gphone_x86-userdebug 9 PSR1.180720.061 5075414 dev-keys
I/flutter ( 7457): [2019-02-09 12:40:21.528855 | ConsoleHandler | INFO] fingerprint: google/sdk_gphone_x86/generic_x86:9/PSR1.180720.061/5075414:userdebug/dev-keys
I/flutter ( 7457): [2019-02-09 12:40:21.528939 | ConsoleHandler | INFO] hardware: ranchu
I/flutter ( 7457): [2019-02-09 12:40:21.529023 | ConsoleHandler | INFO] host: vped9.mtv.corp.google.com
I/flutter ( 7457): [2019-02-09 12:40:21.529813 | ConsoleHandler | INFO] isPsychicalDevice: false
I/flutter ( 7457): [2019-02-09 12:40:21.530178 | ConsoleHandler | INFO] manufacturer: Google
I/flutter ( 7457): [2019-02-09 12:40:21.530345 | ConsoleHandler | INFO] model: Android SDK built for x86
I/flutter ( 7457): [2019-02-09 12:40:21.530443 | ConsoleHandler | INFO] product: sdk_gphone_x86
I/flutter ( 7457): [2019-02-09 12:40:21.530610 | ConsoleHandler | INFO] tags: dev-keys
I/flutter ( 7457): [2019-02-09 12:40:21.530713 | ConsoleHandler | INFO] type: userdebug
I/flutter ( 7457): [2019-02-09 12:40:21.530825 | ConsoleHandler | INFO] versionBaseOs: 
I/flutter ( 7457): [2019-02-09 12:40:21.530922 | ConsoleHandler | INFO] versionCodename: REL
I/flutter ( 7457): [2019-02-09 12:40:21.531074 | ConsoleHandler | INFO] versionIncremental: 5075414
I/flutter ( 7457): [2019-02-09 12:40:21.531573 | ConsoleHandler | INFO] versionPreviewSdk: 0
I/flutter ( 7457): [2019-02-09 12:40:21.531659 | ConsoleHandler | INFO] versionRelase: 9
I/flutter ( 7457): [2019-02-09 12:40:21.531740 | ConsoleHandler | INFO] versionSdk: 28
I/flutter ( 7457): [2019-02-09 12:40:21.531870 | ConsoleHandler | INFO] versionSecurityPatch: 2018-08-05
I/flutter ( 7457): [2019-02-09 12:40:21.532002 | ConsoleHandler | INFO] 
I/flutter ( 7457): [2019-02-09 12:40:21.532078 | ConsoleHandler | INFO] ------- APP INFO -------
I/flutter ( 7457): [2019-02-09 12:40:21.532167 | ConsoleHandler | INFO] version: 1.0
I/flutter ( 7457): [2019-02-09 12:40:21.532250 | ConsoleHandler | INFO] appName: catcher_example
I/flutter ( 7457): [2019-02-09 12:40:21.532345 | ConsoleHandler | INFO] buildNumber: 1
I/flutter ( 7457): [2019-02-09 12:40:21.532426 | ConsoleHandler | INFO] packageName: com.jhomlala.catcherexample
I/flutter ( 7457): [2019-02-09 12:40:21.532667 | ConsoleHandler | INFO] 
I/flutter ( 7457): [2019-02-09 12:40:21.532944 | ConsoleHandler | INFO] ---------- ERROR ----------
I/flutter ( 7457): [2019-02-09 12:40:21.533096 | ConsoleHandler | INFO] Test exception
I/flutter ( 7457): [2019-02-09 12:40:21.533179 | ConsoleHandler | INFO] 
I/flutter ( 7457): [2019-02-09 12:40:21.533257 | ConsoleHandler | INFO] ------- STACK TRACE -------
I/flutter ( 7457): [2019-02-09 12:40:21.533695 | ConsoleHandler | INFO] #0      ChildWidget.generateError (package:catcher_example/file_example.dart:62:5)
I/flutter ( 7457): [2019-02-09 12:40:21.533799 | ConsoleHandler | INFO] <asynchronous suspension>
I/flutter ( 7457): [2019-02-09 12:40:21.533879 | ConsoleHandler | INFO] #1      ChildWidget.build.<anonymous closure> (package:catcher_example/file_example.dart:53:61)
I/flutter ( 7457): [2019-02-09 12:40:21.534149 | ConsoleHandler | INFO] #2      _InkResponseState._handleTap (package:flutter/src/material/ink_well.dart:507:14)
I/flutter ( 7457): [2019-02-09 12:40:21.534230 | ConsoleHandler | INFO] #3      _InkResponseState.build.<anonymous closure> (package:flutter/src/material/ink_well.dart:562:30)
I/flutter ( 7457): [2019-02-09 12:40:21.534321 | ConsoleHandler | INFO] #4      GestureRecognizer.invokeCallback (package:flutter/src/gestures/recognizer.dart:102:24)
I/flutter ( 7457): [2019-02-09 12:40:21.534419 | ConsoleHandler | INFO] #5      TapGestureRecognizer._checkUp (package:flutter/src/gestures/tap.dart:242:9)
I/flutter ( 7457): [2019-02-09 12:40:21.534524 | ConsoleHandler | INFO] #6      TapGestureRecognizer.handlePrimaryPointer (package:flutter/src/gestures/tap.dart:175:7)
I/flutter ( 7457): [2019-02-09 12:40:21.534608 | ConsoleHandler | INFO] #7      PrimaryPointerGestureRecognizer.handleEvent (package:flutter/src/gestures/recognizer.dart:315:9)
I/flutter ( 7457): [2019-02-09 12:40:21.534686 | ConsoleHandler | INFO] #8      PointerRouter._dispatch (package:flutter/src/gestures/pointer_router.dart:73:12)
I/flutter ( 7457): [2019-02-09 12:40:21.534765 | ConsoleHandler | INFO] #9      PointerRouter.route (package:flutter/src/gestures/pointer_router.dart:101:11)
I/flutter ( 7457): [2019-02-09 12:40:21.534843 | ConsoleHandler | INFO] #10     _WidgetsFlutterBinding&BindingBase&GestureBinding.handleEvent (package:flutter/src/gestures/binding.dart:180:19)
I/flutter ( 7457): [2019-02-09 12:40:21.534973 | ConsoleHandler | INFO] #11     _WidgetsFlutterBinding&BindingBase&GestureBinding.dispatchEvent (package:flutter/src/gestures/binding.dart:158:22)
I/flutter ( 7457): [2019-02-09 12:40:21.535052 | ConsoleHandler | INFO] #12     _WidgetsFlutterBinding&BindingBase&GestureBinding._handlePointerEvent (package:flutter/src/gestures/binding.dart:138:7)
I/flutter ( 7457): [2019-02-09 12:40:21.535136 | ConsoleHandler | INFO] #13     _WidgetsFlutterBinding&BindingBase&GestureBinding._flushPointerEventQueue (package:flutter/src/gestures/binding.dart:101:7)
I/flutter ( 7457): [2019-02-09 12:40:21.535216 | ConsoleHandler | INFO] #14     _WidgetsFlutterBinding&BindingBase&GestureBinding._handlePointerDataPacket (package:flutter/src/gestures/binding.dart:85:7)
I/flutter ( 7457): [2019-02-09 12:40:21.535600 | ConsoleHandler | INFO] #15     _rootRunUnary (dart:async/zone.dart:1136:13)
I/flutter ( 7457): [2019-02-09 12:40:21.535753 | ConsoleHandler | INFO] #16     _CustomZone.runUnary (dart:async/zone.dart:1029:19)
I/flutter ( 7457): [2019-02-09 12:40:21.536008 | ConsoleHandler | INFO] #17     _CustomZone.runUnaryGuarded (dart:async/zone.dart:931:7)
I/flutter ( 7457): [2019-02-09 12:40:21.536138 | ConsoleHandler | INFO] #18     _invoke1 (dart:ui/hooks.dart:170:10)
I/flutter ( 7457): [2019-02-09 12:40:21.536271 | ConsoleHandler | INFO] #19     _dispatchPointerDataPacket (dart:ui/hooks.dart:122:5)
I/flutter ( 7457): [2019-02-09 12:40:21.536375 | ConsoleHandler | INFO] 
I/flutter ( 7457): [2019-02-09 12:40:21.536539 | ConsoleHandler | INFO] ======================================================================
```

## Catcher usage

### Adding navigator key 

In order to make work Page Report Mode and Dialog Report Mode, you must include navigator key. Catcher plugin exposes key which must be included in your MaterialApp or WidgetApp:

   ```
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //********************************************
      navigatorKey: Catcher.navigatorKey,
      //********************************************
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ChildWidget()),
    );
  }
   ```

You need to provide this key, because Catcher needs context of navigator to show dialogs/pages. There is no need to include this navigator key if you won't use Page/Dialog Report Mode. You can also provide your own navigator key if need to. You can provide it with Catcher constructor (see below). Please check custom navigator key example to see basic example.

Catcher configuration

Catcher instance needs rootWidget or runAppFunction in setup time. Please provide one of it.

1. rootWidget (optional) - instance of your root application widget

2. runAppFunction (optional) - function where runApp() will be called

3. debugConfig (optional) - config used when Catcher detects that application runs in debug mode

4. releaseConfig (optional) - config used when Catcher detects that application runs in release mode

5. profileConfig (optional) - config used when Catcher detects that application runs in profile mode

6. enableLogger (optional) - enable/disable internal Catcher logs

7. navigatorKey (optional) - provide optional navigator key from outside of Catcher

8. ensureInitialized (optional) - should Catcher run WidgetsFlutterBinding.ensureInitialized() during initialization

   ```
   main() {
   CatcherOptions debugOptions =
   CatcherOptions(DialogReportMode(), [ConsoleHandler()]);
   CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
   EmailManualHandler(["recipient@email.com"])
   ]);
   CatcherOptions profileOptions = CatcherOptions(
   NotificationReportMode(), [ConsoleHandler(), ToastHandler()],
   handlerTimeout: 10000, customParameters: {"example"c: "example_parameter"},);
   Catcher(rootWidget: MyApp(), debugConfig: debugOptions, releaseConfig: releaseOptions, profileConfig: profileOptions, enableLogger: false, navigatorKey: navigatorKey);
   }
   ```

CatcherOptions parameters: handlers - list of handlers, which will process report, see handlers to get more information.
handlerTimeout - timeout in milliseconds, this parameter describes max time of handling report by handler.
reportMode - describes how error report will be shown to user, see report modes to get more information.
localizationOptions - translations used by report modes nad report handlers.
explicitExceptionReportModesMap - explicit report modes map which will be used to trigger specific report mode for specific error.
explicitExceptionHandlersMap - Explicit report handler map which will be used to trigger specific report report handler for specific error.
customParameters - map of additional parameters that will be included in report (for example user id or user name).
handleSilentError - should handle silent errors reported, see FlutterErrorDetails.silent for more details.
screenshotsPath - path where screenshots will be saved.
excludedParameters - parameters which will be excluded from report.
filterFunction - function used to filter errors which shouldn't be handled.

### Report catched exception 

Catcher won't process exceptions catched in try/catch block. You can send exception from try catch block to Catcher:

   ```
   try {
  ...
} catch (error,stackTrace) {
  Catcher.reportCheckedError(error, stackTrace);
}
```