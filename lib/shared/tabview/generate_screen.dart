import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/appbar.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h,),
            CustomHeader(title: 'Generate', withBackButton: false),
            SizedBox(height: 23.h,),
            Text('Passwords', style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),),
            SizedBox(height: 5.h,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white
              ),
              height: 64.h,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Xswr1Wd!23@', style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold, letterSpacing: 2),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}