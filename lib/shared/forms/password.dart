import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:hashkey/shared/widgets/passwordinput.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  const PasswordInput({Key? key, required this.controller1, required this.controller2, required this.controller3, required this.controller4}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isPassVisible = false;

  togglePassVisibility(){
    setState(() => isPassVisible = !isPassVisible);
  }

  test(){
    print('testonly');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomInputWidget(myController: widget.controller1, hint: 'Name', validation: null, autofocus: false,),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: widget.controller2, hint: 'Url', validation: null, autofocus: false),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: widget.controller3, hint: 'Username/Email', validation: null, autofocus: false),
          SizedBox(height: 15.h,),
          CustomPasswordInputWidget(
            myController: widget.controller4, 
            hint: 'Password', 
            validation: null, 
            visible: isPassVisible,
            toggler: togglePassVisibility
          ),
        ],
      ),
    );
  }
}