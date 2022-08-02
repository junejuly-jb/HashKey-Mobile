import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

class HorizontalSkeleton extends StatelessWidget {
  const HorizontalSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: SkeletonTheme(
              themeMode: theme == 'dark' ? ThemeMode.dark : ThemeMode.light,
              child: SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  height: 120.h, width: 105.w,
                  borderRadius: BorderRadius.circular(20.r)
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}