import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hashkey/provider/data_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/shared/horizontal_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/recent_list.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';


class Main extends StatefulWidget {

  final bool isCardLoading;
  final bool isRecentLoading;

  const Main({
    Key? key,
    required this.isCardLoading, required this.isRecentLoading
  }) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final recents = Provider.of<DataProvider>(context).recents;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(106, 17, 203, 1),
                  Color.fromRGBO(37, 117, 252, 1),
                ],
                begin: Alignment(-1, 1),
                end: Alignment(1, -1),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(3.w, 3.h, 15.w, 3.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white ,width: 1.w),
                          borderRadius: BorderRadius.circular(50.r)
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'lib/assets/images/june.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Text(user['name'], style: TextStyle( fontSize: 12.sp, color: Colors.white),),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                          constraints: const BoxConstraints(),
                          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 15, color: Colors.white,),
                          onPressed: () => Navigator.pushNamed(context, '/search'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 27.h,),
                  Text('Manage', style: TextStyle( fontSize: 14.sp, color: Colors.white ),),
                  Text('Your credentials.', style: TextStyle( fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),),
                  SizedBox(height: 20.h,),
                  Container(
                    child: widget.isCardLoading ? SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: 120.h, width: 105.w,
                        borderRadius: BorderRadius.circular(20.r)
                        ),
                    ) : const Cards(),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                Row(
                  children: [
                    Text('Recently Added', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
                    Spacer(),
                    if(recents.isEmpty) Icon(Icons.refresh_rounded)
                  ],
                ),
                SizedBox(height: 15.h,),
              ],
            ),
          ),
          Expanded(
            child: widgetType(widget.isRecentLoading, recents),
          )
        ],
      ),
    );
  }
}


Widget widgetType(bool isLoading, List recents){
  if(isLoading){
    return SkeletonListView();
  }
  else if(!isLoading && recents.isEmpty){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.folderOpen, size: 40,),
          SizedBox(height: 20.h,),
          Text(
            'Your vault is empty',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 5.h,),
          Text('Add credentials by pressing \'+\'',
            style: TextStyle(
              color: Colors.grey[500]
            ),
          ),
        ],
      ),
    );
  }
  else{
    return const RecentList();
  }
}