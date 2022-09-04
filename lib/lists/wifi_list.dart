import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/wifi.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class WifiList extends StatelessWidget {
  final List arrayList;
  final Function onDeleteCallback;
  final Function onCopyData;
  const WifiList({Key? key, required this.arrayList, required this.onDeleteCallback, required this.onCopyData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    print(theme);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: arrayList.length,
        itemBuilder: (BuildContext context, int index){
          Wifi wifi = arrayList[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: InkWell(
              splashColor: Colors.blue[200],
              onTap: () => print('Test'),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25.r,
                    child: FaIcon(FontAwesomeIcons.wifi, color: Colors.grey[700], 
                      size: 20,
                    ), 
                  ),
                  SizedBox(width: 20.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wifi.wifiSsid,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(wifi.wifiSecurity, style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    color: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
                    child: const  Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10, 
                            vertical: 20
                          ),
                          child: Icon(FontAwesomeIcons.ellipsisVertical),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text("Copy password"),
                            value: 1,
                            onTap: () => onCopyData(wifi.wifiPass),
                          ),
                          const PopupMenuItem(
                            child: Text("Edit"),
                            value: 2,
                          ),
                          const PopupMenuItem(
                            child: Text("Show QR Code"),
                            value: 3,
                          ),
                          PopupMenuItem(
                            child: const Text("Delete"),
                            value: 4,
                            onTap: (){
                              List<String> ids = [];
                              ids.add(wifi.wifiId);
                              print(ids);
                              onDeleteCallback('wifi', ids);
                            },
                          )
                        ]
                  )
                ],
              ),
            ),
          );
        }
      );
  }
}