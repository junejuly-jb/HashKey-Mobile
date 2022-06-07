import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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

  void onSignUp(){
    print(nameController.text);
    print(emailController.text);
    print(passwordController.text);
    print(confirmPasswordController.text);

    _formKey.currentState!.validate();
  }

  bool isValidEmail(String? email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.toString());
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
                          TextFormField(
                          validator: (val) => (val == null || val.isEmpty)
                            ? 'Please enter a name'
                            : null,
                          controller: nameController,
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
                            hintText: "Name",
                            contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        TextFormField(
                          validator: (val) => isValidEmail(val) ? null : 'Invalid email',
                          controller: emailController,
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
                        TextFormField(
                          obscureText: true,
                          validator: (value) => value!.length < 5 ? "password too short" : null,
                          controller: passwordController,
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
                        SizedBox(height: 15.h,),
                        TextFormField(
                          obscureText: true,
                          validator: (value) => value != passwordController.text ? "password mismatch" : null,
                          controller: confirmPasswordController,
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
                            hintText: "Confirm Password",
                            contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
                          ),
                        ),
                        SizedBox(height: 100.h,),
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
                              onPressed: () {
                                onSignUp();
                              }, 
                              child: Text('Sign up', style: TextStyle( fontSize: 15.sp, fontWeight: FontWeight.w700 ),),
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