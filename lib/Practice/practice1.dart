import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/GetxController/controllergetx.dart';
import 'package:todo/Practice/detailspage.dart';
import 'package:todo/Practice/servicequran.dart';

class practice1 extends StatelessWidget {
  var practicecontroller = Get.put(ControllerGetx());
  var apicalled = ApiQuran();
  @override
  Widget build(BuildContext context) {
    var sulist = practicecontroller.surah.value;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: sulist.data == null ? 0 : sulist.data.length,
            itemBuilder: (BuildContext context, int index) {
              return sulist.data == null
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PhysicalModel(
                            color: Colors.white.withOpacity(0.60),
                            elevation: 10,
                            child: InkWell(
                              onTap: () {
                                apicalled.fetchdata2(index + 1).then((value) {
                                  practicecontroller.individual.value = value;
                                });
                                print("pressed");
                                Get.to(() => detailspage());
                              },
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.favorite),
                                          onPressed: () {}),
                                      Text(sulist.data[index].englishName),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
