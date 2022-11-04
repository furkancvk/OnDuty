import 'package:flutter/material.dart';

import 'routes/routes.dart';


void main(){
  runApp(MyApp());
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
      /*theme: AppThemeData.lightTheme(context),
      themeMode: ThemeMode.light,
      darkTheme: AppThemeData.darkTheme(context),*/
      initialRoute: "login_screen",
      routes: routes,
      //supportedLocales: const [Locale("en", "US"), Locale("tr", "TR")],


    );
  }
}
