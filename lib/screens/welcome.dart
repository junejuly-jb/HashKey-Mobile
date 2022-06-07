import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/connection_provider.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 340.w,
                  height: 360.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
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
                  child: Image.asset(
                    'lib/assets/images/safe.png',
                    height: 275.h,
                    width: 262.w,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Security is in your fingertips.',
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Manage your credentials through''\n the cloud.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white, width: 3.w)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r)
                          ),
                          child: TextButton(
                            style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/signup'), 
                            child: const Text('Sign up', 
                              style: TextStyle(
                                color: Colors.black
                              ),
                            )
                          ),
                        )
                      ),
                      Expanded(
                        child: TextButton(
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory
                          ),
                          onPressed: (){
                            Navigator.pushNamed(context, '/login');
                          }, 
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black
                            ),
                          )
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}