import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSynchController extends GetxController {
  DateTime dateTime = DateTime.now();

  void setDateTime(DateTime date) {
    dateTime = date;
    update();
  }
}
