import 'package:flutter/material.dart';
import 'counter.dart';
import 'infouser.dart';
import 'pages_authorization.dart';
import 'registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Сохранение и загрузка данных',
        initialRoute: '/',
        routes: {
          '/': (context) => Pagesauthorization(),
          '/ registration': (context) => const Registration(),
          '/ counter': (context) => const Counter(),
          '/ infoUser': (context) => InfoUser(),
        });
  }
}
