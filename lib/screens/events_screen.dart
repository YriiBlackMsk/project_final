import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/constants.dart';
import '../core/store.dart';
import '../widgets/my_bottom_navigation_bar.dart';
import '../widgets/my_drawer.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Store store = Get.find<Store>();
  late dynamic user = {};

  @override
  void initState() {
    super.initState();
    var _userId = Get.parameters['user'];
    for (final _user in store.users) {
      if (_user['id'].toString() == _userId) {
        setState(() {
          user = _user;
        });
      }
    }
    store.getEvents(_userId);
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
          title: Text('Todos for: ${user['name']}'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Id: ${user['id']}'),
                    Text('Name: ${user['name']}'),
                    Text('Email: ${user['email']}'),
                    Text('Power: ${user['power']}'),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => store.getEvents(Get.parameters['user']),
                  child: ListView.builder(
                    itemCount: store.events.length,
                    itemBuilder: (context, index) {
                      var event = store.events[index];
                      return GestureDetector(
                        onTap: () async {},
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
                                      padding: const EdgeInsets.fromLTRB(0, 0, kDefaultPadding, 0),
                                      child: event['lat'] > 0 ? const Icon(
                                        Icons.check_box,
                                        color: Colors.lightGreen,
                                      ) : const Icon(
                                        Icons.check_box_outline_blank,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${event['body']['content']}',
                                        overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
