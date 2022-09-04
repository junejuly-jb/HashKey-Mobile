import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/models/license.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



class LicenseList extends StatelessWidget {
  final List arrayList;
  final Function onDeleteCallback;
  const LicenseList({Key? key, required this.arrayList, required this.onDeleteCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
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
              color: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: theme == 'dark' ? Colors.grey[900] : Colors.grey[500],
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Center(
                              child: Text(
                                license.licenseName,
                                style: const TextStyle(
                                  color: Colors.white
                                ),  
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(license.licenseFlag),
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
                                  child: Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.white,),
                                ),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: const Text("Delete"),
                                    value: 4,
                                    onTap: (){
                                      List<String> ids = [];
                                      ids.add(license.licenseId);
                                      print(ids);
                                      onDeleteCallback('license', ids);
                                    },
                                  )
                                ]
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Row(
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