import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/GetxController/controllergetx.dart';

class favoritelist extends StatelessWidget {
  var favoritecontroller = Get.put(ControllerGetx());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => Column(
          children: [
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Get.back();
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        "Favorite Lists",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: favoritecontroller.newItem.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhysicalModel(
                    color: Colors.white,
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        Get.dialog(Dialog(
                          child: Container(
                            height: size.height * 0.5,
                            width: 0.8,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        favoritecontroller
                                            .ListOfData[index].title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          favoritecontroller
                                              .ListOfData[index].subtitle,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        favoritecontroller
                                            .ListOfData[index].date
                                            .toString()
                                            .split(" ")[0],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: size.height * 0.15,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 0,
                                  child: InkWell(
                                    onTap: () {
                                      favoritecontroller.newItem
                                          .removeAt(index);
                                      Get.snackbar("Wow!",
                                          "You have removed ${favoritecontroller.ListOfData[index].title} from your favorite list");
                                    },
                                    child: Container(
                                      width: size.width * 0.20,
                                      color: Colors.white,
                                      child: Center(
                                        child: PhysicalModel(
                                          color: Colors.white,
                                          elevation: 10,
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                            size: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                        flex: 0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4),
                                              child: Text(
                                                favoritecontroller
                                                    .ListOfData[index].title,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                          ],
                                        )),
                                    Expanded(
                                        child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      dragStartBehavior: DragStartBehavior.down,
                                      child: Container(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          favoritecontroller
                                              .ListOfData[index].subtitle,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      )),
                                    )),
                                    Expanded(
                                        flex: 0,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            favoritecontroller
                                                .ListOfData[index].date
                                                .toString()
                                                .split(" ")[0],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
