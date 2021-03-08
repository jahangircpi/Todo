import 'package:flutter/material.dart';
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
            Get.dialog(Dialog(
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
                      child: TextField(
                        controller: subtitlecontroller,
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: "What is in your mind ?",
                            enabled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        style: TextStyle(fontSize: 25),
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 8,
                      ),
                    ),
                    Expanded(child: Opacity(opacity: 0, child: Divider())),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PhysicalModel(
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
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            taskcolor = Colors.blue;
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
                          getxcontroller.LolList.add(TodoList(
                              title: titlecontroller.text,
                              subtitle: subtitlecontroller.text,
                              date: pickthedate.toString(),
                              status: taskcolor));
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
            ));
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
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
        ),
        body: SafeArea(
            child: Container(
          child: ListView.builder(
            itemCount: getxcontroller.LolList.value.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.20,
                              height: size.height * 0.15,
                              color:
                                  getxcontroller.LolList[index].status == null
                                      ? Colors.black
                                      : getxcontroller.LolList[index].status,
                            ),
                            Container(
                                child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      getxcontroller.LolList[index].title == ""
                                          ? "Lol"
                                          : getxcontroller.LolList[index].title,
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                                Text(
                                  getxcontroller.LolList[index].subtitle,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(getxcontroller.LolList[index].date),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          ),
        )));
  }
}
