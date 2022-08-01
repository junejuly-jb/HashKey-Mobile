import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomPasswordInputWidget extends StatelessWidget {
  final TextEditingController myController;
  final String hint;
  final Function? validation;
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
    final theme = Provider.of<ThemeProvider>(context).theme;
    return TextFormField(
      style: TextStyle(
        color: theme == 'dark' ? Colors.white : Colors.black
      ),
      keyboardType: hint == 'Pin' ? TextInputType.number : TextInputType.text,
      maxLength: hint == 'Pin' ? 4 : null,
      obscureText: visible ? false : true,
      validator: (value) => validation != null ? validation!(value) : null,
      controller: myController,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: theme == 'dark' ? Colors.white : Colors.black
        ),
        suffixIcon: GestureDetector(
          child: Icon( 
            visible ? Icons.visibility_off : Icons.visibility,
            color: theme == 'dark' ? Colors.grey : Colors.black,
          ),
          onTap: () => toggler()
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