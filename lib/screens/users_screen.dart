import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/constants.dart';
import '../core/store.dart';
import '../widgets/my_drawer.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final Store store = Get.find<Store>();

  @override
  void initState() {
    super.initState();
    store.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        drawer: const MyDrawer(),
        appBar: AppBar(
          leading: Hero(
            tag: 'logo',
            child: Padding(
              child: SvgPicture.asset('assets/images/witch-cat.svg'),
              padding: const EdgeInsets.all(kDefaultPadding / 2),
            ),
          ),
          title: Text(
            'Logged in as: ${store.user.value['name']}',
            textAlign: TextAlign.start,
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => store.getUsers(),
            child: ListView.builder(
              itemCount: store.users.length,
              itemBuilder: (context, index) {
                var user = store.users[index];
                return GestureDetector(
                  onTap: () async {
                    Get.toNamed('/events/${user['id']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, kDefaultPadding, 0),
                                child: Text('${user['id']}'),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user['name']}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${user['email']}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
