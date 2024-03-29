import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:hashkey/provider/user_provider.dart';
import 'package:hashkey/services/auth.dart';
import 'package:hashkey/shared/widgets/alert.dart';
import 'package:hashkey/shared/widgets/large_buttons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/widgets/input.dart';
import '../shared/widgets/passwordinput.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  dynamic emailController = TextEditingController();
  dynamic passwordController = TextEditingController();
  bool isPassVisible = false;
  final _formKey = GlobalKey<FormState>();

  login() async{
    if(_formKey.currentState!.validate()){
      showDialog(barrierDismissible: false, context: context, builder: (_) => const CustomAlert(type: 'loading', message: 'Logging you in...', statusType: null, callback: null,));
      var result = await Auth().login(emailController.text, passwordController.text);
      if(result['success']){
        final prefs = await SharedPreferences.getInstance();
        final String? userData = prefs.getString('user');
        if(userData != null){
          await prefs.remove('user');
        }
        late String profileType;
        late String profile;
        if(result['user']['profile']['link']){
          profileType = 'link';
          profile = result['user']['profile']['link'];
        }
        else if(result['user']['profile']['profile_photo'].isNotEmpty){
          profileType = 'base64';
          profile = result['user']['profile']['profile_photo'];
        }
        else{
          profileType = 'initials';
          profile = result['user']['initials'];
        }
        Map user = {
          "token": result['token'],
          "refreshToken": result['refreshToken'],
          "name": result['user']['name'],
          "profileType": profileType,
          "profile": profile,
          "pin": result['user']['safety_pin'] == null ? false : true,
          "settings": {
            "pin": result['user']['user_settings']['ask_pin'],
            "timeout": result['user']['user_settings']['vault_timeout'],
            "timeoutAction": result['user']['user_settings']['vault_timeout_action'],
            "easyaccess": result['user']['user_settings']['easy_access'],
            "biometric": result['user']['user_settings']['biometric'],
          }
        };
        Provider.of<UserProvider>(context, listen: false).setUserDetails(user);
        await prefs.setString('user', jsonEncode(user));
        if(result['user']['safety_pin'] == null){
          Navigator.pushNamedAndRemoveUntil(context, '/addPin', (route) => false);
        }
        else{
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      }
      else{
        Navigator.pop(context);
        showDialog(barrierDismissible: false, context: context, builder: (_) => CustomAlert(type: 'error', message: result['message'], statusType: 'error', callback: () => Navigator.pop(context),));
      }
    }
  }

  passwordValidator(String? value){
    if(value!.length < 5){
      return 'Password is too short';
    }
    return null;  
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

  togglePassVisibility(){
    setState(() => isPassVisible = !isPassVisible);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                        Text('HASHKEY', style: Theme.of(context).textTheme.headlineLarge,)
                      ],
                    ),
                    SizedBox(height: 7.h,),
                    Center(child: Text('Your all in one vault for''\n your credentials.', textAlign: TextAlign.center, style: TextStyle(
                       fontSize: 16.sp,
                       color: theme == 'dark' ? Colors.grey : Colors.black,
                    ),)),
                    SizedBox(height: 34.h,),
                    Form(
                      key: _formKey,
                      child: Column(
                      children: [
                        CustomInputWidget(myController: emailController, hint: 'Email', validation: isValidEmail, autofocus: false, keyboardType: 'text',),
                        SizedBox(height: 15.h,),
                        CustomPasswordInputWidget(
                          myController: passwordController, 
                          hint: 'Password', 
                          validation: passwordValidator, 
                          visible: isPassVisible,
                          toggler: togglePassVisibility
                        ),
                      ],
                    )), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){}, child: Text('Forgot password?', style: TextStyle(fontSize: 12.sp, color: theme == 'dark' ? Colors.grey : Colors.grey[900]),)),
                      ],
                    ),
                    SizedBox(height: 35.h,),
                    XtraLargeButton(title: 'Login', isGradient: true, callback: login),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(child: Divider( thickness: 2, color: theme == 'dark' ? Colors.grey : Colors.grey[300])),
                        SizedBox(width: 8.w),
                        Text('or continue with', style: TextStyle(fontSize: 12.sp, color: theme == 'dark' ? Colors.grey : Colors.grey[700]),),
                        SizedBox(width: 8.w),
                        Expanded(child: Divider(thickness: 2, color: theme == 'dark' ? Colors.grey : Colors.grey[300]))
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
                            border: Border.all(color: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white, width: 3)
                          ),
                          child: Image.asset('lib/assets/icons/google.png'),
                        ),
                        SizedBox(width: 25.w,),
                        Container(
                          height: 66.h,
                          width: 81.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white, width: 3)
                          ),
                          child: Image.asset('lib/assets/icons/facebook.png'),
                        )
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('no account?', style: Theme.of(context).textTheme.subtitle1),
                        GestureDetector(onTap: () => Navigator.pushNamed(context, '/signup'), child: Text(' sign up here', style: TextStyle(fontSize: 12.sp, color: Colors.blue),)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}