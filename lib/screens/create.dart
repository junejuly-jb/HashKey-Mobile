import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/forms/password.dart';
import 'package:hashkey/shared/widgets/appbar.dart';

class CreateNew extends StatelessWidget {
  const CreateNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as String;
    print(arg);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(241, 240, 247, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                children: [
                  SizedBox(height: 50.h,),
                  CustomHeader(title: 'Add New $arg', withBackButton: true),
                  SizedBox(height: 40.h,),
                  formType(arg)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget formType(String type){
  if(type == 'Password'){
    return const PasswordInput();
  }
  else{
    return Container();
  }
}