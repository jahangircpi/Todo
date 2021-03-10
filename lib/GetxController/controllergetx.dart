import 'package:get/get.dart';
import 'package:todo/Global/listofdata.dart';
import 'package:flutter/material.dart';

class ControllerGetx extends GetxController {
  var ListOfData = List<TodoList>().obs;
  var taskcolor = Colors.black.obs;

  var newItem = List<TodoList>().obs;
}
