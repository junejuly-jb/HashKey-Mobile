import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/services/app.dart';
import 'package:hashkey/services/response.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/appbar.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:http/http.dart';
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
                const Spacer(),
                XtraLargeButton(title: 'Next', isGradient: true, callback: () async {
                  if(myController.text.length != 4){
                    showDialog(context: context, builder: (_) => CustomAlert(message: 'Invalid pin code.', type: 'error', statusType: null, callback: () => Navigator.pop(context) ));
                  }else{
                    showDialog(barrierDismissible: false, context: context, builder: (_) => const CustomAlert(message: 'Adding pin, please wait...', type: 'loading', statusType: null, callback: null));
                    var result = await App().addPin(myController.text);
                    Navigator.pop(context);
                    if(result['success']){
                      Provider.of<UserProvider>(context, listen: false).setPinState();
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    }
                    else{
                      print(result);
                      showDialog(context: context, builder: (_) => ResponseHandler().response(result, context));
                    }
                  }
                }),
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