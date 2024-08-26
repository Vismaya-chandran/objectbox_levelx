import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod_project/object_box/temp/temp.dart';

class TempEntityScreen extends StatefulWidget {
  const TempEntityScreen({super.key, required this.store});
  final Store store;
  @override
  State<TempEntityScreen> createState() => _TempEntityScreenState();
}

class _TempEntityScreenState extends State<TempEntityScreen> {
  late Box<TempEntity> tempEntity;
  List<TempEntity> datas = [];
  @override
  void initState() {
    tempEntity = widget.store.box<TempEntity>();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: datas.length,
            itemBuilder: (context, index) {
              final entity = datas[index];
              // final customTypeValue = entity.customType;
              // return Text("${customTypeValue.a}");
            },
          )),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                addData();
              },
              child: const Text("add"))
        ],
      ),
    );
  }

  addData() {
    final data = TempEntity(tempId: 123);
    // data.customType = CustomType(789);
    tempEntity.put(data);
    getData();
  }

  getData() {
    datas = tempEntity.getAll();
    setState(() {});
  }
}
