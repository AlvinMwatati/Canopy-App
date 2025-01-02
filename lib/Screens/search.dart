import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:flutter_application_1/Controllers/toolscontroller.dart';
import 'package:flutter_application_1/Models/productmodel.dart';
import 'package:flutter_application_1/Screens/Login2.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Toolscontroller toolsController = Get.put(Toolscontroller());

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // Text editing controller for search
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTools(); // Fetch tools from the server once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: apppurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                toolsController.filterTools(query);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    toolsController.filterTools('');
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() => Column(
            children: [
              Text(
                "Our Inventory",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: toolsController.filteredToolsList.length,
                  itemBuilder: (context, index) {
                    dynamic tool = toolsController.filteredToolsList[index];
                    // Assuming image URL is stored in tool.image
                    return Row(
                      children: [
                        Image.network(
                          "http://localhost/myApp1/images/${tool.image}",
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Divider(),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tool.toolName, style: TextStyle(fontSize: 16)),
                            Text(tool.toolDesc,
                                style: TextStyle(color: Colors.grey)),
                            Text("Ksh ${tool.toolRentPrice}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () async {
                            // Show a confirmation dialog
                            bool? confirmOrder = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Order'),
                                  content: Text(
                                      'Are you sure you want to place this order?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            false); // Close the dialog with 'false' if Cancel is pressed
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(
                                            true); // Close the dialog with 'true' if Confirm is pressed
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmOrder == true) {
                              try {
                                // Proceed with placing the order only if the user confirmed
                                final response = await http.get(Uri.parse(
                                    "http://localhost/myApp1/orders.php?product_id=${tool.id}&amount=${tool.toolRentPrice}&user_email=${store.read('user_email')}"));

                                if (response.statusCode == 200) {
                                  dynamic serverData =
                                      jsonDecode(response.body);

                                  // Check the success key and show Snackbar accordingly
                                  if (serverData["success"] == 1) {
                                    if (mounted) {
                                      Get.snackbar("Success",
                                          "We have received your order");
                                    }
                                  } else {
                                    if (mounted) {
                                      Get.snackbar(
                                          "Error", "Order creation failed");
                                    }
                                  }
                                } else {
                                  if (mounted) {
                                    Get.snackbar(
                                        "Error", "Order could not be created");
                                  }
                                }
                              } catch (e) {
                                print("Error: $e"); // Log error to console
                                if (mounted) {
                                  Get.snackbar("Error",
                                      "An unexpected error occurred: $e");
                                }
                              }
                            }
                          },
                          child: Text(
                            "Order",
                            style: TextStyle(color: appWhite),
                          ),
                          color: applavender,
                        )

                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  getTools() async {
    try {
      final response =
          await http.get(Uri.parse("http://localhost/myApp1/getItems.php"));
      if (response.statusCode == 200) {
        var serverData = jsonDecode(response.body);
        print("Server Data: $serverData");

        var toolsListData = serverData['tools'];
        print("Tools List Data: $toolsListData");

        toolsListData.forEach((tool) {
          print("Tool: $tool");
          print("ID Type: ${tool['ID'].runtimeType}");
          print("toolRentPrice Type: ${tool['toolRentPrice'].runtimeType}");
        });

        var tools = List<Productmodel>.from(
            toolsListData.map((tool) => Productmodel.fromJson(tool)));

        toolsController.updateToolsList(tools);
      } else {
        Get.snackbar("Error", "Failed to fetch tools: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception occurred: $e");
    }
  }
}
