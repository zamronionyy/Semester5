import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyController extends GetxController {
  var message = 'Hello, GetX!'.obs;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: BindingsBuilder(() {
            // Menginisialisasi dependency secara otomatis
            Get.put(MyController());
          }),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bindings Builder")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Mengakses dependency yang sudah di-bind
            Get.find<MyController>().message.value = "Hello from another page!";
          },
          child: Text("Update Message"),
        ),
      ),
    );
  }
}