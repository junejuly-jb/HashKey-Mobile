import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:hashkey/shared/widgets/passwordinput.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPassVisible = false;

  togglePassVisibility(){
    setState(() => isPassVisible = !isPassVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomInputWidget(myController: nameController, hint: 'Name', validation: null, autofocus: false,),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: urlController, hint: 'Url', validation: null, autofocus: false),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: userNameController, hint: 'Username/Email', validation: null, autofocus: false),
          SizedBox(height: 15.h,),
          CustomPasswordInputWidget(
            myController: passwordController, 
            hint: 'Password', 
            validation: null, 
            visible: isPassVisible,
            toggler: togglePassVisibility
          ),
          SizedBox(height: 15.h,),
        ],
      ),
    );
  }
}