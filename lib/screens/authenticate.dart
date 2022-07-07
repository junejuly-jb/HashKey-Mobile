import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/shared/widgets/passwordinput.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({ Key? key }) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  bool isPinVisible = false;

  pinValidator(String? value){
    if(value!.length != 4){
      return 'Invalid pin code.';
    }
    return null;  
  }

  togglePinVisibility(){
    setState(() => isPinVisible = !isPinVisible);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Image.asset('lib/assets/icons/logo.png'),
                          height: 32.h,
                          width: 25.w,
                        ),
                        SizedBox(width: 8.w,),
                        Text('HASHKEY', style: TextStyle( letterSpacing: 2, fontSize: 25.sp, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    Text('Hello ${user.user['name'].split(' ')[0]},', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.sp, letterSpacing: 1),),
                    SizedBox(height: 20.h,),
                    Text('Use your fingerprint to login', style: TextStyle(color: Colors.grey, fontSize: 15.sp),),
                    Text('to your vault.', style: TextStyle(color: Colors.grey, fontSize: 15.sp),),
                    SizedBox(height: 40.h,),
                    Center(
                      child: AvatarGlow(
                        glowColor: Colors.blue,
                        endRadius: 100.0,
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors.white,
                            // borderRadius: BorderRadius.circular(15.r),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(106, 17, 203, 1),
                                Color.fromRGBO(37, 117, 252, 1),
                              ],
                              begin: Alignment(-1, 1),
                              end: Alignment(1, -1),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(35),
                            child: TextButton(
                              onPressed: () {}, 
                              child: const Icon(Icons.fingerprint_rounded, size: 70,),
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
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    Text('Or just enter your 4 digit pin code.', style: TextStyle(color: Colors.grey, fontSize: 15.sp),),
                    SizedBox(height: 20.h,),
                    Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: CustomPasswordInputWidget(
                              myController: myController, 
                              hint: 'Pin', 
                              validation: pinValidator, 
                              visible: isPinVisible,
                              toggler: togglePinVisibility
                            ),
                          ),
                          SizedBox(width: 15.w,),
                          RawMaterialButton(
                            onPressed: () {},
                            elevation: 0,
                            fillColor: Colors.indigo[700],
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              size: 35.0,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_rounded, size: 50,),
                      SizedBox(width: 15.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Trouble logging in?'),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: (){}, child: const Text('Contact us'))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
      ),
    );
  }
}