import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hashkey/provider/theme_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CustomAlert extends StatelessWidget {
  final String message;
  final String type;
  final String? statusType;
  final Function? callback;
  const CustomAlert({ Key? key, required this.message, required this.type, required this.statusType, required this.callback }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).theme;
    return AlertDialog(
      backgroundColor: theme == 'dark' ? const Color.fromRGBO(54, 54, 54, 1) : Colors.white,
      shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        child: widgetType(type, message, context, theme)
      ),
      actions: statusType == null ? null : [
        actionType(statusType, callback!)
      ],
    );
  }
}

Widget widgetType(String val, String message, BuildContext context, String theme){
  if(val == 'loading'){
    return Row(
      children: [
        LoadingAnimationWidget.threeRotatingDots(color: Colors.indigo, size: 40),
        SizedBox(width: 20.w,),
        Expanded(child: Text(message, style: TextStyle(color: theme == 'dark' ? Colors.white : Colors.black),))
      ],
    );
  }
  else if(val == 'success'){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 40,),
        SizedBox(height: 10.h,),
        Text(message, style: TextStyle(color: theme == 'dark' ? Colors.white : Colors.black))  
      ],
    );
  }
  else{
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 40,),
        SizedBox(height: 10.h,),
        Text(message, style: TextStyle(color: theme == 'dark' ? Colors.white : Colors.black))
      ],
    );
  }
}


Widget actionType(String? statusType, Function callback){
  if(statusType == 'error'){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: () => callback(), child: const Text('OK')),
      ],
    );
  }
  else{
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: () => callback(), child: const Text('OK')),
      ],
    );
  }
}