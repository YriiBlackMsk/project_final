import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../core/constants.dart';
import '../core/store.dart';
import '../widgets/my_bottom_navigation_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Store store = Get.find<Store>();
  //late int channelHistoryCount = 0;

  @override
  void initState() {
    super.initState();
    //channelHistoryCount = await store.channelHistory.count();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Hero(
            tag: 'logo',
            child: Padding(
              child: SvgPicture.asset('assets/images/witch-cat.svg'),
              padding: const EdgeInsets.all(kDefaultPadding / 2),
            ),
          ),
          title: Text('Messages: ${store.messages.length}'),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async => {},
            child: ListView.builder(
              itemCount: store.messages.length,
              itemBuilder: (context, index) {
                var message = store.messages[index];
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
                              Expanded(
                                child: Text(
                                  '${message.toString()}',
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
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
