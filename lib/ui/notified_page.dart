import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios),
            color: Get.isDarkMode ? Colors.white : Colors.grey),
        title: Text(
          label.toString().split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
            height: 400,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Get.isDarkMode ? Colors.white : Colors.green[900]),
            child: Container(
              child: Row(
                children: [Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          label.toString().split("|")[0],
                          style: GoogleFonts.alata(
                            textStyle: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white,
                                fontSize: 50, fontWeight: FontWeight.bold),
                          )
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Instructions:",
                          style: GoogleFonts.alata(
                              textStyle: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white,
                                  fontSize: 23)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          label.toString().split("|")[1],
                          style: GoogleFonts.alata(
                              textStyle: TextStyle(color: Get.isDarkMode ? Colors.black : Colors.white,
                                  fontSize: 25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ));
  }
}
