import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/GetxController/controllergetx.dart';

class practice1 extends StatefulWidget {
  @override
  _practice1State createState() => _practice1State();
}

class _practice1State extends State<practice1> {
  var prcct = Get.put(ControllerGetx());

  final List<int> _items = List<int>.generate(50, (int index) => index);

  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final oddItemColor = colorScheme.primary.withOpacity(0.05);
    final evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: <Widget>[
          for (int index = 0; index < _items.length; index++)
            ListTile(
              key: Key('$index'),
              tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
              title: Text('Item ${_items[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
