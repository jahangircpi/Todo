import 'package:get/get.dart';
import 'package:todo/Global/listofdata.dart';
import 'package:flutter/material.dart';
import 'package:todo/Practice/ModelQuran/individualsuramodel.dart';
import 'package:todo/Practice/modelsurah.dart';
import 'package:todo/Practice/servicequran.dart';

class ControllerGetx extends GetxController {
  var ListOfData = List<TodoList>().obs;
  var taskcolor = Colors.black.obs;
  var isclicked = true.obs;
  var newItem = List<TodoList>().obs;
  Rx<Surahlists> surah = Surahlists().obs;
  Rx<IndividualSurah> individual = IndividualSurah().obs;
  var apicalled = ApiQuran();
  Rx su = Surahlists().obs;

  var favoritesuralists = List<Surahlists>().obs;
  @override
  void onInit() {
    apicalled.fetchdata().then((value) {
      surah.value = value;
    });
    apicalled.fetchdata3().then((value) {
      individual.value = value;
    });

    super.onInit();
  }
}
