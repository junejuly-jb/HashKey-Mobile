import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({ Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp, letterSpacing: 2),),
        const Spacer(),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close))
      ],
    );
  }
}