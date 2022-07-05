import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';


class CreatePin extends StatefulWidget {
  const CreatePin({ Key? key }) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  String currentText = '';
  dynamic myController = new TextEditingController();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Column(
              children: [
                SizedBox(height: 50.h,),
                const CustomHeader(title: 'Create Pin', withBackButton: false),
                SizedBox(height: 25.h,),
                Text('To protect the security of your vault, you must nominate 4 digit pin code.', style: TextStyle(color: Colors.grey),),
                SizedBox(height: 60.h,),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 4,
                  obscureText: true,
                  animationType: AnimationType.fade,
                  cursorColor: Colors.grey,
                  pinTheme: PinTheme(
                    activeColor: Colors.white,
                    activeFillColor: Colors.white,
                    selectedColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15.r),
                    fieldHeight: 50,
                    fieldWidth: 50,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: myController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return false;
                  },
                ),
                Spacer(),
                XtraLargeButton(title: 'Next', isGradient: true, callback: () => print(myController.text)),
                SizedBox(height: 10.h),
                XtraLargeButton(title: 'Cancel', isGradient: false, callback: () async {
                  Provider.of<UserProvider>(context, listen: false).removeUser();
                  Navigator.pushReplacementNamed(context, '/login');
                }),
                SizedBox(height: 40.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}