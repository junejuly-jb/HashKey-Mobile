import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/recent.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

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
          minLeadingWidth: 55.w,
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r)
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 15.r,
              child: FaIcon(getIcon(recent.credentialType), color: Colors.grey[700], size: 20,)
            ),
          ),
          title: Text(
            recent.name,
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
          subtitle: Text(
            'added ${timeago.format(recent.createdAt)}',
            style: TextStyle(
              fontSize: 12.sp,
              fontStyle: FontStyle.italic
            ),  
          ),
        );
      }
    );
  }
}

IconData getIcon(String credType){
  if(credType == 'password'){
    return FontAwesomeIcons.lock;
  }
  else if(credType == 'wifi'){
    return FontAwesomeIcons.wifi;
  }
  else{
    return FontAwesomeIcons.buildingLock;
  }
}