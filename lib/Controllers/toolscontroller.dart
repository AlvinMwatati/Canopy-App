import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_application_1/Models/productmodel.dart';

class Toolscontroller extends GetxController {
  var toolsList = <Productmodel>[].obs;
   var filteredToolsList = <Productmodel>[].obs;
   
     get http => null;

  void updateToolsList(List<Productmodel> tools) {
    toolsList.value = tools;
    filteredToolsList.value = tools;
  }

  void filterTools(String query) {
    if (query.isEmpty) {
      filteredToolsList.value = toolsList; 
    } else {
      filteredToolsList.value = toolsList
          .where((tool) =>
              tool.toolName.toLowerCase().contains(query.toLowerCase()))
          .toList(); 
    }
  }

  void fetchTools() async {
    try {
      final response =
          await http.get(Uri.parse("http://localhost/myApp1/getItems.php"));
      if (response.statusCode == 200) {
        var serverData = jsonDecode(response.body);
        var toolsListData = serverData['tools'];

        // Convert the raw data into Productmodel objects
        var tools = List<Productmodel>.from(
            toolsListData.map((tool) => Productmodel.fromJson(tool)));

        // Update the observable list with the fetched tools
        toolsList.value = tools;
      } else {
        print("Failed to fetch tools: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching tools: $e");
    }
  }
}
