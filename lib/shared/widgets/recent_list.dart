import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/recent.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecentList extends StatelessWidget {
  const RecentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final recents = Provider.of<DataProvider>(context).recents;
    final theme = Provider.of<ThemeProvider>(context).theme;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: recents.length,
      itemBuilder: (BuildContext context, int index){
        Recent recent = recents[index];
        return InkWell(
          splashColor: Colors.blue[200],
          onTap: () => print('Test'),
          child: ListTile(
            minLeadingWidth: 55.w,
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme == 'light' ? Colors.white : const Color.fromRGBO(54, 54, 54, 1),
                borderRadius: BorderRadius.circular(100.r)
              ),
              child: CircleAvatar(
                backgroundColor: theme == 'light' ? Colors.white : const Color.fromRGBO(54, 54, 54, 1),
                radius: 15.r,
                child: Icon(getIcon(recent.credentialType), color: Theme.of(context).iconTheme.color, size: 20,)
              ),
            ),
            title: Text(
              recent.name,
              style: Theme.of(context).textTheme.bodyText1
            ),
            subtitle: Text(
              'added ${timeago.format(recent.createdAt)}',
              style: Theme.of(context).textTheme.subtitle1,  
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
  else if(credType == 'payment'){
    return FontAwesomeIcons.solidCreditCard;
  }
  else if(credType == 'contact'){
    return FontAwesomeIcons.idBadge;
  }
  else if(credType == 'notes'){
    return FontAwesomeIcons.solidNoteSticky;
  }
  else{
    return FontAwesomeIcons.buildingLock;
  }
}