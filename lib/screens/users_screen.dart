import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/constants.dart';
import '../core/store.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  final Store _state = Get.put(Store());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Padding(
            child: SvgPicture.asset('assets/images/witch-cat.svg'),
            padding: EdgeInsets.all(kDefaultPadding / 2),
          ),
        ),
        title: Text('${_state.user.value['name']}'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('${_state.user.value}'),
        ),
      ),
    ));
  }
}
