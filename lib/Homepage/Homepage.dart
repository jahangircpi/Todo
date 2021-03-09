import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:todo/GetxController/controllergetx.dart';
import 'package:todo/Global/listofdata.dart';

class HomePagee extends StatelessWidget {
  var getxcontroller = Get.put(ControllerGetx());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var titlecontroller = TextEditingController();
    var subtitlecontroller = TextEditingController();
    Color taskcolor;
    DateTime pickthedate = DateTime.now();

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(buildDialog(size, titlecontroller, subtitlecontroller,
                context, pickthedate, taskcolor, false, 0));
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: buildBottomAppBar(size),
        body: SafeArea(
            child: Container(
                child: Obx(
          () => ListView.builder(
            itemCount: getxcontroller.ListOfData.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      final bool res = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                  "Are you sure you want to delete ${getxcontroller.ListOfData[index].title}?"),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onTap: () {
                                        getxcontroller.ListOfData.removeAt(
                                            index);

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                      return res;
                    } else {
                      titlecontroller.text =
                          getxcontroller.ListOfData.value[index].title;
                      subtitlecontroller.text =
                          getxcontroller.ListOfData.value[index].subtitle;
                      Get.dialog(buildDialog(
                          size,
                          titlecontroller,
                          subtitlecontroller,
                          context,
                          pickthedate,
                          taskcolor,
                          true,
                          index));
                    }
                  },
                  key: Key(getxcontroller.ListOfData[index].toString()),
                  child: buildObx(index, size));
            },
          ),
        ))));
  }

  Padding buildObx(int index, Size size) {
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
                  color: getxcontroller.ListOfData[index].status,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getxcontroller.ListOfData[index].title,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                                getxcontroller.ListOfData[index].subtitle,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                              getxcontroller.ListOfData[index].date
                                  .toString()
                                  .split(" ")[0],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
              height: size.height * 0.15,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      flex: 0,
                      child: Container(
                        width: size.width * 0.20,
                        color: getxcontroller.ListOfData[index].status,
                      )),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, bottom: 4),
                                  child: Text(
                                    getxcontroller.ListOfData[index].title,
                                    style: TextStyle(fontSize: 20),
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
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              getxcontroller.ListOfData[index].subtitle,
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                        )),
                        Expanded(
                            flex: 0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                getxcontroller.ListOfData[index].date
                                    .toString()
                                    .split(" ")[0],
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  BottomAppBar buildBottomAppBar(Size size) {
    return BottomAppBar(
      notchMargin: 11,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: CircularNotchedRectangle(),
      child: Container(
        color: Colors.blue,
        height: size.height * 0.07,
        child: Row(
          children: [
            Opacity(
              opacity: 0,
              child: Icon(Icons.favorite),
            ),
            Opacity(
              opacity: 0,
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }

  Dialog buildDialog(
      Size size,
      TextEditingController titlecontroller,
      TextEditingController subtitlecontroller,
      BuildContext context,
      DateTime pickthedate,
      Color taskcolor,
      bool isUpdate,
      listIndex) {
    return Dialog(
      child: Container(
        height: size.height * 0.60,
        width: size.width * 0.7,
        color: Colors.yellow.withOpacity(0.80),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                    hintText: "Title",
                    enabled: true,
                    focusedBorder: UnderlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(maxHeight: size.height * 0.2),
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  child: TextField(
                    scrollPhysics: BouncingScrollPhysics(),
                    controller: subtitlecontroller,
                    autofocus: true,
                    decoration: InputDecoration(
                        hintText: "What is in your mind ?",
                        enabled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none),
                    style: TextStyle(fontSize: 25),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),
            ),
            Expanded(child: Opacity(opacity: 0, child: Divider())),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: getxcontroller.taskcolor.value,
                      height: size.height * 0.05,
                      width: size.width * 0.1,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PhysicalModel(
                    color: Colors.yellow,
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: pickthedate == null
                              ? DateTime.now()
                              : pickthedate,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2222),
                        ).then((value) {
                          pickthedate = value;
                        });
                      },
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "PICK THE DATE",
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    taskcolor = Colors.blue;
                    getxcontroller.taskcolor.value = Colors.blue;
                  },
                  child: Container(
                    color: Colors.blue,
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    taskcolor = Colors.pink;
                    getxcontroller.taskcolor.value = Colors.pink;
                  },
                  child: Container(
                    color: Colors.pink,
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    taskcolor = Colors.orange;
                    getxcontroller.taskcolor.value = Colors.orange;
                  },
                  child: Container(
                    color: Colors.orange,
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    taskcolor = Colors.green;
                    getxcontroller.taskcolor.value = Colors.green;
                  },
                  child: Container(
                    color: Colors.green,
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (isUpdate) {
                    getxcontroller.ListOfData.value[listIndex] = TodoList(
                        title: titlecontroller.text,
                        subtitle: subtitlecontroller.text,
                        date: pickthedate.toString(),
                        status: taskcolor);
                  } else {
                    getxcontroller.ListOfData.add(TodoList(
                        title: titlecontroller.text,
                        subtitle: subtitlecontroller.text,
                        date: pickthedate.toString(),
                        status: taskcolor));
                  }
                  Get.back();
                },
                child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Enter",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
