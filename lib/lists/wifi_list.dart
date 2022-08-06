import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/wifi.dart';

class WifiList extends StatelessWidget {
  final List arrayList;
  const WifiList({Key? key, required this.arrayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
          );
        }
      );
  }
}