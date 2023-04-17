import 'dart:io';
import 'package:flutter_to_do_app/controllers/button4_controller.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../theme.dart';


class Button extends StatelessWidget {
  File? pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  final Button5Controller _buttonController = Get.put(Button5Controller());
 // final Button5Controller _buttonController = Get.find();

  Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: [


         GestureDetector(

               child:Container(
                    width: 150,
                   height: 50,
                     decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: primaryClr
                      ),



                      child: Positioned(
                            bottom: 0,
                             child: InkWell(
                            child: Icon(Icons.camera),
                          onTap: () {
                          print("Camera clicked");
                          showModalBottomSheet(
                            context: context,
                             builder: (context) => bottomSheet(context),
                );
              },
            ),
          ),
               )    )    ,
             ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        children: [
          const Text(
            "Select reference Photo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.image,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                  ],
                ),
                onTap: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
              const SizedBox(
                width: 80,
              ),
              InkWell(
                child: Column(
                  children: const [
                    Icon(
                      Icons.camera,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  takePhoto(ImageSource.camera);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedImage =
    await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    _buttonController.setImagePath(pickedFile!.path);

    Get.back();

    print("pickedFile");
  }
}

