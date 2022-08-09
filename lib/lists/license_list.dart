import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/license.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



class LicenseList extends StatelessWidget {
  final List arrayList;
  const LicenseList({Key? key, required this.arrayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    // TODO: Enhance UI
    return ListView.builder(
      shrinkWrap: true,
        itemCount: arrayList.length,
        itemBuilder: (BuildContext context, int index){
          License license = arrayList[index];
          String exp = DateFormat("MM/dd/yyyy").format(license.licenseExpDate);
          return Container(
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(54, 54, 54, 1)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    color: Colors.grey[900],
                    child: Center(
                      child: Text(
                        license.licenseName,
                        style: TextStyle(
                          color: theme == 'dark' ? Colors.white : Colors.grey[900]
                        ),  
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 10.r,
                            backgroundImage: NetworkImage(license.licenseFlag),
                          ),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 25.r,
                              child: const Icon(FontAwesomeIcons.user),
                            ),
                            SizedBox(width: 25.w,),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('License number:', style: Theme.of(context).textTheme.subtitle1,),
                                  Text(license.licenseNumber, style: Theme.of(context).textTheme.bodyText1!.copyWith(letterSpacing: 2),),
                            
                                  SizedBox(height: 5.h,),
                                  
                                  Text('Expiry date:', style: Theme.of(context).textTheme.subtitle1,),
                                  Text(exp,
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith(letterSpacing: 2),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}