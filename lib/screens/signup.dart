import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:hashkey/shared/widgets/passwordinput.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  dynamic nameController = TextEditingController();
  dynamic emailController = TextEditingController();
  dynamic passwordController = TextEditingController();
  dynamic confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPassVisible = false;
  bool isConPassVisible = false;

  void onSignUp(){
    print('parent callback');
    _formKey.currentState!.validate();
  }

  togglePassVisibility(bool val){
    setState(() => isPassVisible = val);
  }

  toggleConPassVisibility(bool val){
    setState(() => isConPassVisible = val);
  }

  isValidEmail(String? email) {
    bool isValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.toString());
    if(!isValid){
      return 'This is not a valid email';
    }
    return null;
  }

  isRequired(String? value){
    if(value == null || value.isEmpty){
      return 'This field is required';
    }
    return null;  
  }

  passwordValidator(String? value){
    if(value!.length < 5){
      return 'Password is too short';
    }
    return null;  
  }

  conPasswordValidator(String? value){
    if(value != passwordController.text){
      return 'Password mismatch';
    }
    return null;  
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h,),
                  Row(
                    children: [
                      Text('SIGN UP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp, letterSpacing: 2),),
                      const Spacer(),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Text('Welcome to Hashkey!', style: TextStyle(fontSize: 16.sp, letterSpacing: 1),),
                  SizedBox(height: 50.h,),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputWidget(myController: nameController, hint: 'Name', validation: isRequired),
                        SizedBox(height: 15.h,),
                        CustomInputWidget(myController: emailController, hint: 'Email', validation: isValidEmail),
                        SizedBox(height: 15.h,),
                        CustomPasswordInputWidget(
                          myController: passwordController, 
                          hint: 'Password', 
                          validation: passwordValidator, 
                          visible: isPassVisible,
                          toggler: togglePassVisibility
                        ),
                        SizedBox(height: 15.h,),
                        CustomPasswordInputWidget(
                          myController: confirmPasswordController, 
                          hint: 'Confirm password', 
                          validation: conPasswordValidator, 
                          visible: isConPassVisible,
                          toggler: toggleConPassVisibility
                        ),
                        SizedBox(height: 100.h,),
                        XtraLargeButton(title: 'Sign Up', callback: onSignUp)
                      ],
                    )
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}