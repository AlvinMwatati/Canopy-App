import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:flutter_application_1/Controllers/logincontroller.dart';
import 'package:flutter_application_1/Widgets/customTextField.dart';
import 'package:flutter_application_1/Widgets/mySnackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final store = GetStorage();

Logincontroller logincontroller = Get.put(Logincontroller());
TextEditingController myName = TextEditingController();
TextEditingController myPassword = TextEditingController();

class Login2 extends StatefulWidget {
  @override
  State<Login2> createState() => _LoginState();
}

class _LoginState extends State<Login2> {
  bool _isChecked = false;
  @override
  void initState() {
    super.initState();
    _loadStoredName(); // Load the stored username when the widget initializes
  }

  Future<void> _loadStoredName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString("myName") ?? "";
    setState(() {
      myName.text = storedName;
    });
  }

  Future<void> _storeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("myName", myName.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/purple5.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 1000,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/purpleDP.jpg"),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 20, color: apppurple),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                              "Welcome back to Canopy App ;) ",
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto'),
                              speed: Duration(milliseconds: 400),
                              curve: Curves.bounceInOut),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    controller: myName,
                    icon: Icons.person_2_rounded,
                    hint: "Username/Email",
                  ),
                  SizedBox(height: 20),
                  MyTextField(
                    controller: myPassword,
                    icon: Icons.key,
                    hint: "Password",
                    isPassword: true,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Forgot password",
                        titleStyle: TextStyle(fontSize: 16, color: appblue),
                        content: Text("Do you want to reset password?"),
                        confirm: TextButton(
                          onPressed: () {
                            Get.toNamed('/reset');
                          },
                          child:
                              Text("Reset", style: TextStyle(color: appHoney)),
                        ),
                        cancel: TextButton(
                          onPressed: () {
                            Get.offAndToNamed('/login2');
                          },
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.red)),
                        ),
                        barrierDismissible: false,
                      );
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 14, color: appHoney),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: VerticalDirection.up,
                    
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          remoteLogin();
                          if (myName.text.isEmpty) {
                            mySnackbar(
                              title: "Validation",
                              message: "Please enter your name or email",
                              type: 0,
                            );
                          } else if (myName.text.isNum) {
                            mySnackbar(
                              title: "Validation",
                              message: "Please enter a valid name or email",
                              type: 0,
                            );
                          } else if (myPassword.text.isEmpty) {
                            mySnackbar(
                              title: "Validation",
                              message: "Please enter your password",
                              type: 0,
                            );
                          } else {
                            await _storeName(); // Store the username

                            logincontroller.compute(myName.text);
                          }
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black),
                        ),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: appWhite),
                        ),
                      ),
                      SizedBox(width: 200),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/register');
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                          backgroundColor: WidgetStateProperty.all(appWhite),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isChecked = newValue ?? false;
                            });
                          }),
                      Text(
                        'Remember Me',
                        style: TextStyle(color: apppurple),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Continue with "),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("assets/images/G1.jpg"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("assets/images/X.jpg"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage("assets/images/IN4.jpg"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> remoteLogin() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          "http://localhost/myApp1/login.php?email=${myName.text}&Uname=${myName.text}&password=${myPassword.text}",
        ),
      );

      if (response.statusCode == 200) {
        // Decode the JSON response
        var serverResponse = json.decode(response.body);

        // Extract the login status
        int loginStatus = serverResponse['code'];

        if (loginStatus == 1) {
          print(serverResponse);

          dynamic user_email = serverResponse["userdetails"]["Email"];
          dynamic fname = serverResponse["userdetails"]["Fname"];
          store.write("fname", fname);
          store.write("user_email", user_email);
          Get.offAllNamed('/content', arguments: {'username': myName.text});
          mySnackbar(
            title: "Success",
            message: "Login succesfull",
            type: 1,
          );
        } else {
          mySnackbar(
            title: "Validation",
            message: "Enter valid Email/Username or Password",
            type: 0,
          );
        }
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
