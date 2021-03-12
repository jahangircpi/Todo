import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/GetxController/controllergetx.dart';

class detailspage extends StatelessWidget {
  var detailscontroller = Get.put(ControllerGetx());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: ListView.builder(
          itemCount: detailscontroller.individual.value.data.ayahs.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              try {
                return Text(detailscontroller
                    .individual.value.data.ayahs[index].text
                    .toString());
              } catch (e) {
                return Center(child: CircularProgressIndicator());
              }
            });
          },
        ),
      )),
    );
  }
}
