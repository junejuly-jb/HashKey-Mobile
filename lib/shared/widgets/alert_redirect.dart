import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertWithRedirect extends StatelessWidget {
  final String message;
  final String redirect;
  const CustomAlertWithRedirect({ Key? key, required this.message, required this.redirect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 40,),
          SizedBox(height: 10.h,),
          Text(message),
        ],
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(redirect);
        }, child: Text('Okay'))
      ],
    );
  }
}
