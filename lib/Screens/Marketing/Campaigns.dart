import 'package:admin_thrifters/customUI/CurrentScreen.dart';
import 'package:flutter/material.dart';

class Campaigns extends StatefulWidget {
  const Campaigns({Key key}) : super(key: key);

  @override
  _CampaignsState createState() => _CampaignsState();
  static final id = '/Marketing/Campaigns';
}

class _CampaignsState extends State<Campaigns> {
  @override
  Widget build(BuildContext context) {
    return CurrentScreen(child: Container(), title: 'Campaigns');
    ;
  }
}
