import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'firebase_options.dart';

import 'package:choresmate/view/login_screen.dart';

import 'package:choresmate/ui-components/custom-widgets/blue_text.dart';
import 'package:choresmate/ui-components/custom-widgets/custom-button.dart';
import 'package:choresmate/ui-components/custom-widgets/grey_text.dart';
import 'package:choresmate/ui-components/theme.dart';
import 'ui-components/custom-widgets/black_text.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
    // const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'ChoresMates',
      theme: CustomThemeData.themeData,
      home: const LoginScreen(),
    );
  }
}

void initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on Exception catch (e) {
    debugPrint('Failed to initialize firebase $e');
  }
}

