import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/constants.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Padding(
            child: SvgPicture.asset('assets/images/witch-cat.svg'),
            padding: EdgeInsets.all(kDefaultPadding / 2),
          ),
        ),
        title: Text('PF'),
      ),
      body: const Expanded(
        child: Center(
          child: Text('PF'),
        ),
      ),
    );
  }
}
