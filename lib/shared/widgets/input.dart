import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController myController;
  final String hint;
  final Function? validation;
  final bool autofocus;
  final String keyboardType;
  const CustomInputWidget({ Key? key, 
    required this.myController, 
    required this.hint, 
    required this.validation,
    required this.autofocus, required this.keyboardType }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return TextFormField(
      maxLines: hint == 'Note' ? 12 : 1,
      keyboardType: keyboardType == 'number' ? TextInputType.number : TextInputType.text,
      style: TextStyle(
        color: theme == 'dark' ? Colors.white : Colors.black
      ),
      autofocus: autofocus,
      validator: (val) => validation != null ? validation!(val) : null,
      controller: myController,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: theme == 'dark' ? Colors.white : Colors.black
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
        fillColor: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 15.h)
      ),
    );
  }
}