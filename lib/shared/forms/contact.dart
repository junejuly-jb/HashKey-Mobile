import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/shared/widgets/input.dart';

class ContactForm extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final TextEditingController controller4;
  const ContactForm({Key? key, required this.controller1, required this.controller2, required this.controller3, required this.controller4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
           children: [
            Expanded(
              flex: 1,
              child: CustomInputWidget(myController: controller1, hint: 'First Name', validation: null, autofocus: false, keyboardType: 'text',),
            ),
            SizedBox(width: 5.h,),
            Expanded(
              flex: 1,
              child: CustomInputWidget(myController: controller2, hint: 'First Name', validation: null, autofocus: false, keyboardType: 'text',),

            )
           ],
          ),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: controller3, hint: 'Phone number', validation: null, autofocus: false, keyboardType: 'number',),
          SizedBox(height: 15.h,),
          CustomInputWidget(myController: controller4, hint: 'Email', validation: null, autofocus: false, keyboardType: 'text',),
        ],
      ),
    );
  }
}