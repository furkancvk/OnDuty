import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'design/app_theme_data.dart';
import 'firebase_options.dart';
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('tr_TR', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "On Duty",
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightTheme(context),
      themeMode: ThemeMode.light,
      darkTheme: AppThemeData.darkTheme(context),
      initialRoute: _auth.currentUser != null ? "home_screen" : "login_screen",
      // routes: routes,
      onGenerateRoute: (settings) {
        return routeTo(settings.name!);
      },
    );
  }
}
