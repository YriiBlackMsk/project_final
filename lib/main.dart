import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/store.dart';
import 'screens/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StoreBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Project Final',
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Store());
  }
}
