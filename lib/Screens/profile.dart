import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Replace this with your color configuration

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                        image: AssetImage(
                            'assets/images/purple2.jpg'), // Replace with your asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Gldays Kingi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "gkingi@mail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: apppurple,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Update Profile"),
                ),
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                title: "Logout",
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: () {
                  Get.defaultDialog(
                    title: "LOGOUT",
                    titleStyle: const TextStyle(fontSize: 20),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Are you sure you want to logout?"),
                    ),
                    confirm: ElevatedButton(
                      onPressed: () {
                        // Replace with your logout logic
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        side: BorderSide.none,
                      ),
                      child: const Text("Yes"),
                    ),
                    cancel: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("No"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy class for UpdateProfileScreen
class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: const Center(child: Text("Update Profile Screen")),
    );
  }
}

// Profile Menu Widget
class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final Color? textColor;
  final bool endIcon;

  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textColor,
    this.endIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Icon(icon, color: apppurple),
      title: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.black),
      ),

    );
  }
}
