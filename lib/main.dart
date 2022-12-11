import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_duty/firebase_options.dart';

import 'design/app_theme_data.dart';
import 'routes/routes.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options:DefaultFirebaseOptions.currentPlatform,);
  initializeDateFormatting('tr_TR', null).then((_) => runApp(const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "On Duty",
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme(context),
      themeMode: ThemeMode.light,
      darkTheme: AppThemeData.darkTheme(context),
      initialRoute: "login_screen",
      routes: routes,
    );
  }
}
