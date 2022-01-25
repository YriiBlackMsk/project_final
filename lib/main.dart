import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_final/screens/events_screen.dart';
import 'package:project_final/screens/users_screen.dart';

import 'core/store.dart';
import 'screens/splash_screen.dart';

void main() async {
  await GetStorage.init();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      home: SplashScreen(),
      initialBinding: StoreBinding(),
      theme: ThemeData.light(),
      title: 'Project Final',
      getPages: [
        GetPage(
          name: '/users/',
          page: () => const UsersScreen(),
        ),
        GetPage(
          name: '/events/:user',
          page: () => const EventsScreen(),
        ),
      ],
    );
  }
}

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Store());
  }
}
