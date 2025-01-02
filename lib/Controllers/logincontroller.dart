import 'package:get/get.dart';

class Logincontroller extends GetxController{
  var name= ''.obs;
  var password=''.obs;
  compute (sname){
    name.value = sname;
  }
}