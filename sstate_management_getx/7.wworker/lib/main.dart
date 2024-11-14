import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class WorkerController extends GetxController {
  // variabel relatif yang akan kita monitor
  var count = 0.obs;

  @override
  void onInit() {
    ever(count, (_) => print("ever: Count changed to $count"));
    once(count, (_) => print("once: Count changed to $count"));
    interval(count, (_) => print("interval: Count changed to $count"), time: Duration(seconds: 60));

    super.onInit();
  }

  void  increment() {
    count++;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Worker Example")),
        body: WorkerExample(),
      ),
    );
  }
}

class WorkerExample extends StatelessWidget {
  final WorkerController wc = Get.put(WorkerController());


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text("Count: ${wc.count}", style: TextStyle(fontSize: 24))),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: wc.increment,
            child: Text("Increment"),
          ),
        ],
      ),
    );
  }
}