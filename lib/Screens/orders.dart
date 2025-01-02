import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/ordersmodel.dart';
import 'package:flutter_application_1/Screens/Login2.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [];

  // Fetch orders from the server
  Future<void> fetchOrders() async {
    final response = await http.get(Uri.parse(
      "http://localhost/myApp1/fetchorders.php?user_email=${store.read('user_email')}",
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        setState(() {
          orders = (data['orders'] as List).map((orderData) {
            return Order.fromJson(orderData);
          }).toList();
        });
      } else {
        print("No orders found");
      }
    } else {
      print("Server error");
    }
  }

  // Delete order from the server
  Future<void> deleteOrder(String orderId) async {
    final response = await http.get(
      Uri.parse("http://localhost/myApp1/deleteorder.php?order_id=$orderId"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        setState(() {
          orders.removeWhere((order) => order.orderId == orderId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Order deleted successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete the order.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error. Please try again later.')),
      );
    }
  }

  Future<void> confirmDelete(String orderId) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this order?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text("Delete"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      deleteOrder(orderId);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order History")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: orders.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Order ID: ${order.orderId}'),
                      subtitle: Text(
                          'Amount: ${order.amount} \nCreated At: ${order.createdAt}'),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => confirmDelete(order.orderId),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
