import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/controllers/date_controller.dart';
import 'package:flutter_to_do_app/ui/theme.dart';
import 'package:flutter_to_do_app/ui/widgets/button.dart';
import 'package:flutter_to_do_app/ui/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_to_do_app/ui/widgets/button2.dart';
import 'package:flutter_to_do_app/ui/widgets/button3.dart';
import 'package:flutter_to_do_app/ui/widgets/button4.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _DosageController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  String _Time = DateFormat("hh:mm a").format(DateTime.now())..toString();
  int _selectedRemind = 0;
  List<int> remindList = [
    0, 5, 10, 15, 20
  ];
  String _selectedTypeOfMedicine = "" ;
  List<String> TypeOfMedicineList = [
    "Tablet", "Syrup", "Powder", "Drop(s)", "Cream", "Ointment", "Syringe"
  ];

  String _selectedQuantity = "tb";
  List<String> QuantityList = [
    "tb", "ml", "mg", "N/A"
  ];
  String _selectedRepeat = "None";
  List<String> repeatList = [
    "None", "Daily", "Weekly", "Monthly"
  ];
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
                      MyInputField(title: "Medicine Name ", hint: "Enter medicine name", controller: _titleController),
                      SizedBox(height:0),
                      MyInputField(title: "Instructions", hint: "Enter consumption instructions", controller: _noteController),
                      Row(children:[
                        Expanded(
                            child:MyInputField(title: "Type", hint: "$_selectedTypeOfMedicine",

                                widget: DropdownButton(
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.grey
                                  ),
                                  iconSize: 32,
                                  elevation: 4,
                                  style: subTitleStyle,
                                  underline:Container(height:0,),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedTypeOfMedicine = newValue!;
                                    });
                                  },
                                  items:TypeOfMedicineList.map<DropdownMenuItem<String>>((String? value){
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child:Text(value!, style:TextStyle(color:Colors.grey))
                                    );
                                  }
                                  ).toList(),

                                )
                            )),
                        SizedBox(width:10),
                        Expanded(
                          child: MyInputField(title: "Dosage", hint: "", controller: _DosageController),
                        ),
                        SizedBox(width:10) ,
                        Expanded(child:MyInputField(title: " ", hint: "$_selectedQuantity",

                            widget: DropdownButton(
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey

                              ),
                              iconSize: 32,
                              elevation: 4,
                              style: subTitleStyle,
                              underline:Container(height:0,),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedQuantity = newValue!;
                                });
                              },
                              items:QuantityList.map<DropdownMenuItem<String>>((String? value){
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child:Text(value!, style:TextStyle(color:Colors.grey))
                                );
                              }
                              ).toList(),

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

                          SizedBox(width:18),

                          const Text(
                            "Schedule",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(width:10),

                          Icon(Icons.add),
                        ],
                      ),

                      SizedBox(height: 14),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              child: MyButton(label: "+", onTap: () {}),
                            ),
                            SizedBox(width:90),
                            Expanded(
                                child:AfterButton(label: "After Lunch",
                                    onTap: ()=>_validateData(dateSynchController.dateTime))
                            ),
                            SizedBox(width:10),
                            Expanded(child: BeforeButton(label: "Before Dinner", onTap: ()=>_validateData(dateSynchController.dateTime))
                            ),


                          ]),

                      // SizedBox(height:12)   ,
                      //
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: <Widget>[
                      //     Text(
                      //       'Time',
                      //       style: TextStyle(
                      //         fontSize: 17,
                      //       ),
                      //     ),
                      //   ],
                      // )   ,

                      Row(children:[
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


                      SizedBox(height:0),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(children: [
                          Expanded(
                              child:MyInputField(
                                  title: "Remind", hint: "$_selectedRemind minutes early",
                                  widget: DropdownButton(
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey),
                                    iconSize: 32,
                                    elevation: 4,
                                    style: subTitleStyle,
                                    underline:Container(height:0,),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRemind = int.parse(newValue!);
                                      });
                                    },
                                    items:remindList.map<DropdownMenuItem<String>>((int value){
                                      return DropdownMenuItem<String>(
                                          value: value.toString(),
                                          child:Text(value.toString())
                                      );
                                    }
                                    ).toList(),

                                  )
                              )),
                          SizedBox(width:12),
                          Expanded(
                              child: MyInputField(title: "Repeat", hint: "$_selectedRepeat",
                                  widget: DropdownButton(
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey

                                    ),
                                    iconSize: 32,
                                    elevation: 4,
                                    style: subTitleStyle,
                                    underline:Container(height:0,),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedRepeat = newValue!;
                                      });
                                    },
                                    items:repeatList.map<DropdownMenuItem<String>>((String? value){
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child:Text(value!, style:TextStyle(color:Colors.grey))
                                      );
                                    }
                                    ).toList(),

                                  )
                              )),
                        ]),
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _colorPalette(),
                            MyButton(label: "Add Reminder", onTap: (){  
                              //print("looool");
                              print(dateSynchController.dateTime);
                              _validateData(dateSynchController.dateTime);})
                          ]
                      )
                    ]))));
  }

  _validateData(DateTime dateTime) {
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskToDb(dateTime);
      Get.back();
    } else if(_titleController.text.isEmpty||_noteController.text.isEmpty){
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: Icon(Icons.warning_amber_rounded,
            color: Colors.red,
          )
      );
    }
  }

  _addTaskToDb(DateTime dateTime) async {
    int value = await _taskController.addTask(
        task: Task (
          note: _noteController.text,
          title: _titleController.text,
          date: DateFormat.yMd().format(dateTime),

          startTime: _Time,

          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: 0,
        )
    );
    print("My id is " "$value");
  }
  _colorPalette() {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Color",
            style: titleStyle,
          ),
          SizedBox(height: 6.0),
          Wrap(
              children: List<Widget>.generate(
                  3,
                      (int index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          _selectedColor = index;
                          print("$index");
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: index == 0?primaryClr:index==1?pinkClr:yellowClr,
                          child: _selectedColor==index?Icon(Icons.done,
                            color: Colors.white,
                            size: 16,
                          ):Container(),
                        ),
                      ),
                    );
                  }
              )
          )

        ]
    );
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
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("It's null or something is wrong.");
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_Time.split(":")[0]),
          minute: int.parse(_Time.split(":")[1].split(" ")[0]),
        )
    );
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
