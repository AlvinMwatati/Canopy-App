import 'package:flutter/material.dart';
import 'package:get/get.dart';

myDialogue() {
  return Get.defaultDialog(
    title: "",
    content: Text(""),
    confirm: Text("", style: TextStyle()),
    onConfirm: () {},
    cancel: Text("Back"),
    onCancel: () {},
    barrierDismissible: false,
  );
}
