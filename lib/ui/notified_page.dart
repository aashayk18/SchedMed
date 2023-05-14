import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_to_do_app/ui/theme.dart';
import 'package:flutter_to_do_app/ui/widgets/button.dart';
import 'package:flutter_to_do_app/ui/widgets/button5.dart';
import 'package:flutter_to_do_app/ui/widgets/button6.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  NotifiedPage({Key? key, required this.label}) : super(key: key);
  final _taskController = Get.put(TaskController());

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
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(label.toString().split("|")[0],
                            style: GoogleFonts.alata(
                              textStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Instructions:",
                          style: GoogleFonts.alata(
                              textStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 23)),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          label.toString().split("|")[1],
                          style: GoogleFonts.alata(
                              textStyle: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 25)),
                        ),
                      ),
                      SizedBox(
                        height: 20
                      ),
                      SizedBox(
                        width: 120,
                        child: CompleteButton(label: "Completed", onTap:() => Get.back() ),
                      ),
                      SizedBox(
                          height: 20
                      ),
                      SizedBox (
                        width: 90
                      ),
                      SizedBox (
                        width: 120,
                        child: IgnoreButton(label: "Ignore", onTap:() =>
                            _sendSMS("This is a test message!", ["1234567890", "5556787676"])
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
        ));
  }

  _sendSMS(String message, List<String> recipients) async {
    String _result = await _sendSMS(message, recipients)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          child: Column(children: [
            Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10))),
                 Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
              label: "Task Completed",
              onTap: () {
                _taskController.markTaskCompleted(task.id!);
                Get.back();
              },
              clr: primaryClr,
              context: context,
            ),
          ])),
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color: isClose == true
                      ? Get.isDarkMode
                          ? Colors.grey[600]!
                          : Colors.grey[300]!
                      : clr),
              borderRadius: BorderRadius.circular(20),
              color: isClose == true ? Colors.transparent : clr,
            ),
            child: Center(
              child: Text(
                label,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white),
              ),
            )));
  }
}
