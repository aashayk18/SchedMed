import 'package:get/get.dart';



import 'package:get/state_manager.dart';


class Button5Controller extends GetxController {
  var isImagePathSet = false.obs();
  var imagePath = "".obs;


  void setImagePath(String path) {
    imagePath.value = path;
   // isImagePathSet.value = true;
  }
}


