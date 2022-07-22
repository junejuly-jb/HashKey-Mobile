import 'package:flutter/material.dart';
import 'package:hashkey/models/recent.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:provider/provider.dart';

class RecentList extends StatelessWidget {
  const RecentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final recents = Provider.of<DataProvider>(context).recents;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: recents.length,
      itemBuilder: (BuildContext context, int index){
        Recent recent = recents[index];
        return ListTile(
          title: Text(recent.name),
        );
      }
    );
  }
}