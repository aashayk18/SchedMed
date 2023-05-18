import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_to_do_app/services/notification_services.dart';
import 'package:flutter_to_do_app/services/theme_services.dart';
import 'package:flutter_to_do_app/ui/theme.dart';
import 'package:flutter_to_do_app/ui/welcome_page.dart';
import 'package:flutter_to_do_app/ui/widgets/button.dart';
import 'package:flutter_to_do_app/ui/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_to_do_app/controllers/date_controller.dart';

import '../controllers/auth_controller.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'add_task_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // List<Reference> references;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    // _onUploadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final dateSynchController = Get.put(DateSynchController());

    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          SizedBox(height: 10),
          _showTasks()
        ],
      ),
    );
  }

  // Future<void> _onUploadComplete() async {
  //   FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  //   ListResult listResult =
  //       await firebaseStorage.ref().child('upload-voice-firebase').list();
  //   setState(() {
  //     references = listResult.items;
  //   });
  // }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              print(_taskController.taskList.length);
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child: Row(children: [
                      GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task))
                    ]))));
              }

              //setting time wiith the 'remind early' functionality

              if (task.date == DateFormat.yMd().format(_selectedDate) &&
                  (task.remind == 0 ||
                      task.remind == 5 ||
                      task.remind == 10 ||
                      task.remind == 15 ||
                      task.remind == 20)) {
                DateTime date =
                    new DateFormat.jm().parse(task.startTime.toString());
                var reminddate = date.subtract(task.remind == 5
                    ? const Duration(days: 0, hours: 0, minutes: 5, seconds: 0)
                    : task.remind == 10
                        ? const Duration(
                            days: 0, hours: 0, minutes: 10, seconds: 0)
                        : task.remind == 15
                            ? const Duration(
                                days: 0, hours: 0, minutes: 15, seconds: 0)
                            : task.remind == 20
                                ? const Duration(
                                    days: 0, hours: 0, minutes: 20, seconds: 0)
                                : const Duration(
                                    days: 0,
                                    hours: 0,
                                    minutes: 00,
                                    seconds: 0));
                var myTime = DateFormat('HH:mm').format(reminddate);
                print(myTime);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);

                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                        child: FadeInAnimation(
                            child: Row(children: [
                      GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task))
                    ]))));
              } else {
                return Container();
              }
              // return GestureDetector(
              //   onTap:() {
              //     _taskController.delete(_taskController.taskList[index]);
              //     _taskController.getTasks();
              //   },
              // );
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: 4),
          height: task.isCompleted == 1
              ? MediaQuery.of(context).size.height * 0.24
              : MediaQuery.of(context).size.height * 0.24,
          color: Get.isDarkMode ? darkGreyClr : Colors.white,
          child: Column(children: [
            Container(
                height: 5,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Get.isDarkMode ? Colors.grey[600] : Colors.grey[300])),
            /*     Spacer(),
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
            ),*/
            _bottomSheetButton(
              label: "Delete Reminder",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context,
            ),
            SizedBox(
              height: 15,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context,
            ),
            SizedBox(
              height: 10,
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

  _addDateBar() {
    final dateSynchController = Get.put(DateSynchController());
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 10),
      child: DatePicker(DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.green,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          dayTextStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)),
          monthTextStyle: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey)), onDateChange: (date) {
        dateSynchController.setDateTime(date);
        print(date.toString());
        setState(() {
          _selectedDate = date;
        });
      }),
    );
  }

  _addTaskBar() {
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: subHeadingStyle,
                  ),
                  Text(
                    "Today",
                    style: headingStyle,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: MyButton(
              label: " + ",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _taskController.getTasks();
              },
            ),
          ),
        ]));
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            var notifyHelper;
            notifyHelper = NotifyHelper();
            notifyHelper.displayNotification(
                title: "Theme Changed",
                body: Get.isDarkMode
                    ? "Activated Light Theme"
                    : "Activated Dark Theme");
          },
          child: Icon(
            Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
          child: PopupMenuButton<String>(
            onSelected: (String value) {
              {
                AuthController.instance.logOut();
              };
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Sign Out',
                child: Text('Sign Out'),
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
