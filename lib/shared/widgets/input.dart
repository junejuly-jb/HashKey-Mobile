import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController myController;
  final String hint;
  final Function? validation;
  final bool autofocus;
  const CustomInputWidget({ Key? key, 
    required this.myController, 
    required this.hint, 
    required this.validation,
    required this.autofocus }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      validator: (val) => validation != null ? validation!(val) : null,
      controller: myController,
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
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
      ),
    );
  }
}