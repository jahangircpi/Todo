import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:todo/FavoriteList/favoritelists.dart';
import 'package:todo/GetxController/controllergetx.dart';
import 'package:todo/Global/listofdata.dart';

class HomePagee extends StatefulWidget {
  @override
  _HomePageeState createState() => _HomePageeState();
}

class _HomePageeState extends State<HomePagee> {
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
        floatingActionButton: Container(
          height: 80,
          width: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.cyan,
            splashColor: Colors.pinkAccent,
            onPressed: () {
              titlecontroller.clear();
              subtitlecontroller.clear();
              Get.dialog(
                  Dialog(
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
                                  focusedBorder: InputBorder.none,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxHeight: size.height * 0.2),
                              child: SingleChildScrollView(
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                child: TextField(
                                  scrollPhysics: BouncingScrollPhysics(),
                                  controller: subtitlecontroller,
                                  decoration: InputDecoration(
                                      hintText: "What is in your mind ?",
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  style: TextStyle(fontSize: 25),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Opacity(opacity: 0, child: Divider())),
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
                                  getxcontroller.taskcolor.value =
                                      Colors.orange;
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
                                getxcontroller.ListOfData.add(TodoList(
                                    title: titlecontroller.text,
                                    subtitle: subtitlecontroller.text,
                                    date: pickthedate.toString(),
                                    status: taskcolor));
                                Get.back();
                              },
                              child: PhysicalModel(
                                color: Colors.cyan,
                                elevation: 20,
                                child: Container(
                                    color: Colors.cyan,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 18),
                                      child: Text(
                                        "Enter",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  transitionCurve: (Curves.easeInCubic),
                  transitionDuration: Duration(milliseconds: 900));
            },
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        bottomNavigationBar: buildBottomAppBar(size),
        body: SafeArea(
            child: Container(
                child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: getxcontroller.ListOfData.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      final bool res = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Are you sure you want to delete ${getxcontroller.ListOfData[index].title}?",
                                style: TextStyle(fontSize: 25),
                              ),
                              content: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: size.width * 0.07),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            child: PhysicalModel(
                                              color: Colors.white,
                                              elevation: 10,
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          GestureDetector(
                                            child: PhysicalModel(
                                              color: Colors.white,
                                              elevation: 10,
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              var myIndex = getxcontroller
                                                  .newItem
                                                  .indexWhere((element) =>
                                                      getxcontroller
                                                          .ListOfData[index]
                                                          .date ==
                                                      element.date);
                                              if (myIndex.isNegative) {
                                              } else {
                                                getxcontroller.newItem
                                                    .removeAt(myIndex);
                                              }
                                              getxcontroller.ListOfData
                                                  .removeAt(index);
                                              Navigator.of(context).pop();
                                              Get.snackbar(
                                                  "Oops!", "you just deleted",
                                                  snackStyle:
                                                      SnackStyle.FLOATING);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: <Widget>[],
                            );
                          });
                      return res;
                    } else {
                      titlecontroller.text =
                          getxcontroller.ListOfData[index].title;
                      subtitlecontroller.text =
                          getxcontroller.ListOfData[index].subtitle;
                      taskcolor = getxcontroller.ListOfData[index].status;
                      Get.dialog(dialogboxforedit(
                          size,
                          titlecontroller,
                          subtitlecontroller,
                          context,
                          pickthedate,
                          taskcolor,
                          index));
                    }
                  },
                  secondaryBackground: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Delete",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: getxcontroller.ListOfData.value[index].status,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Edit",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  key: Key(getxcontroller.ListOfData[index].toString()),
                  child: bodypadding(size, index));
            },
          ),
        ))));
  }

  Dialog dialogboxforedit(
      Size size,
      TextEditingController titlecontroller,
      TextEditingController subtitlecontroller,
      BuildContext context,
      DateTime pickthedate,
      Color taskcolor,
      int index) {
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
                    focusedBorder: InputBorder.none,
                  )),
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
                    decoration: InputDecoration(
                        hintText: "What is in your mind ?",
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
                  getxcontroller.ListOfData[index] = TodoList(
                      title: titlecontroller.text,
                      subtitle: subtitlecontroller.text,
                      date: pickthedate.toString(),
                      status: taskcolor);

                  Get.back();
                },
                child: PhysicalModel(
                  color: Colors.cyan,
                  elevation: 20,
                  child: Container(
                      color: Colors.cyan,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 18),
                        child: Text(
                          "Enter",
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding bodypadding(Size size, int index) {
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
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
              },
              child: Obx(
                () => Container(
                  height: size.height * 0.15,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 0,
                          child: InkWell(
                            onTap: () {
                              var myIndex = getxcontroller.newItem.indexWhere(
                                  (element) =>
                                      getxcontroller.ListOfData[index].date ==
                                      element.date);
                              if (myIndex.isNegative) {
                                getxcontroller.newItem
                                    .add(getxcontroller.ListOfData[index]);
                                Get.snackbar(
                                  "Wow!",
                                  "You have added  ${getxcontroller.ListOfData[index].title} to your favorite list",
                                  colorText: Colors.black,
                                  barBlur: 10,
                                  backgroundColor:
                                      Colors.blue.withOpacity(0.70),
                                );
                              } else {
                                getxcontroller.newItem.removeAt(myIndex);
                                Get.snackbar("Oops!",
                                    "You have removed ${getxcontroller.ListOfData[index].title} from your favorite list");
                              }
                            },
                            child: Container(
                              width: size.width * 0.20,
                              color: getxcontroller.ListOfData[index].status,
                              child: Center(
                                  child: Icon(
                                Icons.favorite,
                                size: 52,
                              )),
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
                                        getxcontroller.ListOfData[index].title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ));
  }

  BottomAppBar buildBottomAppBar(Size size) {
    return BottomAppBar(
      notchMargin: 15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: CircularNotchedRectangle(),
      child: Container(
        color: Colors.cyan,
        height: size.height * 0.09,
        child: Row(
          children: [
            Opacity(
              opacity: 0,
              child: Icon(Icons.favorite),
            ),
            Obx(() => Badge(
                  badgeContent: Text(getxcontroller.newItem.length.toString()),
                  child: Opacity(
                    opacity: 1,
                    child: IconButton(
                      onPressed: () {
                        Get.to(favoritelist());
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 50,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
