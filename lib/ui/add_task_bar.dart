import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/ui/theme.dart';
import 'package:flutter_to_do_app/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_to_do_app/ui/widgets/button2.dart';
import 'package:flutter_to_do_app/ui/widgets/button7.dart';
import 'package:flutter_to_do_app/controllers/date_controller.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'package:flutter_to_do_app/services/constants.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: "audio");
  }

  Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');
  }

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  DateTime _selectedDate = DateTime.now();

  String _Time = DateFormat("hh:mm a").format(DateTime.now())..toString();
  int _selectedRemind = 0;
  List<int> remindList = [0, 5, 10, 15, 20];
  String _selectedTypeOfMedicine = "Tab";
  List<String> TypeOfMedicineList = [
    "Tab",
    "Syr",
    "Pdr",
    "Drp(s)",
    "Crm",
    "Ung",
    "Inj"
  ];

  String _selectedQuantity = "tb";
  List<String> QuantityList = ["tb", "ml", "mg", "N/A"];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily"];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    final dateSynchController =
    Get.put(DateSynchController()); // we added a part
    _selectedDate = dateSynchController.dateTime;
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(context),
        body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Reminder",
                        style: headingStyle,
                        textAlign: TextAlign.left,
                      ),
                      MyInputField(
                          title: "Medicine Name ",
                          hint: "Enter medicine name",
                          controller: _titleController),
                      SizedBox(height: 0),
                      MyInputField(
                        title: "Dosage",
                        hint: "Enter medicine dosage",
                        controller: _noteController,
                      ),
                      MyInputField(
                          title: "Instructions",
                          hint: "Record instructions",
                          widget: IconButton(
                              onPressed: () async {
                                if (recorder.isRecording) {
                                  await stopRecorder();
                                  setState(() {});
                                } else {
                                  await startRecord();
                                  setState(() {});
                                }
                              },
                              icon: Icon(
                                  recorder.isRecording ? Icons.stop : Icons.mic,
                                  color: Colors.grey))),
                      Row(children: [
                        Expanded(
                            child: MyInputField(
                                title: "Type",
                                hint: "$_selectedTypeOfMedicine",
                                // controller: _TypeController,
                                widget: DropdownButton(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.grey),
                                  iconSize: 32,
                                  elevation: 4,
                                  style: subTitleStyle,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedTypeOfMedicine = newValue!;
                                    });
                                  },
                                  items: TypeOfMedicineList.map<
                                      DropdownMenuItem<String>>((String? value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value!,
                                            style: TextStyle(color: Colors.grey)));
                                  }).toList(),
                                ))),
                        SizedBox(width: 10),
                        // Expanded(
                        //   child: MyInputField(title: "Dosage", hint: "", controller: _DosageController),
                        // ),
                        SizedBox(width: 10),
                        Expanded(
                            child: MyInputField(
                                title: " ",
                                hint: "$_selectedQuantity",
                                widget: DropdownButton(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.grey),
                                  iconSize: 32,
                                  elevation: 4,
                                  style: subTitleStyle,
                                  underline: Container(
                                    height: 0,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedQuantity = newValue!;
                                    });
                                  },
                                  items: QuantityList.map<DropdownMenuItem<String>>(
                                          (String? value) {
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value!,
                                                style: TextStyle(color: Colors.grey)));
                                      }).toList(),
                                ))),
                      ]),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(height: 18), // done the changes here
                          const Text(
                            "Reference Image",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),

                          SizedBox(height: 25),
                        ],
                      ),

                      // SizedBox(height: 14),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              child: CameraButton(),
                            ),
                            SizedBox(width: 90),
                          ]),

                      Row(children: [
                        Expanded(
                            child: MyInputField(
                                title: "Time",
                                hint: _Time,
                                widget: IconButton(
                                    onPressed: () {
                                      _getTimeFromUser(isStartTime: true);
                                    },
                                    icon: Icon(Icons.access_time_rounded,
                                        color: Colors.grey)))),
                      ]),

                      SizedBox(height: 0),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Expanded(
                              child: MyInputField(
                                  title: "Remind",
                                  hint: "$_selectedRemind minutes early",
                                  widget: DropdownButton(
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey),
                                    iconSize: 32,
                                    elevation: 4,
                                    style: subTitleStyle,
                                    underline: Container(
                                      height: 0,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRemind = int.parse(newValue!);
                                      });
                                    },
                                    items: remindList
                                        .map<DropdownMenuItem<String>>((int value) {
                                      return DropdownMenuItem<String>(
                                          value: value.toString(),
                                          child: Text(value.toString()));
                                    }).toList(),
                                  ))),
                          SizedBox(width: 12),
                          Expanded(
                              child: MyInputField(
                                  title: "Repeat",
                                  hint: "$_selectedRepeat",
                                  widget: DropdownButton(
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey),
                                    iconSize: 32,
                                    elevation: 4,
                                    style: subTitleStyle,
                                    underline: Container(
                                      height: 0,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRepeat = newValue!;
                                      });
                                    },
                                    items: repeatList.map<DropdownMenuItem<String>>(
                                            (String? value) {
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value!,
                                                  style:
                                                  TextStyle(color: Colors.grey)));
                                        }).toList(),
                                  ))),
                        ]),
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _colorPalette(),
                            ThemeButton(
                                label: "Add Reminder",
                                onTap: () {
                                  print(dateSynchController.dateTime);
                                  _validateData(dateSynchController.dateTime);
                                })
                          ])
                    ]))));
  }

  _validateData(DateTime dateTime) {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb(dateTime);
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDb(DateTime dateTime) async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // try {
      //   // Check if the audio is currently being recorded
      //   if (recorder.isRecording) {
      //     // Stop recording and get the file path
      //     final filePath = await stopRecorder();
      //     final file = File(filePath!);
      //
      //     // Generate a unique file name
      //     final fileName = '${DateTime.now().millisecondsSinceEpoch}.m4a';
      //
      //     // Upload the audio file to Firebase Storage
      //     final storageRef = firebase_storage.FirebaseStorage.instance
      //         .ref()
      //         .child('audio')
      //         .child(fileName);
      //     final uploadTask = storageRef.putFile(file);
      //
      //     // Wait for the upload task to complete
      //     await uploadTask;
      //
      //     // Get the download URL of the uploaded file
      //     final downloadURL = await storageRef.getDownloadURL();
      //
      //     audioURL = downloadURL;
      //
      //     // Clean up the local file
      //     file.delete();

          // Continue with saving the task to the database or any other logic
          int value = await _taskController.addTask(
            task: Task(
              note: _selectedTypeOfMedicine+" "+_noteController.text+" "+_selectedQuantity,
              title: _titleController.text,
              date: DateFormat.yMd().format(dateTime),
              startTime: _Time,
              remind: _selectedRemind,
              repeat: _selectedRepeat,
              color: _selectedColor,
              isCompleted: 0,
            ),
          );
          print("My id is $value");
        } else {
          // Audio recording is not in progress
          // print('No audio recording in progress');
        }
    //   } catch (e) {
    //     // Handle any errors that occur during the upload process
    //     print('Error uploading audio: $e');
    //   }
    // } else {
    //   // Display a warning if any required fields are empty
    //   Get.snackbar("Required", "All fields are required!",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.white,
    //       colorText: pinkClr,
    //       icon: Icon(
    //         Icons.warning_amber_rounded,
    //         color: Colors.red,
    //       ));
    // }
  }

  _colorPalette() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Color",
        style: titleStyle,
      ),
      SizedBox(height: 6.0),
      Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                  print("$index");
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                      ? pinkClr
                      : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 16,
                  )
                      : Container(),
                ),
              ),
            );
          }))
    ]);
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )),
      actions: [
        SizedBox(width: 20),
      ],
    );
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_Time.split(":")[0]),
          minute: int.parse(_Time.split(":")[1].split(" ")[0]),
        ));
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formattedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time cancelled.");
    } else if (isStartTime == true) {
      setState(() {
        _Time = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        // _endTime = _formattedTime;
      });
    }
  }
}