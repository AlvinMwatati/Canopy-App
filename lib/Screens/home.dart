import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Login2.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/toolscontroller.dart';
import 'package:flutter_application_1/Configs/colors.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Toolscontroller toolsController =
      Get.put(Toolscontroller()); // GetX controller for tools

  @override
  void initState() {
    super.initState();
    toolsController
        .fetchTools(); // Fetch tools from the database on initialization
  }

  @override
  Widget build(BuildContext context) {
    final String username =
        Get.arguments?['username'] ?? 'User'; // Get the username from arguments

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            // Greeting Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello $username!",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                        color: apppurple),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Suggestions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Suggestions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (toolsController.toolsList.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: toolsController.toolsList.length,
                  itemBuilder: (context, index) {
                    var tool = toolsController.toolsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: applavender.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "http://localhost/myApp1/images/${tool.image}",
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 10),
                            Text(
                              tool.toolName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "\Ksh ${tool.toolRentPrice} ", // Displaying the price here
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color:
                                    apppurple, // You can change the color if needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: 20),
            Divider(),

            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (toolsController.toolsList.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              // Example: Split tools by categories (you would need to group them in your backend or model)
              var categories = {
                'Construction': toolsController.toolsList
                    .where((tool) => tool.category == 'Construction')
                    .toList(),
                'Gardening': toolsController.toolsList
                    .where((tool) => tool.category == 'Gardening')
                    .toList(),
                'Cleaning': toolsController.toolsList
                    .where((tool) => tool.category == 'Cleaning')
                    .toList(),
                'Painting': toolsController.toolsList
                    .where((tool) => tool.category == 'Painting')
                    .toList(),
              };

              return Column(
                children: categories.entries.map((category) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          category.key,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: category.value.length,
                          itemBuilder: (context, index) {
                            var tool = category.value[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: applavender.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      "http://localhost/myApp1/images/${tool.image}",
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      tool.toolName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "\$${tool.toolRentPrice} per day", // Price under the name
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: apppurple, // Price color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                    ],
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
