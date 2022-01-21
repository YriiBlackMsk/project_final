import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:project_fin/core/networking.dart';
import 'package:pubnub/pubnub.dart';

class Store extends GetxController {
  dynamic messages = [].obs;
  dynamic user = {}.obs;
  dynamic users = [].obs;
  final email = ''.obs;
  final password = ''.obs;
  final token = ''.obs;
  late final Networking api;
  late final PubNub pubnub;
  late final Subscription subscription;
  late final Channel channel;
  late final ChannelHistory channelHistory;
  static Store get to => Get.find();

  @override
  void onInit() async {
    super.onInit();
    api = Get.put(Networking());

    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: '${dotenv.env['PUBNUB_SUBSCRIBE_KEY']}',
        publishKey: dotenv.env['PUBNUB_PUBLISH_KEY'],
        uuid: const UUID('project-final'),
      ),
    );

    subscription = pubnub.subscribe(channels: {'test'});

    subscription.messages.take(1).listen((envelope) async {
      print('${envelope.uuid} sent a message: ${envelope.payload}');
      await subscription.dispose();
    });
    await Future.delayed(Duration(seconds: 3));
    await pubnub.publish('test', {'message': 'My message!'});
    channel = pubnub.channel('test');
    await channel.publish({'message': 'Another message'});
    channelHistory = channel.messages();
    var count = await channelHistory.count();
    print('Messages on test channel: $count');
    messages = channelHistory.messages;
  }

  Future<void> getLogin(String inputEmail, String inputPassword) async {
    var res = await api.getLogin(inputEmail, inputPassword);
    if (res != null) {
      email.value = inputEmail;
      password.value = inputPassword;
      token.value = res['api_key'];
      user.value = res['result'];
    } else {
      token.value = '';
    }
  }

  Future<void> getUsers() async {
    var res = await api.getUsers();
    if (res != null) {
      users.value = res['result'];
    }
  }
}
