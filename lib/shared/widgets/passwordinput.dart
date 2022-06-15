import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordInputWidget extends StatelessWidget {
  final TextEditingController myController;
  final String hint;
  final Function validation;
  final bool visible;
  final Function toggler;
  const CustomPasswordInputWidget({ Key? key, 
    required this.myController, 
    required this.hint, 
    required this.validation, 
    required this.visible, 
    required this.toggler
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: visible ? false : true,
      validator: (value) => validation(value),
      controller: myController,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          child: Icon( visible ? Icons.visibility_off : Icons.visibility),
          onTap: (){
            if(!visible){
              toggler(true);
            }
            else{
              toggler(false);
            }
          }
        ),
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