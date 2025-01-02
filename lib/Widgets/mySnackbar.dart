import 'package:flutter/material.dart';
import 'package:flutter_application_1/Configs/colors.dart';
import 'package:get/get.dart';

mySnackbar({required title, required message, required type}){
  return
    Get.snackbar(title, message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: mainColor,
    colorText: appHoney,
    icon: Icon(
      type ==0? Icons.error:type==1?Icons.check_circle:Icons.info,
      color: Color.fromARGB(255, 0, 0, 0),
      size: 30,
    )
    );

}