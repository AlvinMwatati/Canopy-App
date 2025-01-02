import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Login2.dart';
import 'package:flutter_application_1/Screens/content.dart';
import 'package:flutter_application_1/Screens/login.dart';
import 'package:flutter_application_1/Screens/registration.dart';
import 'package:flutter_application_1/Screens/reset.dart';
import 'package:get/get.dart';

main() {
  runApp(MyApp());
}

TextEditingController name1 = TextEditingController();
TextEditingController name2 = TextEditingController();

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final List<GetPage> routes = [
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/login2', page: () => Login2()),
    GetPage(name: '/register', page: () => Registration()),
    GetPage(name: '/content', page: () => const content()),
    GetPage(name: '/reset', page: () => Reset()),
  ];

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login2',
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
         
      ),
    );
  }
}
