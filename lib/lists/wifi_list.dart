import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/wifi.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class WifiList extends StatelessWidget {
  final List arrayList;
   final Function onDeleteCallback;
  const WifiList({Key? key, required this.arrayList, required this.onDeleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
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
              child: ListTile(
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
                    child: FaIcon(FontAwesomeIcons.wifi, color: Colors.grey[700], 
                    size: 20,), 
                    
                  )
                ),
                title: Text(
                  wifi.wifiSsid,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                trailing: PopupMenuButton(
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
                        const PopupMenuItem(
                          child: Text("Copy password"),
                          value: 1,
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
                ),
              ),
            ),
          );
        }
      );
  }
}