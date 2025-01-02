import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:flutter_application_1/Controllers/logincontroller.dart';
import 'package:flutter_application_1/Widgets/customTextField.dart';
import 'package:flutter_application_1/Widgets/mySnackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Logincontroller logincontroller = Get.put(Logincontroller());
TextEditingController myName = TextEditingController();
TextEditingController myPassword = TextEditingController();
//define store value

class Login extends StatelessWidget {
  // getValue()async{
  //  myName.text = await readPref();
  // }

  @override
  Widget build(BuildContext context) {
    //getValue();
    //myName.text = store.read("myName") ?? " ";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/purple2.jpg"),
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
                    backgroundImage: AssetImage("assets/images/OIP.jpg"),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 14, color: apppurple),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "Welcome back to Canopy App ;) ",
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'),
                            speed: Duration(milliseconds: 200),
                            curve: Curves.easeInCubic,
                          ),
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
                        content: Text("Do you want to reset password"),
                        confirm: TextButton(
                          onPressed: () {
                            Get.toNamed('/reset');
                          },
                          child:
                              Text("Reset", style: TextStyle(color: appHoney)),
                        ),
                        cancel: TextButton(
                          onPressed: () {
                            Get.offAndToNamed('/login');
                          },
                          child: Text("Cancel",
                              style: TextStyle(color: Colors.red)),
                        ),
                        barrierDismissible: false,
                      );
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 14, color: appHoney),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      //final SharedPreferences prefs = readPref();
                      //await SharedPreferences.getInstance();
                      //prefs.setString("username", myName.text);
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
                        Get.offAllNamed('/content');
                        logincontroller.compute(myName.text);
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      backgroundColor: WidgetStateProperty.all(appblue),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: appWhite),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                      backgroundColor: WidgetStateProperty.all(appblue),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(color: appWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //readPref() async {
  // final SharedPreferences pref = await SharedPreferences.getInstance();
  // String storedUsername = await pref.getString("myName") ?? "";
  //return storedUsername;
  //}
}
