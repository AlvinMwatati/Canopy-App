import 'package:flutter_application_1/Screens/Login2.dart';
import 'package:flutter_application_1/Screens/content.dart';
import 'package:flutter_application_1/Screens/login.dart';
import 'package:flutter_application_1/Screens/products.dart';
import 'package:flutter_application_1/Screens/registration.dart';
import 'package:flutter_application_1/Screens/reset.dart';
import 'package:flutter_application_1/Screens/settings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


List<GetPage> routes = [
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/login2', page: () => Login2()),
  GetPage(name: '/register', page: () => Registration()),
  GetPage(name: '/content', page: () => const content()),
  GetPage(name: '/reset', page: () => Reset()),
  GetPage(name:'/products', page: () => Products()),
  GetPage(name: '/settings', page: () => Settings())
];
