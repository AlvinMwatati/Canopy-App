import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/customTextField.dart';
import 'package:flutter_application_1/Widgets/mySnackbar.dart';
import 'package:get/get.dart';

import '../Configs/colors.dart';
import '../Controllers/registrationcontroller.dart';
import 'package:http/http.dart' as http;

Registrationcontroller registrationcontroller =
    Get.put(Registrationcontroller());
TextEditingController myName1 = TextEditingController();
TextEditingController myName2 = TextEditingController();
TextEditingController myEmail = TextEditingController();
TextEditingController myPhone = TextEditingController();

class Registration extends StatelessWidget {
  final TextEditingController myName1 = TextEditingController();
  final TextEditingController myName2 = TextEditingController();
  final TextEditingController myEmail = TextEditingController();
  final TextEditingController myPhone = TextEditingController();
  final TextEditingController myPass = TextEditingController();

  Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/purple5.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 1000,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/purpleDP.jpg"),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 480,
                      child: DefaultTextStyle(
                        style: TextStyle(fontSize: 14, color: apppurple),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              "Sign up now and start exploring all that we have to offer....",
                              textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto'),
                              speed: Duration(milliseconds: 200),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: myName1,
                      icon: Icons.person_2_rounded,
                      hint: "Enter full name",
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: myName2,
                      icon: Icons.person_2_rounded,
                      hint: "Enter username",
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: myEmail,
                      icon: Icons.email_rounded,
                      hint: "Enter Email Address",
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: myPhone,
                      icon: Icons.phone_rounded,
                      hint: "Enter Phone Number",
                    ),
                    SizedBox(height: 10),
                    MyTextField(
                      controller: myPass,
                      icon: Icons.key,
                      hint: "Enter Password",
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        if (myName1.text.isEmpty) {
                          mySnackbar(
                              title: "Validation",
                              message: "Please enter full name",
                              type: 0);
                        } else if (myName1.text.isNum) {
                          mySnackbar(
                              title: "Validation",
                              message: "Please enter a valid name",
                              type: 0);
                        } else if (myName2.text.isEmpty) {
                          mySnackbar(
                              title: "Validation",
                              message: "Please enter username",
                              type: 0);
                        } else if (myName2.text.isNum) {
                          mySnackbar(
                              title: "Validation",
                              message: "Please enter a valid name",
                              type: 0);
                        } else if (myEmail.text.isEmpty) {
                          mySnackbar(
                              title: "Validation",
                              message: "Please enter email",
                              type: 0);
                        } else if (myPhone.text.isEmpty ||
                            !myPhone.text.isNum) {
                          mySnackbar(
                              title: "Validation",
                              message: "Please enter valid phone number",
                              type: 0);
                        } else {
                          Get.defaultDialog(
                            title: "Register",
                            titleStyle: TextStyle(fontSize: 16, color: appblue),
                            content:
                                Text("Do you want to complete registration"),
                            confirm: TextButton(
                              onPressed: () {
                                Get.offAndToNamed('/login2');
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            cancel: TextButton(
                              onPressed: () {
                                Get.offAndToNamed('/register');
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            barrierDismissible: false,
                          );
                        }
                        final response = await http.get(Uri.parse("http://localhost/myApp1/create_user.php?Fname=${myName1.text}&Uname=${myName2.text}&Email=${myEmail.text}&Phone=${myPhone.text}&Password=${myPass.text}"));
                        
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: appWhite),
                      ),
                    ),
                    SizedBox(height: 11,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?", style: 
                        TextStyle(
                          fontSize: 12,
                        ),),
                        
                        TextButton(onPressed: (){
                           Get.offAndToNamed('/login2');
                        }, 
                        child: 
                        Text("Login",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: apppurple
                        ),))
                      ],
                    )
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      )
    );
  }
}
