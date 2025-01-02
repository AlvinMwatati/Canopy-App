import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:flutter_application_1/Controllers/dashboardcontroller.dart';
import 'package:flutter_application_1/Screens/home.dart';
import 'package:flutter_application_1/Screens/orders.dart';
import 'package:flutter_application_1/Screens/products.dart';
import 'package:flutter_application_1/Screens/profile.dart';
import 'package:flutter_application_1/Screens/search.dart';
import 'package:flutter_application_1/Screens/settings.dart';
import 'package:get/get.dart';

List myScreens = [
  Home(),
  Orders(),
  Search(),
  Settings(),
  Profile(),
];

DashboardController dashboardController = Get.put(DashboardController());

class content extends StatelessWidget {
  const content({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 250, 250),
      body: Obx(() => myScreens[dashboardController.selectedMenu.value]),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          backgroundColor: const Color.fromARGB(255, 252, 250, 250),
          color: apppurple, // Your custom color
          buttonBackgroundColor: apppurple,
          animationDuration: const Duration(milliseconds: 300),
          items: const [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.trolley, color: Colors.white),
            Icon(Icons.search_rounded, color: Colors.white),
            Icon(Icons.settings, color: Colors.white),
            Icon(Icons.person_3_rounded, color: Colors.white),

          ],
          onTap: (index) {
            dashboardController.updateSelectedMenu(index);
          },
          index: dashboardController.selectedMenu.value,
        ),
      ),
    );
  }
}
