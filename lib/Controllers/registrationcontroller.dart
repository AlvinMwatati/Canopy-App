import 'package:get/get.dart';

class Registrationcontroller extends GetxController{
  var name1= ''.obs;
  var name2= ''.obs;
  var email= ''.obs;
  var phone= ''.obs;


  show(a,b,c,d){
    name1.value = a;
    name2.value = b;
    email.value = c;
    phone.value = d;
  }
}