import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset('lib/assets/icons/logo.png'),
                        height: 32.h,
                        width: 25.w,
                      ),
                      SizedBox(width: 8.w,),
                      Text('HASHKEY', style: TextStyle( letterSpacing: 2, fontSize: 25.sp, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 7.h,),
                  Center(child: Text('Your all in one vault for''\n your credentials.', textAlign: TextAlign.center, style: TextStyle( fontSize: 16.sp),)),
                  SizedBox(height: 34.h,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide( color: Colors.transparent, width: 0.w)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(color: Colors.transparent, width: 0.w)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Email",
                      contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide( color: Colors.transparent, width: 0.w)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(color: Colors.transparent, width: 0.w)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: (){}, child: Text('Forgot password?', style: TextStyle(fontSize: 12.sp, color: Colors.grey[900]),)),
                    ],
                  ),
                  SizedBox(height: 35.h,),
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(106, 17, 203, 1),
                            Color.fromRGBO(37, 117, 252, 1),
                          ],
                          begin: Alignment(-1, 1),
                          end: Alignment(1, -1),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/home'), 
                        child: Text('Login', style: TextStyle( fontSize: 15.sp, fontWeight: FontWeight.w700 ),),
                        style: ButtonStyle(
                          // backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(34, 166, 255, 1)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 13.h)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      const Expanded(child: Divider( thickness: 2,)),
                      SizedBox(width: 8.w),
                      Text('or continue with', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),),
                      SizedBox(width: 8.w),
                      const Expanded(child: Divider(thickness: 2,))
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 66.h,
                        width: 81.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.white, width: 3)
                        ),
                        child: Image.asset('lib/assets/icons/google.png'),
                      ),
                      SizedBox(width: 25.w,),
                      Container(
                        height: 66.h,
                        width: 81.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.white, width: 3)
                        ),
                        child: Image.asset('lib/assets/icons/facebook.png'),
                      )
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('no account?', style: TextStyle(fontSize: 12.sp),),
                      GestureDetector(onTap: () => Navigator.pushReplacementNamed(context, '/signup'), child: Text(' sign up here', style: TextStyle(fontSize: 12.sp, color: Colors.blue),)),
                    ],
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}